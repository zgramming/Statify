// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineSettingModel _$MachineSettingModelFromJson(Map<String, dynamic> json) =>
    MachineSettingModel(
      id: json['id'] as String,
      machineId: json['machine_id'] as String,
      platform: $enumDecode(_$MachineResponsePlatformEnumMap, json['platform']),
      usePassword: json['use_password'] as int,
      timeout: json['timeout'] as int,
      tries: json['tries'] as int,
      backoff: json['backoff'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MachineSettingModelToJson(
        MachineSettingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'platform': _$MachineResponsePlatformEnumMap[instance.platform]!,
      'use_password': instance.usePassword,
      'timeout': instance.timeout,
      'tries': instance.tries,
      'backoff': instance.backoff,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$MachineResponsePlatformEnumMap = {
  MachineResponsePlatform.whatsapp: 'whatsapp',
  MachineResponsePlatform.sms: 'sms',
};
