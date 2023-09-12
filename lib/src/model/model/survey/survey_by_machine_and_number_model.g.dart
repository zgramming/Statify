// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_by_machine_and_number_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyByMachineAndNumberModel _$SurveyByMachineAndNumberModelFromJson(
        Map<String, dynamic> json) =>
    SurveyByMachineAndNumberModel(
      id: json['id'] as String,
      machineId: json['machine_id'] as String,
      number: json['number'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      locked: json['locked'] as bool,
    );

Map<String, dynamic> _$SurveyByMachineAndNumberModelToJson(
        SurveyByMachineAndNumberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'number': instance.number,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'locked': instance.locked,
    };
