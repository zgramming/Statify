// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_responden_create.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyRespondenCreateModel _$SurveyRespondenCreateModelFromJson(
        Map<String, dynamic> json) =>
    SurveyRespondenCreateModel(
      id: json['id'] as String,
      surveyRespondentId: json['survey_respondent_id'] as String,
      platform: json['platform'] as String,
      type: json['type'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
      status: json['status'] as String,
      finish: json['finish'] as bool,
      voting: json['voting'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyRespondenCreateModelToJson(
        SurveyRespondenCreateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_respondent_id': instance.surveyRespondentId,
      'platform': instance.platform,
      'type': instance.type,
      'key': instance.key,
      'value': instance.value,
      'status': instance.status,
      'finish': instance.finish,
      'voting': instance.voting,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
