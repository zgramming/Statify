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
      machine:
          SurveyUnlockMachine.fromJson(json['machine'] as Map<String, dynamic>),
      responses: (json['responses'] as List<dynamic>)
          .map((e) => SurveyUnlockRsp.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      'machine': instance.machine,
      'responses': instance.responses,
    };

SurveyUnlockMachine _$SurveyUnlockMachineFromJson(Map<String, dynamic> json) =>
    SurveyUnlockMachine(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      serialNumber: json['serial_number'] as String,
      license: json['license'] as String,
      action: json['action'] as String,
      send: json['send'] as int,
      replied: json['replied'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyUnlockMachineToJson(
        SurveyUnlockMachine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'number': instance.number,
      'serial_number': instance.serialNumber,
      'license': instance.license,
      'action': instance.action,
      'send': instance.send,
      'replied': instance.replied,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

SurveyUnlockRsp _$SurveyUnlockRspFromJson(Map<String, dynamic> json) =>
    SurveyUnlockRsp(
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

Map<String, dynamic> _$SurveyUnlockRspToJson(SurveyUnlockRsp instance) =>
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
