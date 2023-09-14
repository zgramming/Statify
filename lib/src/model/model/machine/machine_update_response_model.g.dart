// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_update_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineUpdateResponseModel _$MachineUpdateResponseModelFromJson(
        Map<String, dynamic> json) =>
    MachineUpdateResponseModel(
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

Map<String, dynamic> _$MachineUpdateResponseModelToJson(
        MachineUpdateResponseModel instance) =>
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

MachineUpdateResponseModelUser _$MachineUpdateResponseModelUserFromJson(
        Map<String, dynamic> json) =>
    MachineUpdateResponseModelUser(
      id: json['id'] as String,
      email: json['email'] as String?,
      username: json['username'] as String,
      name: json['name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MachineUpdateResponseModelUserToJson(
        MachineUpdateResponseModelUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
