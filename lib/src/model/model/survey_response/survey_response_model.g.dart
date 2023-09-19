// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResponseModel _$SurveyResponseModelFromJson(Map<String, dynamic> json) =>
    SurveyResponseModel(
      id: json['id'] as String,
      surveyId: json['survey_id'] as String,
      platform:
          $enumDecode(_$MachineResponsePlatformEnumEnumMap, json['platform']),
      key: json['key'] as String,
      value: json['value'] as String,
      type: json['type'] as String,
      voting: json['voting'] as bool,
      finish: json['finish'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyResponseModelToJson(
        SurveyResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_id': instance.surveyId,
      'platform': _$MachineResponsePlatformEnumEnumMap[instance.platform]!,
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
      'voting': instance.voting,
      'finish': instance.finish,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$MachineResponsePlatformEnumEnumMap = {
  MachineResponsePlatformEnum.whatsapp: 'whatsapp',
  MachineResponsePlatformEnum.sms: 'sms',
};
