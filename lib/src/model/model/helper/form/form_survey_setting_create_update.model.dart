import 'package:equatable/equatable.dart';

class FormSurveySettingCreateUpdateModel extends Equatable {
  final bool usePassword;
  final int timeout;
  final int tries;
  final int backoff;

  const FormSurveySettingCreateUpdateModel({
    required this.usePassword,
    required this.timeout,
    required this.tries,
    required this.backoff,
  });

  @override
  List<Object> get props => [usePassword, timeout, tries, backoff];

  @override
  bool get stringify => true;

  FormSurveySettingCreateUpdateModel copyWith({
    bool? usePassword,
    int? timeout,
    int? tries,
    int? backoff,
  }) {
    return FormSurveySettingCreateUpdateModel(
      usePassword: usePassword ?? this.usePassword,
      timeout: timeout ?? this.timeout,
      tries: tries ?? this.tries,
      backoff: backoff ?? this.backoff,
    );
  }
}
