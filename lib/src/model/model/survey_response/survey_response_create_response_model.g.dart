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
      key: json['key'] as String,
      value: json['value'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyResponseCreateResponseModelToJson(
        SurveyResponseCreateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_id': instance.surveyId,
      'key': instance.key,
      'value': instance.value,
      'status': instance.status,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
