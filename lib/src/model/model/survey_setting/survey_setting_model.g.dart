// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveySettingModel _$SurveySettingModelFromJson(Map<String, dynamic> json) =>
    SurveySettingModel(
      id: json['id'] as String,
      surveyId: json['survey_id'] as String,
      platform:
          $enumDecode(_$MachineResponsePlatformEnumEnumMap, json['platform']),
      usePassword: json['use_password'] as bool,
      timeout: json['timeout'] as int,
      tries: json['tries'] as int,
      backoff: json['backoff'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveySettingModelToJson(SurveySettingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_id': instance.surveyId,
      'platform': _$MachineResponsePlatformEnumEnumMap[instance.platform]!,
      'use_password': instance.usePassword,
      'timeout': instance.timeout,
      'tries': instance.tries,
      'backoff': instance.backoff,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$MachineResponsePlatformEnumEnumMap = {
  MachineResponsePlatformEnum.whatsapp: 'whatsapp',
  MachineResponsePlatformEnum.sms: 'sms',
};
