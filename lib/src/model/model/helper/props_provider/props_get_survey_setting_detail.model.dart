import 'package:equatable/equatable.dart';

class PropsGetSurveySettingDetail extends Equatable {
  final String surveyId;
  final String settingId;
  const PropsGetSurveySettingDetail({
    required this.surveyId,
    required this.settingId,
  });

  @override
  List<Object> get props => [surveyId, settingId];

  @override
  bool get stringify => true;
}
