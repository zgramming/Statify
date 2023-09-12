// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_response_by_machine_and_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResponseByMachineAndTypeModel
    _$SurveyResponseByMachineAndTypeModelFromJson(Map<String, dynamic> json) =>
        SurveyResponseByMachineAndTypeModel(
          id: json['id'] as String,
          surveyId: json['survey_id'] as String,
          platform: json['platform'] as String,
          key: json['key'] as String,
          value: json['value'] as String,
          status: json['status'] as String,
          createdAt: DateTime.parse(json['created_at'] as String),
          updatedAt: DateTime.parse(json['updated_at'] as String),
          survey: SurveyResponseSurvey.fromJson(
              json['survey'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$SurveyResponseByMachineAndTypeModelToJson(
        SurveyResponseByMachineAndTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_id': instance.surveyId,
      'platform': instance.platform,
      'key': instance.key,
      'value': instance.value,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'survey': instance.survey,
    };

SurveyResponseSurvey _$SurveyResponseSurveyFromJson(
        Map<String, dynamic> json) =>
    SurveyResponseSurvey(
      id: json['id'] as String,
      machineId: json['machine_id'] as String,
      machineWhatsappId: json['machine_whatsapp_id'] as String?,
      number: json['number'] as String,
      locked: json['locked'] as bool,
      attempt: json['attempt'] as int,
      bannedUntil: json['banned_until'] == null
          ? null
          : DateTime.parse(json['banned_until'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyResponseSurveyToJson(
        SurveyResponseSurvey instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'machine_whatsapp_id': instance.machineWhatsappId,
      'number': instance.number,
      'locked': instance.locked,
      'attempt': instance.attempt,
      'banned_until': instance.bannedUntil?.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
