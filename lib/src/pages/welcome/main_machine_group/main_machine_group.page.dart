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
import '../../../model/model/machine_group/machine_group.model.dart';
import '../../../model/model/temporary_pending_response/temporary_pending_response.model.dart';
import '../../../router.dart';
import '../../../utils/constant.dart';
import '../../../utils/enum.dart';
import '../../../utils/event_channel.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../utils/styles.dart';
import '../../../view_model/custom_notifier/get_all_machine.notifier.dart';
import '../../../view_model/custom_notifier/get_alll_machine_group.notifier.dart';
import '../../../view_model/custom_notifier/get_application_config_by_key.notifier.dart';
import '../../../view_model/custom_notifier/listen_pending_response_notifier.dart';
import '../../../view_model/custom_notifier/log_listen_pending_response.notifier.dart';
import '../../../view_model/custom_provider/custom_provider.dart';
import '../../widgets/async_error_builder.dart';
import '../../widgets/circle_index_number.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/dialog_confirmation_delete.dart';
import '../../widgets/row_body.dart';
import 'widgets/alert_machine_not_have_group.dart';
import 'widgets/modal_add_machine_group_or_machine.dart';

class MainMachineGroupPage extends ConsumerStatefulWidget {
  const MainMachineGroupPage({super.key});

  @override
  ConsumerState<MainMachineGroupPage> createState() =>
      _MainMachineGroupPageState();
}

class _MainMachineGroupPageState extends ConsumerState<MainMachineGroupPage> {
  StreamSubscription<IncomingCallModel>? _subscriptionIncomingCall;
  StreamSubscription<IncomingSMSModel?>? _subscriptionIncomingMessage;
  StreamSubscription<ListenOnsentSMSModel>? _subscriptionSentMessage;
  StreamSubscription<List<TemporaryPendingResponseModel>>?
      _subscriptionTemporaryPendingResponse;

  final eventChannelUtils = EventChannelUtils();

