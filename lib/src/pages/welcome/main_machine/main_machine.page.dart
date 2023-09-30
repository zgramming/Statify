import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../injection.dart';
import '../../../model/model/incoming_call_model.dart';
import '../../../model/model/incoming_sms/incoming_sms.model.dart';
import '../../../model/model/listen_onsent_sms.model.dart';
import '../../../model/model/machine/machine_model.dart';
import '../../../model/model/temporary_pending_response/temporary_pending_response.model.dart';
import '../../../router.dart';
import '../../../utils/enum.dart';
import '../../../utils/event_channel.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';
import '../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../view_model/custom_notifier/listen_pending_response_notifier.dart';
import '../../../view_model/custom_notifier/log_listen_pending_response.notifier.dart';
import '../../../view_model/custom_provider/custom_provider.dart';
import '../../widgets/async_error_builder.dart';
import '../../widgets/circle_index_number.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/dialog_confirmation_delete.dart';
import '../../widgets/row_body.dart';

class MainMachinePage extends ConsumerStatefulWidget {
  const MainMachinePage({super.key});

  @override
  ConsumerState<MainMachinePage> createState() => _MainMachinePageState();
}

class _MainMachinePageState extends ConsumerState<MainMachinePage> {
  StreamSubscription<IncomingCallModel>? _subscriptionIncomingCall;
  StreamSubscription<IncomingSMSModel?>? _subscriptionIncomingMessage;
  StreamSubscription<ListenOnsentSMSModel>? _subscriptionSentMessage;
  StreamSubscription<List<TemporaryPendingResponseModel>>?
      _subscriptionTemporaryPendingResponse;

  final eventChannelUtils = EventChannelUtils();

  void onAdd() {
    context.pushNamed(routeMachineForm, pathParameters: {
      "id": "-1",
    });
  }

  Future<void> deleteTemporaryPendingResponse({
    required String surveyRespondenId,
    required LogListenPendingResponseNotifier logNotifier,
  }) async {
    final notifier = ref.read(temporaryPendingResponseNotifier.notifier);
    final result = await notifier.deleteAll();
    result.onDeleteBySurveyRespondenId.whenOrNull(
      data: (data) => logNotifier.addLog(
          "Delete Temporary Pending Response Success with Survey Responden ID : $surveyRespondenId"),
      error: (error, stackTrace) => log(error.toString()),
    );
  }

  void listenTemporaryPendingResponse() async {
    final notifier = ref.read(temporaryPendingResponseNotifier.notifier);
    _subscriptionTemporaryPendingResponse = notifier.listenNewChange().listen(
      (event) {
        log("Listen Temporary Pending Response:\n Length: ${event.length} | Data: $event");
      },
    );
  }

  void listenOnSentMessage() {
    _subscriptionSentMessage =
        eventChannelUtils.listenOnSentSMS().listen((event) async {
      final logNotifier = ref.read(logListenPendingResponseNotifier.notifier);
      final srvNotifier = ref.read(
          surveyRespondenResponseNotifier(event.surveyRespondenId).notifier);

      try {
        log("listenOnSentMessage event: $event");

        final surveyRespondenId = event.surveyRespondenId;
        final surveyRespondenResponseId = event.surveyRespondenResponseId;
        logNotifier.addLog(event.message);

        if (event.status) {
          final result = await srvNotifier.sent(
            surveyRespondenResponseId: surveyRespondenResponseId,
          );
          result.onSent.whenOrNull(
            data: (data) async {
              if (data == null) return;
              logNotifier.addLog("Survey Response Sent With Id: ${data.id}");

              // Delete Temporary Pending Response
              await deleteTemporaryPendingResponse(
                surveyRespondenId: surveyRespondenId,
                logNotifier: logNotifier,
              );
            },
            error: (error, stackTrace) => logNotifier.addLog(error.toString()),
          );
        } else {
          final result = await srvNotifier.fail(
            surveyRespondenResponseId: surveyRespondenResponseId,
          );
          result.onFail.whenOrNull(
            data: (data) async {
              if (data == null) return;
              logNotifier.addLog("Survey Response Fail With Id: ${data.id}");

              // Delete Temporary Pending Response
              await deleteTemporaryPendingResponse(
                surveyRespondenId: surveyRespondenId,
                logNotifier: logNotifier,
              );
            },
            error: (error, stackTrace) => logNotifier.addLog(error.toString()),
          );
        }
      } catch (e) {
        logNotifier.addLog(e.toString());
      }
    });
  }

