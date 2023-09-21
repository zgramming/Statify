// Custom Provider
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/helper/dropdown/sim_choose_dropdown_model.dart';
import '../../model/model/machine/machine_model.dart';
import '../../model/model/machine_whatsapp/machine_whatsapp_model.dart';

final getActiveSurveyIdByMachineId = ProviderFamily((ref, machineId) {
  final machines = ref.watch(machineNotifier).items;
  final machine =
      machines.firstWhereOrNull((element) => element.id == machineId);
  final activeSurveyId = machine?.activeSurveyId;
  return activeSurveyId;
});

final userChooseSIMMachineProvider =
    ProviderFamily<int, String>((ref, machineId) {
  final machines = ref.watch(machineNotifier).items;

  final machine = machines.firstWhere(
    (element) => element.id == machineId,
    orElse: () => machines.first,
  );

  final user = ref.watch(userNotifier).user;
  if (user == null) throw Exception('User is null');

  int simSlot = -1;
  if (machine.number == user.sim1) {
    simSlot = 0;
  } else if (machine.number == user.sim2) {
    simSlot = 1;
  } else {
    throw Exception('Machine number is not found in user sim');
  }

  return simSlot;
});

final isUserAlreadySetupSIMProvider = Provider((ref) {
  final user = ref.watch(userNotifier.select((value) => value.user));
  final isExistsSIM1 = user?.sim1 != null && (user?.sim1?.isNotEmpty ?? false);
  final isExistsSIM2 = user?.sim2 != null && (user?.sim2?.isNotEmpty ?? false);
  return isExistsSIM1 || isExistsSIM2;
});

final isEmptyAvailableSIM = Provider((ref) {
  final items = ref.watch(getAvailableSIM);
  return items.isEmpty;
});

final getSIM1orSIM2Provider =
    Provider.family<String, String>((ref, phoneNumber) {
  final availableSIM = ref.watch(getAvailableSIM);
  final choosenNumber = availableSIM.firstWhereOrNull(
    (element) => element.value == phoneNumber,
  );
  return choosenNumber?.label ?? "";
});

final getAvailableSIM = Provider((ref) {
  final user = ref.watch(userNotifier.select((value) => value.user));
  final isExistsSIM1 = user?.sim1 != null && (user?.sim1?.isNotEmpty ?? false);
  final isExistsSIM2 = user?.sim2 != null && (user?.sim2?.isNotEmpty ?? false);
  final List<SimChooseDropdownModel> items = [
    if (isExistsSIM1)
      SimChooseDropdownModel(label: "SIM 1", value: "${user?.sim1}"),
    if (isExistsSIM2)
      SimChooseDropdownModel(label: "SIM 2", value: "${user?.sim2}"),
  ];
  return items;
});

final getOnlyWhatsAppMachine = Provider((ref) {
  final machines = ref.watch(machineNotifier).items;
  final result = machines.map((e) => e.whatsapps).toList();
  final flatten = result.expand((element) => element).toList();
  return flatten;
});

final getMachineWhatsApp =
    Provider.family<List<MachineWhatsappModel>, String>((ref, machineId) {
  final machines = ref.watch(machineNotifier).items;

  final result =
      machines.firstWhereOrNull((element) => element.id == machineId);
  final whatsapps = result?.whatsapps ?? [];
  return whatsapps;
});

final getMachineByIdProvider = Provider.family<MachineModel?, String>(
  (ref, id) {
    final machines = ref.watch(machineNotifier).items;
    final result = machines.firstWhereOrNull((element) => element.id == id);
    return result;
  },
);
// End Custom Provider