import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../utils/event_channel.dart';

final listenIncomingMessageNotifier = AutoDisposeStreamProvider((ref) async* {
  final channel = EventChannelUtils();

  final stream = channel.listenIncomingSMS();

  stream.listen((event) {
    log("Incoming Message: $event");
  });

  // Initial Stream to trigger incoming message
  yield* Stream.value(null);

  final isUserAlreadySetupSIM = ref.watch(isUserAlreadySetupSIMProvider);

  if (!isUserAlreadySetupSIM) {
    throw Exception("User not yet setup SIM");
  }

  final incMessageNotifier = ref.watch(incomingMessageNotifier.notifier);
  final logNotifier = ref.watch(logIncomingMessageNotifier.notifier);

  stream.listen((event) async {
    if (event == null) {
      return;
    }

    final machines = ref.read(machineNotifier).onGetAll.valueOrNull ?? [];
    final user = ref.read(userNotifier).user;
    final phoneNumber =
        event.simSlot == 0 ? user?.sim1 ?? "" : user?.sim2 ?? "";
    final machine =
        machines.firstWhereOrNull((element) => element.number == phoneNumber);
    if (machine == null) {
      throw Exception("Machine not found when listen incoming message");
    }

    final result = await incMessageNotifier.handlingIncomingMessage(
      machineId: machine.id,
      number: event.address,
      message: event.body,
    );

    final (type, msg) = result;
    logNotifier.addLog(
      type: type,
      message: msg,
    );
  });

  yield stream;
});