  void listenIncomingMessage() {
    final logNotifier = ref.read(logIncomingMessageNotifier.notifier);
    _subscriptionIncomingMessage =
        eventChannelUtils.listenIncomingSMS().listen((event) async {
      try {
        log("Listen Incoming Message: $event");
        if (event == null) {
          return;
        }

        final machines = ref.read(machineNotifier).onGetAll.valueOrNull ?? [];
        final user = ref.read(userNotifier).user;
        final phoneNumber =
            event.simSlot == 0 ? user?.sim1 ?? "" : user?.sim2 ?? "";
        final machine = machines
            .firstWhereOrNull((element) => element.number == phoneNumber);
        if (machine == null) {
          throw Exception("Machine not found when listen incoming message");
        }

        final activeSurveyId = machine.activeSurveyId;

        if (activeSurveyId == null) {
          throw Exception(
            "Machine not have active survey id when listen incoming message",
          );
        }

        final result = await ref
            .read(incomingMessageNotifier.notifier)
            .handlingIncomingMessage(
              surveyId: activeSurveyId,
              number: event.address,
              message: event.body,
            );

        final (type, msg) = result;
        logNotifier.addLog(
          type: type,
          message: msg,
        );
      } catch (e) {
        logNotifier.addLog(
          type: "ERROR_TRY_CATCH",
          message: e.toString(),
        );
      }
    });
  }

  void listenIncomingCallV2() async {
    final logNotifier = ref.read(logIncomingCallNotifier.notifier);
    _subscriptionIncomingCall =
        eventChannelUtils.listenIncomingCall().listen((event) {
      log("Incoming Call $event");
      logNotifier.addLog(event);
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      listenIncomingCallV2();
      listenIncomingMessage();
      listenOnSentMessage();
      listenTemporaryPendingResponse();
    });
  }

