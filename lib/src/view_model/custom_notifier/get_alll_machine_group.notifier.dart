import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/machine/machine_model.dart';
import 'get_all_machine.notifier.dart';

final getAllMachineGroupFutureProvider = AutoDisposeFutureProvider(
  (ref) async {
    final notifierMachineGroup = ref.watch(machineGroupNotifier.notifier);

    // Load Machine Group
    final machineGroupState = await notifierMachineGroup.getAll();

    // Load Machine
    final machineState = await ref.watch(getAllMachineFutureProvider.future);
    final machines = machineState.items;
    final machineIds = machines.map((e) => e.id).toList();

    final machineGroup = machineGroupState.items;
    final machinesFromMachineGroup = machineGroup
        .expand((element) => element.machines ?? <MachineModel>[])
        .toList();
    final machineFromMachineGroupIds =
        machinesFromMachineGroup.map((e) => e.id).toList();

    final machineIdsNotInMachineGroup = machineIds
        .where((element) => !machineFromMachineGroupIds.contains(element))
        .toList();

    final List<MachineModel> machinesNotHaveGroup = machineIdsNotInMachineGroup
        .map((e) => machines.firstWhere((element) => element.id == e))
        .toList();

    return (machineGroup, machinesNotHaveGroup);
  },
);
