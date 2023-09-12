// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response_by_machine_and_type_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseByMachineAndTypeModel extends Equatable {
  final String id;
  final String surveyId;
  final String platform;
  final String key;
  final String value;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SurveyResponseSurvey survey;

  const SurveyResponseByMachineAndTypeModel({
    required this.id,
    required this.surveyId,
    required this.platform,
    required this.key,
    required this.value,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.survey,
  });

  factory SurveyResponseByMachineAndTypeModel.fromJson(
          Map<String, dynamic> json) =>
      _$SurveyResponseByMachineAndTypeModelFromJson(json);

  /// Connect the generated [_$SurveyResponseByMachineAndTypeModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$SurveyResponseByMachineAndTypeModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      surveyId,
      platform,
      key,
      value,
      status,
      createdAt,
      updatedAt,
      survey,
    ];
  }

  @override
  bool get stringify => true;

  SurveyResponseByMachineAndTypeModel copyWith({
    String? id,
    String? surveyId,
    String? platform,
    String? key,
    String? value,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    SurveyResponseSurvey? survey,
  }) {
    return SurveyResponseByMachineAndTypeModel(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      platform: platform ?? this.platform,
      key: key ?? this.key,
      value: value ?? this.value,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      survey: survey ?? this.survey,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseSurvey extends Equatable {
  final String id;
  final String machineId;
  final String? machineWhatsappId;
  final String number;
  final bool locked;
  final int attempt;
  final DateTime? bannedUntil;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SurveyResponseSurvey({
    required this.id,
    required this.machineId,
    this.machineWhatsappId,
    required this.number,
    required this.locked,
    required this.attempt,
    this.bannedUntil,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyResponseSurvey.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseSurveyFromJson(json);

  /// Connect the generated [_$SurveyResponseSurveyToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyResponseSurveyToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      machineId,
      machineWhatsappId,
      number,
      locked,
      attempt,
      bannedUntil,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  SurveyResponseSurvey copyWith({
    String? id,
    String? machineId,
    String? machineWhatsappId,
    String? number,
    bool? locked,
    int? attempt,
    DateTime? bannedUntil,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SurveyResponseSurvey(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      machineWhatsappId: machineWhatsappId ?? this.machineWhatsappId,
      number: number ?? this.number,
      locked: locked ?? this.locked,
      attempt: attempt ?? this.attempt,
      bannedUntil: bannedUntil ?? this.bannedUntil,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
