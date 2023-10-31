import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/helper/form/form_machine_config_country_mnc.model.dart';
import '../../model/model/helper/form/form_machine_update_config.model.dart';
import '../../model/model/helper/form/form_survey_create_update.model.dart';
import 'custom_provider.dart';

class CustomFormProvider {
  static final surveyForm = StateProvider<FormSurveyCreateOrUpdateModel>(
    (ref) {
      const formSetting = FormSurveyCreateOrUpdateWAorSMSBotModel(
        settingId: "",
        usePassword: false,
        timeout: 0,
        backoff: 0,
        tries: 0,
      );

      return const FormSurveyCreateOrUpdateModel(
        idMachine: "",
        name: "",
        action: "",
        template: "",
        sms: formSetting,
        wa: formSetting,
      );
    },
  );

  static final ldaSMSForm =
      StateProvider.family<FormMachineUpdateConfigModel, String>(
    (ref, idMachine) {
      final machine =
          ref.watch(CustomProvider.getMachineByIdProvider(idMachine));
      final config = machine?.config;

      if (config == null) {
        return const FormMachineUpdateConfigModel(
          machineId: "",
          count: 0,
          taskCount: 0,
          isReboot: false,
        );
      }

      return FormMachineUpdateConfigModel.fromMachineConfigModel(
        idMachine,
        config,
      );
    },
  );

  static final ldaSettingForm =
      StateProvider.family<FormMachineUpdateConfigModel, String>(
          (ref, idMachine) {
    final machine = ref.watch(CustomProvider.getMachineByIdProvider(idMachine));
    final config = machine?.config;

    if (config == null) {
      return const FormMachineUpdateConfigModel(
        machineId: "",
        count: 0,
        taskCount: 0,
        isReboot: false,
      );
    }

    return FormMachineUpdateConfigModel.fromMachineConfigModel(
      idMachine,
      config,
    );
  });

  static final machineConfigCountries =
      StateProvider<List<FormMachineConfigCountryMnc>>(
    (ref) => [],
  );
}
