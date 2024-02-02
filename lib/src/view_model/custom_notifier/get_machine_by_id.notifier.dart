import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/machine/machine_model.dart';

final getMachineByIdFutureProvider =
    FutureProviderFamily<MachineModel?, String>(
  (ref, machineId) async {
    final future =
        await ref.watch(machineNotifier.notifier).getById(machineId: machineId);
    return future;
  },
);
