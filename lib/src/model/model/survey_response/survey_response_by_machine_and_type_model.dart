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
  final bool finish;
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
    required this.finish,
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
      finish,
      createdAt,
      updatedAt,
      survey,
    ];
  }

  @override
  bool get stringify => true;
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
  final bool finish;
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
    required this.finish,
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
      finish,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
