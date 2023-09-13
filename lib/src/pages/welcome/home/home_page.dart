import 'dart:async';
import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../injection.dart';
import '../../../model/model/incoming_sms/incoming_sms.model.dart';
import '../../../model/model/machine/machine_model.dart';
import '../../../utils/event_channel.dart';
import '../../../utils/flutter_local_notification.dart';
import '../../../utils/fonts.dart';
import '../../../utils/functions.dart';
import '../../../view_model/custom_notifier/listen_pending_response_notifier.dart';
import '../../widgets/async_error_builder.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/row_body.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  StreamSubscription<IncomingSMSModel>? _subscriptionIncomingSMS;

  void listenIncomingSMSV2() async {
    final phoneSetting =
        ref.read(phoneNumberSettingNotifier).onGetFirst.valueOrNull;
    if (phoneSetting == null) {
      FlutterLocalNotificationUtils().showNotification(
        title: "Tracking Incoming SMS Pending",
        body: "Please set phone number first",
        payload: "Error",
      );
      return;
    }

    FlutterLocalNotificationUtils().showNotification(
      title: "Tracking Incoming SMS Active",
      body: "Every incoming SMS will be tracked",
      payload: "Success",
    );

    final notifier = ref.read(incomingMessageNotifier.notifier);
    _subscriptionIncomingSMS =
        EventChannelUtils().listenIncomingSMS().listen((event) async {
      log("Incoming SMS: $event");
      final smsSetting = chooseSMSSettingfromSIMSlot(event.simSlot);
      final machines = ref.read(machineNotifier).onGetAll.valueOrNull ?? [];
      final machine = machines
          .firstWhereOrNull((element) => element.smsSetting == smsSetting);

      if (machine == null) {
        log("Machine not found then incoming message will be ignored");
        return;
      }

      final result = await notifier.handlingIncomingMessage(
        machineId: machine.id,
        number: event.address,
        message: event.body,
      );

      // add log to log incoming message
      final (type, msg) = result;
      ref.read(logIncomingMessageNotifier.notifier).addLog(
            message: msg,
            type: type,
          );

      log("Handling Incoming Message Result: $result");
    });
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      listenIncomingSMSV2();
    });
  }

  @override
  void dispose() {
    _subscriptionIncomingSMS?.cancel();
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

class _MachineItem extends ConsumerWidget {
  const _MachineItem({
    Key? key,
    required this.item,
    required this.index,
  }) : super(key: key);

  final MachineModel item;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(listenPendingResponseNotifier(item.id), (previous, next) {
      next.whenData((value) {
        if (value == null) return;

        // Add Log to Log Listen Pending Response
        ref.read(logListenPendingResponseNotifier.notifier).addLog(value);
      });
    });

    final streamAsync = ref.watch(listenPendingResponseNotifier(item.id));
    return streamAsync.when(
      data: (data) => Card(
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
                  "${index + 1}. ${item.number}",
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
                      content: "${item.send}",
                      titleFlex: 2,
                      contentFlex: 1,
                    ),
                    const SizedBox(height: 8.0),
                    RowBody(
                      title: "Total Reply",
                      content: "${item.replied}",
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
      ),
      error: (error, stackTrace) => AsyncErrorBuilder(
        error: error.toString(),
        onRetry: () => ref.invalidate(listenPendingResponseNotifier(item.id)),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
