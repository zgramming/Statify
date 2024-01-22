import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../injection.dart';
import '../../model/model/helper/props_provider/props_get_survey_setting_detail.model.dart';
import '../../model/model/survey_setting/survey_setting_model.dart';

final getSurveySettingDetailNotifier = AutoDisposeFutureProviderFamily<
    SurveySettingModel?, PropsGetSurveySettingDetail>(
  (ref, props) async {
    final result = await ref
        .watch(surveySettingNotifier(props.surveyId).notifier)
        .getById(settingId: props.settingId);
    final setting = result.onGetById.valueOrNull;
    return setting;
  },
);
