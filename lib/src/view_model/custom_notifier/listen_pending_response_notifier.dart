import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';

final listenPendingResponseNotifier =
    AutoDisposeStreamProviderFamily<String?, String>((ref, machineId) {
  final simSlot = ref.watch(userChooseSIMMachineProvider(machineId));

  final stream = ref
      .watch(surveyResponseNotifier.notifier)
      .listenPendingResponse(machineId: machineId, simSlot: simSlot);

  return stream;
});
