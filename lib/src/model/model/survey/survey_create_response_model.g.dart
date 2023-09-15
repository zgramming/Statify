// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyCreateResponseModel _$SurveyCreateResponseModelFromJson(
        Map<String, dynamic> json) =>
    SurveyCreateResponseModel(
      id: json['id'] as String,
      locked: json['locked'] as bool,
      attempt: json['attempt'] as int,
      finish: json['finish'] as bool,
      number: json['number'] as String,
      machineId: json['machine_id'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      machine: SurveyMachine.fromJson(json['machine'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SurveyCreateResponseModelToJson(
        SurveyCreateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'locked': instance.locked,
      'attempt': instance.attempt,
      'finish': instance.finish,
      'number': instance.number,
      'machine_id': instance.machineId,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'machine': instance.machine,
    };

SurveyMachine _$SurveyMachineFromJson(Map<String, dynamic> json) =>
    SurveyMachine(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      serialNumber: json['serial_number'] as String,
      license: json['license'] as String,
      action: $enumDecode(_$MachineActionEnumEnumMap, json['action']),
      send: json['send'] as int,
      replied: json['replied'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      responses: (json['responses'] as List<dynamic>)
          .map((e) => SurveyMachineResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurveyMachineToJson(SurveyMachine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'number': instance.number,
      'serial_number': instance.serialNumber,
      'license': instance.license,
      'action': _$MachineActionEnumEnumMap[instance.action]!,
      'send': instance.send,
      'replied': instance.replied,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'responses': instance.responses,
    };

const _$MachineActionEnumEnumMap = {
  MachineActionEnum.sms: 'sms',
  MachineActionEnum.whatsapp: 'whatsapp',
  MachineActionEnum.whatsappPriority: 'whatsapp_priority',
  MachineActionEnum.whatsappSMS: 'whatsapp_sms',
};

SurveyMachineResponse _$SurveyMachineResponseFromJson(
        Map<String, dynamic> json) =>
    SurveyMachineResponse(
      id: json['id'] as String,
      machineId: json['machine_id'] as String,
      platform:
          $enumDecode(_$MachineResponsePlatformEnumEnumMap, json['platform']),
      key: json['key'] as String,
      value: json['value'] as String,
      type: json['type'] as String,
      finish: json['finish'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyMachineResponseToJson(
        SurveyMachineResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'platform': _$MachineResponsePlatformEnumEnumMap[instance.platform]!,
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
      'finish': instance.finish,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$MachineResponsePlatformEnumEnumMap = {
  MachineResponsePlatformEnum.whatsapp: 'whatsapp',
  MachineResponsePlatformEnum.sms: 'sms',
};
