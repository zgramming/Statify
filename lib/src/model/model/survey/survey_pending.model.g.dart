// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_pending.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyPendingModel _$SurveyPendingModelFromJson(Map<String, dynamic> json) =>
    SurveyPendingModel(
      id: json['id'] as String,
      surveyRespondentId: json['survey_respondent_id'] as String,
      platform: json['platform'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
      status: json['status'] as String,
      finish: json['finish'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      respondent: SurveyPendingRespondenModel.fromJson(
          json['respondent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SurveyPendingModelToJson(SurveyPendingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_respondent_id': instance.surveyRespondentId,
      'platform': instance.platform,
      'key': instance.key,
      'value': instance.value,
      'status': instance.status,
      'finish': instance.finish,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'respondent': instance.respondent,
    };

SurveyPendingRespondenModel _$SurveyPendingRespondenModelFromJson(
        Map<String, dynamic> json) =>
    SurveyPendingRespondenModel(
      id: json['id'] as String,
      surveyId: json['survey_id'] as String,
      machineWhatsappId: json['machine_whatsapp_id'] as String?,
      number: json['number'] as String,
      locked: json['locked'] as bool,
      attempt: json['attempt'] as int,
      bannedUntil: json['banned_until'] == null
          ? null
          : DateTime.parse(json['banned_until'] as String),
      finish: json['finish'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyPendingRespondenModelToJson(
        SurveyPendingRespondenModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'survey_id': instance.surveyId,
      'machine_whatsapp_id': instance.machineWhatsappId,
      'number': instance.number,
      'locked': instance.locked,
      'attempt': instance.attempt,
      'banned_until': instance.bannedUntil?.toIso8601String(),
      'finish': instance.finish,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
