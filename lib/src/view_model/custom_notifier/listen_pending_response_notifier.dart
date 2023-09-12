import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../utils/functions.dart';

final listenPendingResponseNotifier =
    AutoDisposeStreamProviderFamily<String?, String>((ref, machineId) {
  ref.onDispose(() {
    // Dispose stream

    ref.invalidateSelf();
  });
  final machines = ref.watch(machineNotifier).onGetAll.valueOrNull ?? [];

  final machine = machines.firstWhere(
    (element) => element.id == machineId,
    orElse: () => machines.first,
  );
  final simSlot = chooseSimSlotSMS(machine.smsSetting);

  final stream =
      ref.watch(surveyResponseNotifier.notifier).listenPendingResponse(
            machineId: machineId,
            simSlot: simSlot,
          );

  return stream;
});
