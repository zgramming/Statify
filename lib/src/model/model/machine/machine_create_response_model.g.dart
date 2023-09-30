// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineCreateResponseModel _$MachineCreateResponseModelFromJson(
        Map<String, dynamic> json) =>
    MachineCreateResponseModel(
      id: json['id'] as String,
      totalSmsSent: json['total_sms_sent'] as int,
      group: json['group'] as bool,
      name: json['name'] as String,
      number: json['number'] as String,
      serialNumber: json['serial_number'] as String,
      license: json['license'] as String,
      userId: json['user_id'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MachineCreateResponseModelToJson(
        MachineCreateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total_sms_sent': instance.totalSmsSent,
      'group': instance.group,
      'name': instance.name,
      'number': instance.number,
      'serial_number': instance.serialNumber,
      'license': instance.license,
      'user_id': instance.userId,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };
