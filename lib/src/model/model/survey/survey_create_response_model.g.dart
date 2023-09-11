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
      license: json['license'] as String,
      serialNumber: json['serial_number'] as String,
      action: $enumDecode(_$MachineActionEnumEnumMap, json['action']),
      smsSetting: json['sms_setting'] as String,
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
      'license': instance.license,
      'serial_number': instance.serialNumber,
      'action': _$MachineActionEnumEnumMap[instance.action]!,
      'sms_setting': instance.smsSetting,
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
      platform: $enumDecode(_$MachineActionEnumEnumMap, json['platform']),
      key: json['key'] as String,
      value: json['value'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyMachineResponseToJson(
        SurveyMachineResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'platform': _$MachineActionEnumEnumMap[instance.platform]!,
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
