// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_response_setting_delete_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineResponseSettingDeleteResponseModel
    _$MachineResponseSettingDeleteResponseModelFromJson(
            Map<String, dynamic> json) =>
        MachineResponseSettingDeleteResponseModel(
          id: json['id'] as String,
          machineId: json['machine_id'] as String,
          key: json['key'] as String,
          value: json['value'] as String,
          type: json['type'] as String,
          createdAt: DateTime.parse(json['created_at'] as String),
          updatedAt: DateTime.parse(json['updated_at'] as String),
        );

Map<String, dynamic> _$MachineResponseSettingDeleteResponseModelToJson(
        MachineResponseSettingDeleteResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
