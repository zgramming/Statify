// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_response_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResponseCreateResponseModel _$SurveyResponseCreateResponseModelFromJson(
        Map<String, dynamic> json) =>
    SurveyResponseCreateResponseModel(
      id: json['id'] as String,
      surveyId: json['survey_id'] as String,
      platform: json['platform'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
      status: json['status'] as String,
      finish: json['finish'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyResponseCreateResponseModelToJson(
        SurveyResponseCreateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_id': instance.surveyId,
      'platform': instance.platform,
      'key': instance.key,
      'value': instance.value,
      'status': instance.status,
      'finish': instance.finish,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
