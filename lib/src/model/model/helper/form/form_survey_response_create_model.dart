import 'package:equatable/equatable.dart';

class FormSurveyResponseCreateModel extends Equatable {
  final String surveyId;
  final String key;
  final String platform;

  const FormSurveyResponseCreateModel({
    required this.surveyId,
    required this.key,
    required this.platform,
  });

  @override
  List<Object> get props => [surveyId, key, platform];

  @override
  bool get stringify => true;
}
