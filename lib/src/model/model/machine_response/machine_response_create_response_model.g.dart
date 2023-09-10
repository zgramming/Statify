// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_response_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineResponseCreateResponseModel _$MachineResponseCreateResponseModelFromJson(
        Map<String, dynamic> json) =>
    MachineResponseCreateResponseModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      license: json['license'] as String,
      action: $enumDecode(_$MachineActionEnumEnumMap, json['action']),
      smsSetting: json['sms_setting'] as String,
      send: json['send'] as int,
      replied: json['replied'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      responses: (json['responses'] as List<dynamic>)
          .map((e) => Response.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MachineResponseCreateResponseModelToJson(
        MachineResponseCreateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'number': instance.number,
      'license': instance.license,
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

Response _$ResponseFromJson(Map<String, dynamic> json) => Response(
      id: json['id'] as String,
      machineId: json['machine_id'] as String,
      platform:
          $enumDecode(_$MachineResponsePlatformEnumEnumMap, json['platform']),
      key: json['key'] as String,
      value: json['value'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ResponseToJson(Response instance) => <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'platform': _$MachineResponsePlatformEnumEnumMap[instance.platform]!,
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$MachineResponsePlatformEnumEnumMap = {
  MachineResponsePlatformEnum.whatsapp: 'whatsapp',
  MachineResponsePlatformEnum.sms: 'sms',
};
