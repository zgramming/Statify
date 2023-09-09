// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_response_update_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineResponseUpdateResponseModel _$MachineResponseUpdateResponseModelFromJson(
        Map<String, dynamic> json) =>
    MachineResponseUpdateResponseModel(
      id: json['id'] as String,
      machineId: json['machine_id'] as String,
      platform: json['platform'] as String,
      key: json['key'] as String,
      value: json['value'] as String,
      type: json['type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MachineResponseUpdateResponseModelToJson(
        MachineResponseUpdateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'platform': instance.platform,
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