  @override
  void dispose() {
    _subscriptionSentMessage?.cancel();
    _subscriptionIncomingMessage?.cancel();
    _subscriptionIncomingCall?.cancel();
    _subscriptionTemporaryPendingResponse?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEmptyAvailableSIM = ref.watch(CustomProvider.isEmptyAvailableSIM);
    final userId = ref.watch(userNotifier.select((value) => value.user?.id));
    if (isEmptyAvailableSIM) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "No Available SIM, Please Update SIM 1 / SIM 2 in User Profile",
                style: headerFont.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(
                    routeMyAccountFormPage,
                    pathParameters: {
                      "id": "$userId",
                    },
                  );
                },
                child: const Text("Update SIM 1 / SIM 2"),
              ),
            ],
          ),
        ),
      );
    }

    final machinesAsync = ref.watch(getAllMachineFutureProvider);
    return machinesAsync.when(
      data: (data) {
        final machines = data.items;

        return Stack(
          children: [
            Column(
              children: [
                const CustomAppbar(title: "Machine List"),
                // ElevatedButton(
                //   onPressed: () async {
                //     // Get file from folder asset
                //     // final file = await rootBundle.load(kURLLogoHitech);
                //     // final fileBytes = file.buffer.asUint8List();

                //     final methodChannel = MethodChannelUtils();
                //     const number = "085159412440";
                //     // const number = "089517229249";
                //     // const message =
                //     //     "Pentingnya menjaga keseimbangan dalam kehidupan tidak dapat diabaikan. Kita harus mengatur waktu dengan bijak antara pekerjaan, keluarga";
                //     // const message =
                //     //     "Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas ipsa nemo aspernatur asperiores! Error ipsa sunt voluptatibus ex iusto et perferendis aspernatur corrupti, enim unde. Delectus voluptate quisquam quas possimus?";
                //     const message = "ok";
                //     const model = SendSMSModel(
                //       phoneNumber: number,
                //       message: message,
                //       simSlot: 0,
                //       surveyResponseId: "",
                //     );
                //     await methodChannel.sendSMS(model);
                //   },
                //   child: const Text("Send SMS"),
                // ),
                Expanded(
                  child: Builder(builder: (context) {
                    if (machines.isEmpty) {
                      return Center(
                        child: Text(
                          "No Machine Found, Please Add Machine",
                          style: headerFont.copyWith(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async =>
                          ref.invalidate(getAllMachineFutureProvider),
                      child: ListView.separated(
                        itemCount: machines.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(16.0),
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          final item = machines[index];
                          return _MachineItem(item: item, index: index);
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: FloatingActionButton(
                onPressed: onAdd,
                child: const Icon(Icons.add),
              ),
            )
          ],
        );
      },
      error: (error, stackTrace) => AsyncErrorBuilder(
        error: error.toString(),
        onRetry: () => ref.invalidate(getAllMachineFutureProvider),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _MachineItem extends ConsumerStatefulWidget {
  const _MachineItem({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final MachineModel item;
  final int index;

  @override
  ConsumerState<_MachineItem> createState() => _MachineItemState();
}

class _MachineItemState extends ConsumerState<_MachineItem> {
  Future<void> onTapMachine() async {
    context.pushNamed(
      routeMachineForm,
      pathParameters: {
        "id": widget.item.id,
      },
    );
  }

  Future<void> onTapAPIExport() async {
    showSnackbar(
      context: context,
      message: "Coming Soon",
      backgroundColor: Colors.orange,
    );
  }

  Future<void> onExport(ExportTypeEnum type) async {
    final notifier = ref.read(machineNotifier.notifier);
    final result = await notifier.getExport(
      machineId: widget.item.id,
      type: type,
    );

    result.onGetExport.when(
      data: (data) async {
        if (data == null) return;

        try {
          final name = "machine_${widget.item.name}_${type.valueString}";
          final fileDownload = await placeFileToDownloadFolder(data, name);

          final url = fileDownload.path;

          if (!mounted) return;
          showSnackbar(
            context: context,
            message: "Success Exporting Machine, file saved at $url",
            backgroundColor: Colors.green,
          );
        } catch (e) {
          showSnackbar(
            context: context,
            message: e.toString(),
            backgroundColor: Colors.red,
          );
        }
      },
      error: (error, stackTrace) => showSnackbar(
        context: context,
        message: error.toString(),
        backgroundColor: Colors.red,
      ),
      loading: () => showSnackbar(
        context: context,
        message: "Exporting...",
        backgroundColor: Colors.blue,
      ),
    );
  }

  Future<void> onSelected(String value, MachineModel item) async {
    final notifier = ref.read(machineNotifier.notifier);
    switch (value) {
      case "delete":
        showDialog(
          context: context,
          builder: (context) => DialogDeleteConfirmation(
            onConfirm: () async {
              final result = await notifier.delete(machineId: item.id);
              result.onDelete.whenOrNull(
                data: (data) {
                  if (data == null) return;

                  // close modal dialog
                  context.pop();

                  showSnackbar(
                    context: context,
                    message: "Delete Machine ${data.name} Success",
                    backgroundColor: Colors.green,
                  );

                  ref.invalidate(getAllMachineFutureProvider);
                },
                error: (error, stackTrace) {
                  showSnackbar(
                    context: context,
                    message: error.toString(),
                    backgroundColor: Colors.red,
                  );
                },
              );
            },
          ),
        );
        break;

      case "edit":
        onTapMachine();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      listenPendingResponseNotifier(widget.item.id),
      (previous, next) {
        next.whenData((value) {
          if (value == null) return;
          final logNotifier =
              ref.read(logListenPendingResponseNotifier.notifier);
          logNotifier.addLog(value);
        });
      },
    );

    final item = widget.item;
    final sim1ORsim2 =
        ref.watch(CustomProvider.getSIM1orSIM2Provider(item.number));
    const radius = 30.0;
    final streamAsync = ref.watch(listenPendingResponseNotifier(item.id));

    final isOffline = item.status == MachineStatusEnum.offline;

    return streamAsync.when(
      data: (_) {
        return Stack(
          children: [
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: const BorderSide(color: Colors.grey, width: 1.0),
              ),
              margin: const EdgeInsets.only(),
              child: InkWell(
                onTap: onTapMachine,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Machine : ${item.name}",
                        style: bodyFontBold.copyWith(fontSize: 14.0),
                      ),
                      const SizedBox(height: 8.0),
                      RowBody(
                        title: "Machine Phone Number",
                        content: sim1ORsim2,
                        titleFlex: 2,
                        contentFlex: 1,
                        titleStyle: bodyFont.copyWith(fontSize: 14.0),
                        contentStyle: bodyFont.copyWith(fontSize: 14.0),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleIndexNumber(
                                    radius: radius, index: widget.index),
                                const SizedBox(height: 8.0),
                                ElevatedButton(
                                  onPressed: onTapAPIExport,
                                  style: elevatedButtonStyle(
                                    padding: const EdgeInsets.all(
                                      8.0,
                                    ),
                                  ),
                                  child: const Text("API Export"),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 6.0,
                                      backgroundColor: isOffline
                                          ? Colors.grey
                                          : Colors.green,
                                    ),
                                    const SizedBox(width: 4.0),
                                    Text(
                                      item.status.valueStringReadable,
                                      textAlign: TextAlign.center,
                                      style: bodyFont.copyWith(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RowBody(
                                  title: "Total Responden",
                                  content: "${item.summary?.totalReplied ?? 0}",
                                  titleFlex: 3,
                                  contentFlex: 1,
                                  titleStyle: bodyFont.copyWith(fontSize: 14.0),
                                  contentStyle:
                                      bodyFont.copyWith(fontSize: 14.0),
                                  titleTrailing: [
                                    const SizedBox(width: 8.0),
                                    InkWell(
                                      onTap: () => onExport(
                                        ExportTypeEnum.totalReplied,
                                      ),
                                      child: const Icon(
                                        Icons.download,
                                        color: Colors.green,
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                RowBody(
                                  title: "Total SMS Sent",
                                  content: "${item.summary?.totalSent ?? 0}",
                                  titleFlex: 3,
                                  contentFlex: 1,
                                  titleStyle: bodyFont.copyWith(fontSize: 14.0),
                                  contentStyle:
                                      bodyFont.copyWith(fontSize: 14.0),
                                ),
                                const SizedBox(height: 8.0),
                                RowBody(
                                  title: "Total Voted",
                                  content: "${item.summary?.totalVoted ?? 0}",
                                  titleFlex: 3,
                                  contentFlex: 1,
                                  titleStyle: bodyFont.copyWith(fontSize: 14.0),
                                  contentStyle:
                                      bodyFont.copyWith(fontSize: 14.0),
                                  titleTrailing: [
                                    const SizedBox(width: 8.0),
                                    InkWell(
                                      onTap: () =>
                                          onExport(ExportTypeEnum.totalVoted),
                                      child: const Icon(
                                        Icons.download,
                                        color: Colors.green,
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                RowBody(
                                  title: "Total Finished",
                                  content:
                                      "${item.summary?.totalFinished ?? 0}",
                                  titleFlex: 3,
                                  contentFlex: 1,
                                  titleStyle: bodyFont.copyWith(fontSize: 14.0),
                                  contentStyle:
                                      bodyFont.copyWith(fontSize: 14.0),
                                  titleTrailing: [
                                    const SizedBox(width: 8.0),
                                    InkWell(
                                      onTap: () => onExport(
                                          ExportTypeEnum.totalFinished),
                                      child: const Icon(
                                        Icons.download,
                                        color: Colors.green,
                                        size: 20.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: PopupMenuButton<String>(
                onSelected: (value) => onSelected(value, widget.item),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: "edit",
                    child: Text(
                      "Edit",
                      style: bodyFont.copyWith(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: "delete",
                    child: Text(
                      "Delete",
                      style: bodyFont.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
      error: (error, stackTrace) {
        return AsyncErrorBuilder(
          error: error.toString(),
          onRetry: () {
            ref.invalidate(listenPendingResponseNotifier(item.id));
          },
        );
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
