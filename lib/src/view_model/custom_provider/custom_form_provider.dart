import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/model/helper/form/form_survey_create_update.model.dart';

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
        name: "",
        action: "",
        template: "",
        sms: formSetting,
        wa: formSetting,
      );
    },
  );
}
