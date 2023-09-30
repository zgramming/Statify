import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import 'get_all_machine.notifier.dart';

final getAllMachineGroupFutureProvider = AutoDisposeFutureProvider(
  (ref) async {
    final notifierMachineGroup = ref.watch(machineGroupNotifier.notifier);
    // Load Machine Group
    final result = await notifierMachineGroup.getAll();

    // Load Machine
    await ref.watch(getAllMachineFutureProvider.future);

    return result;
  },
);
