// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class FormSurveyCreateOrUpdateWAorSMSBotModel extends Equatable {
  final String settingId;
  final bool usePassword;
  final int timeout;
  final int backoff;
  final int tries;
  const FormSurveyCreateOrUpdateWAorSMSBotModel({
    required this.settingId,
    required this.usePassword,
    required this.timeout,
    required this.backoff,
    required this.tries,
  });

  @override
  List<Object> get props {
    return [
      settingId,
      usePassword,
      timeout,
      backoff,
      tries,
    ];
  }

  @override
  bool get stringify => true;

  FormSurveyCreateOrUpdateWAorSMSBotModel copyWith({
    String? settingId,
    bool? usePassword,
    int? timeout,
    int? backoff,
    int? tries,
  }) {
    return FormSurveyCreateOrUpdateWAorSMSBotModel(
      settingId: settingId ?? this.settingId,
      usePassword: usePassword ?? this.usePassword,
      timeout: timeout ?? this.timeout,
      backoff: backoff ?? this.backoff,
      tries: tries ?? this.tries,
    );
  }
}

class FormSurveyCreateOrUpdateModel extends Equatable {
  final String name;
  final String action;
  final String? template;
  final FormSurveyCreateOrUpdateWAorSMSBotModel? wa;
  final FormSurveyCreateOrUpdateWAorSMSBotModel? sms;

  const FormSurveyCreateOrUpdateModel({
    required this.name,
    required this.action,
    required this.template,
    this.wa,
    this.sms,
  });

  @override
  List<Object?> get props {
    return [
      name,
      action,
      template,
      wa,
      sms,
    ];
  }

  @override
  bool get stringify => true;

  FormSurveyCreateOrUpdateModel copyWith({
    String? name,
    String? action,
    String? template,
    FormSurveyCreateOrUpdateWAorSMSBotModel? wa,
    FormSurveyCreateOrUpdateWAorSMSBotModel? sms,
  }) {
    return FormSurveyCreateOrUpdateModel(
      name: name ?? this.name,
      action: action ?? this.action,
      template: template ?? this.template,
      wa: wa ?? this.wa,
      sms: sms ?? this.sms,
    );
  }
}
