import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/helper/props_provider/props_get_machine_by_ip.model.dart';
import '../../model/model/machine/machine_model.dart';

final getMachineByIPFutureProvider =
    FutureProvider.family<MachineModel?, PropsGetMachineByIPModel>(
  (ref, props) async {
    final future = await ref.watch(machineNotifier.notifier).getByIP(
          machineId: props.machineId,
          ip: props.ip,
        );
    return future;
  },
);
