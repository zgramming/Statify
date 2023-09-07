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
  final String key;
  final String value;
  final String status;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SurveyResponseSurvey survey;

  const SurveyResponseByMachineAndTypeModel({
    required this.id,
    required this.surveyId,
    required this.key,
    required this.value,
    required this.status,
    required this.type,
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
      key,
      value,
      status,
      type,
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
    String? key,
    String? value,
    String? status,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    SurveyResponseSurvey? survey,
  }) {
    return SurveyResponseByMachineAndTypeModel(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      key: key ?? this.key,
      value: value ?? this.value,
      status: status ?? this.status,
      type: type ?? this.type,
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
  final String number;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int locked;
  const SurveyResponseSurvey({
    required this.id,
    required this.machineId,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
    required this.locked,
  });

  factory SurveyResponseSurvey.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseSurveyFromJson(json);

  /// Connect the generated [_$SurveyResponseSurveyToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyResponseSurveyToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      number,
      createdAt,
      updatedAt,
      locked,
    ];
  }

  @override
  bool get stringify => true;

  SurveyResponseSurvey copyWith({
    String? id,
    String? machineId,
    String? number,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? locked,
  }) {
    return SurveyResponseSurvey(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      number: number ?? this.number,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      locked: locked ?? this.locked,
    );
  }
}
