import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../model/model/incoming_call_model.dart';
import '../../../model/model/incoming_sms/incoming_sms.model.dart';
import '../../../model/model/listen_onsent_sms.model.dart';
import '../../../model/model/machine/machine_model.dart';
import '../../../model/model/temporary_pending_response/temporary_pending_response.model.dart';
import '../../../utils/event_channel.dart';
import '../../../utils/fonts.dart';
import '../../../view_model/custom_notifier/log_listen_pending_response.notifier.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  StreamSubscription<IncomingCallModel>? _subscriptionIncomingCall;
  StreamSubscription<IncomingSMSModel?>? _subscriptionIncomingMessage;
  StreamSubscription<ListenOnsentSMSModel>? _subscriptionSentMessage;
  StreamSubscription<List<TemporaryPendingResponseModel>>?
      _subscriptionTemporaryPendingResponse;

  final eventChannelUtils = EventChannelUtils();

  Future<void> deleteTemporaryPendingResponse({
    required String surveyResponseId,
    required LogListenPendingResponseNotifier logNotifier,
  }) async {
    final notifier = ref.read(temporaryPendingResponseNotifier.notifier);
    final result = await notifier.deleteAll();
    result.onDeleteBySurveyResponseId.whenOrNull(
      data: (data) => logNotifier.addLog(
          "Delete Temporary Pending Response Success with id $surveyResponseId"),
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
    final logNotifier = ref.read(logListenPendingResponseNotifier.notifier);
    final srvNotifier = ref.read(surveyRespondenResponseNotifier.notifier);
    _subscriptionSentMessage =
        eventChannelUtils.listenOnSentSMS().listen((event) async {
      try {
        log("listenOnSentMessage event: $event");
        final surveyResponseId = event.surveyResponseId;
        if (surveyResponseId.isEmpty) return;
        logNotifier.addLog(event.message);

        if (event.status) {
          final result = await srvNotifier.sent(surveyResponseId);
          result.onSent.whenOrNull(
            data: (data) async {
              if (data == null) return;
              logNotifier.addLog("Survey Response Sent With Id: ${data.id}");

              // Delete Temporary Pending Response
              await deleteTemporaryPendingResponse(
                  surveyResponseId: surveyResponseId, logNotifier: logNotifier);
            },
            error: (error, stackTrace) => logNotifier.addLog(error.toString()),
          );
        } else {
          final result = await srvNotifier.fail(surveyResponseId);
          result.onFail.whenOrNull(
            data: (data) async {
              if (data == null) return;
              logNotifier.addLog("Survey Response Fail With Id: ${data.id}");

              // Delete Temporary Pending Response
              await deleteTemporaryPendingResponse(
                surveyResponseId: surveyResponseId,
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

        final result = await ref
            .read(incomingMessageNotifier.notifier)
            .handlingIncomingMessage(
              machineId: machine.id,
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
    log("DISPOSE AT HOME PAGE");
    _subscriptionSentMessage?.cancel();
    _subscriptionIncomingMessage?.cancel();
    _subscriptionIncomingCall?.cancel();
    _subscriptionTemporaryPendingResponse?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final machines = ref.watch(machineNotifier).onGetAll.valueOrNull ?? [];

    if (machines.isEmpty) {
      return Center(
        child: Text(
          "No Machine",
          style: headerFont.copyWith(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return Column(
      children: [
        const CustomAppbar(title: "Home"),
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
          child: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(machineNotifier);
            },
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
          ),
        ),
      ],
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
  StreamSubscription<String?>? _subscriptionPendingResponse;

  final eventChannelUtils = EventChannelUtils();

  void listenPendingResponse() async {
    final simSlot = ref.read(userChooseSIMMachineProvider(widget.item.id));
    final logNotifier = ref.read(logListenPendingResponseNotifier.notifier);
    final srvResponseNotifier =
        ref.read(surveyRespondenResponseNotifier.notifier);
    _subscriptionPendingResponse = srvResponseNotifier
        .listenPendingResponse(machineId: widget.item.id, simSlot: simSlot)
        .listen((event) {
      log("Listen Pending Response: $event");
      if (event == null) {
        return;
      }

      // Add Log to Log Listen Pending Response
      logNotifier.addLog(event);
    });
  }

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      listenPendingResponse();
    });
  }

  @override
  void dispose() {
    log("DISPOSE AT MACHINE ITEM");
    _subscriptionPendingResponse?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 8.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "${widget.index + 1}. ${widget.item.number}",
                style: headerFont.copyWith(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RowBody(
                    title: "SMS Sent",
                    content: "${widget.item.send}",
                    titleFlex: 2,
                    contentFlex: 1,
                  ),
                  const SizedBox(height: 8.0),
                  RowBody(
                    title: "Total Reply",
                    content: "${widget.item.replied}",
                    titleFlex: 2,
                    contentFlex: 1,
                  ),
                  const SizedBox(height: 8.0),
                  const RowBody(
                    title: "Total Finished",
                    content: "0",
                    titleFlex: 2,
                    contentFlex: 1,
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
