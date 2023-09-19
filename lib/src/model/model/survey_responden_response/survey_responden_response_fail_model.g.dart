// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_responden_response_fail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyRespondenResponseFailModel _$SurveyRespondenResponseFailModelFromJson(
        Map<String, dynamic> json) =>
    SurveyRespondenResponseFailModel(
      id: json['id'] as String,
      surveyRespondentId: json['survey_respondent_id'] as String,
      platform: json['platform'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      finish: json['finish'] as bool,
    );

Map<String, dynamic> _$SurveyRespondenResponseFailModelToJson(
        SurveyRespondenResponseFailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_respondent_id': instance.surveyRespondentId,
      'platform': instance.platform,
      'key': instance.key,
      'value': instance.value,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'finish': instance.finish,
    };
