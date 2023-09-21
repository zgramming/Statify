import 'package:equatable/equatable.dart';

class FormSurveyCreateOrUpdateModel extends Equatable {
  final String name;
  final String action;
  final String? template;

  const FormSurveyCreateOrUpdateModel({
    required this.name,
    required this.action,
    required this.template,
  });

  @override
  List<Object?> get props => [name, action, template];

  @override
  bool get stringify => true;
}
