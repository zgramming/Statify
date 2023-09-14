import 'package:equatable/equatable.dart';

class FormSurveyResponseCreateModel extends Equatable {
  final String surveyId;
  final String key;
  final String type;
  final String platform;

  const FormSurveyResponseCreateModel({
    required this.surveyId,
    required this.key,
    required this.type,
    required this.platform,
  });

  @override
  List<Object> get props => [surveyId, key, type, platform];

  @override
  bool get stringify => true;
}
