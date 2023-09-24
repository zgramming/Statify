// Custom Provider

import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/helper/dropdown/sim_choose_dropdown_model.dart';
import '../../model/model/helper/props/props_get_survey_response_grouping.model.dart';
import '../../model/model/machine/machine_model.dart';
import '../../model/model/machine_whatsapp/machine_whatsapp_model.dart';
import '../../model/model/survey_response/survey_response_model.dart';
import '../../utils/enum.dart';
import '../custom_notifier/get_all_whatsapp_by_user.notifier.dart';

class CustomProvider {
  static final getSurveyResponseGroupingSMS = Provider.family<
      Map<SurveyResponseTypeEnum, List<SurveyResponseModel>>,
      PropsSurveyResponseGrouping>((ref, props) {
    final items = ref
        .watch(surveyResponseNotifier(props.surveyId))
        .items
        .where((element) => element.platform == props.platform)
        .toList();
    final Map<SurveyResponseTypeEnum, List<SurveyResponseModel>> map = {};

    for (final item in items) {
      if (item.type == MachineResponseTypeEnum.regular) {
        map.update(
          SurveyResponseTypeEnum.yourAutoResponder,
          (value) => value..add(item),
          ifAbsent: () => [item],
        );
      } else {
        map.update(
          SurveyResponseTypeEnum.systemAutoResponder,
          (value) => value..add(item),
          ifAbsent: () => [item],
        );
      }
    }

    return map;
  });

  static final getMachineWhatsappById =
      Provider.autoDispose.family<MachineWhatsappModel?, String>((ref, id) {
    final items = ref.watch(getAllWhatsAppByUserFutureProvider).valueOrNull;
    // Get only list of MachineWhatsappModel
    final whatsapps = items?.values.expand((element) => element).toList();
    final result = whatsapps?.firstWhereOrNull((element) => element.id == id);
    return result;
  });

  static final getMachineByIdProvider = Provider.family<MachineModel?, String>(
    (ref, id) {
      final machines = ref.watch(machineNotifier).items;
      final result = machines.firstWhereOrNull((element) => element.id == id);
      return result;
    },
  );

  static final userChooseSIMMachineProvider =
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
      throw Exception(
          "Machine ${machine.name} number is not found in user sim. Current user SIM \n SIM 1: ${user.sim1} \n SIM 2: ${user.sim2} \n Machine number is ${machine.number} ");
    }

    return simSlot;
  });

  static final isEmptyAvailableSIM = Provider((ref) {
    final items = ref.watch(getAvailableSIM);
    return items.isEmpty;
  });

  static final getSIM1orSIM2Provider =
      Provider.family<String, String>((ref, phoneNumber) {
    final availableSIM = ref.watch(getAvailableSIM);
    final choosenNumber = availableSIM.firstWhereOrNull(
      (element) => element.value == phoneNumber,
    );
    return choosenNumber?.label ?? "";
  });

  static final getAvailableSIM = Provider(
    (ref) {
      final user = ref.watch(userNotifier.select((value) => value.user));
      final isExistsSIM1 =
          user?.sim1 != null && (user?.sim1?.isNotEmpty ?? false);
      final isExistsSIM2 =
          user?.sim2 != null && (user?.sim2?.isNotEmpty ?? false);
      final List<SimChooseDropdownModel> items = [
        if (isExistsSIM1)
          SimChooseDropdownModel(label: "SIM 1", value: "${user?.sim1}"),
        if (isExistsSIM2)
          SimChooseDropdownModel(label: "SIM 2", value: "${user?.sim2}"),
      ];
      return items;
    },
  );
}



// End Custom Provider