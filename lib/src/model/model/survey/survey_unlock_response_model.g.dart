// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_unlock_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyUnlockResponseModel _$SurveyUnlockResponseModelFromJson(
        Map<String, dynamic> json) =>
    SurveyUnlockResponseModel(
      id: json['id'] as String,
      machineId: json['machine_id'] as String,
      machineWhatsappId: json['machine_whatsapp_id'],
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

Map<String, dynamic> _$SurveyUnlockResponseModelToJson(
        SurveyUnlockResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'machine_whatsapp_id': instance.machineWhatsappId,
      'number': instance.number,
      'locked': instance.locked,
      'attempt': instance.attempt,
      'banned_until': instance.bannedUntil?.toIso8601String(),
      'finish': instance.finish,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
