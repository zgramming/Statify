import 'package:equatable/equatable.dart';

class FormSurveyRespondenResponseCreateModel extends Equatable {
  final String surveyRespondenId;
  final String key;
  final String platform;

  const FormSurveyRespondenResponseCreateModel({
    required this.surveyRespondenId,
    required this.key,
    required this.platform,
  });

  @override
  List<Object> get props => [surveyRespondenId, key, platform];

  @override
  bool get stringify => true;
}
