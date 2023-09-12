// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_response_fail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResponseFailModel _$SurveyResponseFailModelFromJson(
        Map<String, dynamic> json) =>
    SurveyResponseFailModel(
      id: json['id'] as String,
      surveyId: json['survey_id'] as String,
      platform: json['platform'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyResponseFailModelToJson(
        SurveyResponseFailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_id': instance.surveyId,
      'platform': instance.platform,
      'key': instance.key,
      'value': instance.value,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

SurveyResponseFailSurvey _$SurveyResponseFailSurveyFromJson(
        Map<String, dynamic> json) =>
    SurveyResponseFailSurvey(
      id: json['id'] as String,
      machineId: json['machine_id'] as String,
      number: json['number'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      locked: json['locked'] as int,
      machine: SurveyResponseFailMachine.fromJson(
          json['machine'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SurveyResponseFailSurveyToJson(
        SurveyResponseFailSurvey instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'number': instance.number,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'locked': instance.locked,
      'machine': instance.machine,
    };

SurveyResponseFailMachine _$SurveyResponseFailMachineFromJson(
        Map<String, dynamic> json) =>
    SurveyResponseFailMachine(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      license: json['license'] as String,
      action: json['action'] as String,
      smsSetting: json['sms_setting'] as String,
      send: json['send'] as int,
      replied: json['replied'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyResponseFailMachineToJson(
        SurveyResponseFailMachine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'number': instance.number,
      'license': instance.license,
      'action': instance.action,
      'sms_setting': instance.smsSetting,
      'send': instance.send,
      'replied': instance.replied,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
