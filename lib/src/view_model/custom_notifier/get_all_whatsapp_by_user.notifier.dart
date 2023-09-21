import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/machine/machine_model.dart';
import '../../model/model/machine_whatsapp/machine_whatsapp_model.dart';
import 'get_all_machine.notifier.dart';

final getAllWhatsAppByUserFutureProvider =
    AutoDisposeFutureProvider<Map<MachineModel, List<MachineWhatsappModel>>>(
        (ref) async {
  final userId = ref.watch(userNotifier.select((value) => value.user))?.id;
  final whatsappAsync =
      await ref.watch(userNotifier.notifier).getAllWhatsApps(userId!);

  final whatsapps = whatsappAsync.onGetAllWhatsApps.valueOrNull ?? [];
  final whatsappsGroupByMachine =
      groupBy(whatsapps, (survey) => survey.machineId);

  final machineAsync = await ref.watch(getAllMachineFutureProvider.future);
  final machines = machineAsync.items;

  final mapping = whatsappsGroupByMachine
      .map<MachineModel, List<MachineWhatsappModel>>((key, value) {
    final machine = machines.firstWhere((element) => element.id == key);
    final values = value;
    return MapEntry(machine, values);
  });

  return mapping;
});
