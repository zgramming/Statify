// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_response_setting_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineResponseSettingCreateResponseModel
    _$MachineResponseSettingCreateResponseModelFromJson(
            Map<String, dynamic> json) =>
        MachineResponseSettingCreateResponseModel(
          id: json['id'] as String,
          userId: json['user_id'] as String,
          number: json['number'] as String,
          license: json['license'] as String,
          action: json['action'] as String,
          smsSetting: json['sms_setting'] as String,
          send: json['send'] as int,
          replied: json['replied'] as int,
          createdAt: DateTime.parse(json['created_at'] as String),
          updatedAt: DateTime.parse(json['updated_at'] as String),
          settings: (json['settings'] as List<dynamic>)
              .map((e) =>
                  MachineResponseSettingCreateResponseModelSetting.fromJson(
                      e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$MachineResponseSettingCreateResponseModelToJson(
        MachineResponseSettingCreateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'number': instance.number,
      'license': instance.license,
      'action': instance.action,
      'sms_setting': instance.smsSetting,
      'send': instance.send,
      'replied': instance.replied,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'settings': instance.settings,
    };

MachineResponseSettingCreateResponseModelSetting
    _$MachineResponseSettingCreateResponseModelSettingFromJson(
            Map<String, dynamic> json) =>
        MachineResponseSettingCreateResponseModelSetting(
          id: json['id'] as String,
          machineId: json['machine_id'] as String,
          key: json['key'] as String,
          value: json['value'] as String,
          type: json['type'] as String,
          createdAt: DateTime.parse(json['created_at'] as String),
          updatedAt: DateTime.parse(json['updated_at'] as String),
        );

Map<String, dynamic> _$MachineResponseSettingCreateResponseModelSettingToJson(
        MachineResponseSettingCreateResponseModelSetting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
