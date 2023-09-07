// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineResponseModel _$MachineResponseModelFromJson(
        Map<String, dynamic> json) =>
    MachineResponseModel(
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

Map<String, dynamic> _$MachineResponseModelToJson(
        MachineResponseModel instance) =>
    <String, dynamic>{
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