  void onAdd() {
    // Show Modal Bottom Sheet to add new machine or machine group
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const ModalAddMachineGroupOrMachine(),
    );
  }

  void onEdit(MachineGroupModel item) {
    context.pushNamed(
      routeMachineGroupForm,
      pathParameters: {
        "id": item.id,
      },
    );
  }

  Future<void> onSelected(String value, MachineGroupModel item) async {
    final notifier = ref.read(machineGroupNotifier.notifier);
    switch (value) {
      case "edit":
        onEdit(item);
        break;
      case "delete":
        showDialog(
          context: context,
          builder: (context) => DialogDeleteConfirmation(
            onConfirm: () async {
              final result = await notifier.delete(machineGroupId: item.id);
              result.onDelete.whenOrNull(
                data: (data) {
                  if (data == null) return;

                  // close modal dialog
                  context.pop();

                  showSnackbar(
                    context: context,
                    message: "Delete Machine Group ${data.name} Success",
                    backgroundColor: Colors.green,
                  );

                  ref.invalidate(getAllMachineGroupFutureProvider);
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
      default:
        break;
    }
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
          log("Machine not have active survey id when listen incoming message : ${machine.id}");
          return;
          // throw Exception(
          //   "Machine not have active survey id when listen incoming message",
          // );
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

  void init() async {
    final autoRespondServerFuture = await ref.read(
        getApplicationConfigByKeyFutureProvider(kAutoRespondServer).future);
    final isActiveAutoResponseServer =
        (autoRespondServerFuture?.value ?? "true") == "true";

    if (isActiveAutoResponseServer) {
      listenIncomingCallV2();
      listenIncomingMessage();
      listenOnSentMessage();
      listenTemporaryPendingResponse();
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => init());
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
    final machinesNotHaveGroup =
        ref.watch(CustomProvider.getMachinesNotHaveGroup);

    return Stack(
      fit: StackFit.expand,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const CustomAppbar(title: "Machine List"),
            AlertMachinesNotHaveGroup(
              machinesNotHaveGroup: machinesNotHaveGroup,
            ),
            Expanded(
              child: Builder(
                builder: (context) {
                  final groupsAsync = ref
                      .watch(getAllMachineGroupFutureProvider)
                      .unwrapPrevious();

                  return groupsAsync.when(
                    data: (data) {
                      final groups = data.$1;
                      final machinesNotHaveGroup = data.$2;

                      return RefreshIndicator(
                        onRefresh: () async =>
                            ref.invalidate(getAllMachineGroupFutureProvider),
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            bottom: 80.0,
                          ),
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (groups.isEmpty &&
                                  machinesNotHaveGroup.isEmpty) ...[
                                const SizedBox(height: 16.0),
                                Center(
                                  child: Text(
                                    "No Machine Found, Please Add Machine",
                                    style: headerFont.copyWith(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                              if (groups.isNotEmpty) ...[
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: groups.length,
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) {
                                    return const Column(
                                      children: [
                                        SizedBox(height: 16.0),
                                        Divider(),
                                        SizedBox(height: 16.0),
                                      ],
                                    );
                                  },
                                  itemBuilder: (context, index) {
                                    final item = groups[index];
                                    final machines = item.machines ?? [];
                                    return Container(
                                      margin: const EdgeInsets.only(),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "Group : ${item.name}",
                                                    style:
                                                        bodyFontBold.copyWith(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            _MachineGroupMachines(
                                              machines: machines,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                              if (machinesNotHaveGroup.isNotEmpty) ...[
                                ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: machinesNotHaveGroup.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemBuilder: (context, index) {
                                    final item = machinesNotHaveGroup[index];
                                    return _MachineItem(
                                        item: item, index: index);
                                  },
                                ),
                              ]
                            ],
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) => AsyncErrorBuilder(
                      error: error.toString(),
                      onRetry: () =>
                          ref.invalidate(getAllMachineGroupFutureProvider),
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  );
                },
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              onPressed: onAdd,
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}

class _MachineGroupMachines extends StatelessWidget {
  const _MachineGroupMachines({
    Key? key,
    required this.machines,
  }) : super(key: key);
  final List<MachineModel> machines;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: machines.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final item = machines[index];
        return _MachineItem(item: item, index: index);
      },
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

      case "long_distance_access":
        context.pushNamed(
          routeMachineLongDistanceAccess,
          pathParameters: {
            "idMachine": item.id,
          },
        );
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleIndexNumber(
                                radius: 24.0,
                                index: widget.index,
                              ),
                              const SizedBox(height: 8.0),
                              ElevatedButton(
                                onPressed: onTapAPIExport,
                                style: elevatedButtonStyle(
                                  padding: const EdgeInsets.all(8),
                                  minimumSize: const Size(0, 32.0),
                                ),
                                child: Text(
                                  "API Export",
                                  style: bodyFont.copyWith(
                                    fontSize: 10.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 6.0,
                                    backgroundColor:
                                        isOffline ? Colors.grey : Colors.green,
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
                        const SizedBox(width: 8.0),
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
                                contentStyle: bodyFont.copyWith(fontSize: 14.0),
                                titleTrailing: [
                                  const SizedBox(width: 8.0),
                                  InkWell(
                                    onTap: () => onExport(
                                      ExportTypeEnum.totalReplied,
                                    ),
                                    child: const Icon(
                                      Icons.download,
                                      color: Colors.green,
                                      size: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              RowBody(
                                title: "Total SMS Replied",
                                content: "${item.summary?.totalSent ?? 0}",
                                titleFlex: 3,
                                contentFlex: 1,
                                titleStyle: bodyFont.copyWith(fontSize: 14.0),
                                contentStyle: bodyFont.copyWith(fontSize: 14.0),
                              ),
                              const SizedBox(height: 8.0),
                              RowBody(
                                title: "Total Voted",
                                content: "${item.summary?.totalVoted ?? 0}",
                                titleFlex: 3,
                                contentFlex: 1,
                                titleStyle: bodyFont.copyWith(fontSize: 14.0),
                                contentStyle: bodyFont.copyWith(fontSize: 14.0),
                                titleTrailing: [
                                  const SizedBox(width: 8.0),
                                  InkWell(
                                    onTap: () =>
                                        onExport(ExportTypeEnum.totalVoted),
                                    child: const Icon(
                                      Icons.download,
                                      color: Colors.green,
                                      size: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              RowBody(
                                title: "Total Finished",
                                content: "${item.summary?.totalFinished ?? 0}",
                                titleFlex: 3,
                                contentFlex: 1,
                                titleStyle: bodyFont.copyWith(fontSize: 14.0),
                                contentStyle: bodyFont.copyWith(fontSize: 14.0),
                                titleTrailing: [
                                  const SizedBox(width: 8.0),
                                  InkWell(
                                    onTap: () =>
                                        onExport(ExportTypeEnum.totalFinished),
                                    child: const Icon(
                                      Icons.download,
                                      color: Colors.green,
                                      size: 16.0,
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
                    value: "long_distance_access",
                    child: Text(
                      "Long Distance Control",
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
