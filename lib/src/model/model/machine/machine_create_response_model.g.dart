// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineCreateResponseModel _$MachineCreateResponseModelFromJson(
        Map<String, dynamic> json) =>
    MachineCreateResponseModel(
      id: json['id'] as String,
      send: json['send'] as int,
      replied: json['replied'] as int,
      serialNumber: json['serial_number'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      license: json['license'] as String,
      action: json['action'] as String,
      smsSetting: json['sms_setting'] as String,
      userId: json['user_id'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      user: MachineCreateResponseModelUser.fromJson(
          json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MachineCreateResponseModelToJson(
        MachineCreateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'send': instance.send,
      'replied': instance.replied,
      'serial_number': instance.serialNumber,
      'name': instance.name,
      'number': instance.number,
      'license': instance.license,
      'action': instance.action,
      'sms_setting': instance.smsSetting,
      'user_id': instance.userId,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'user': instance.user,
    };

MachineCreateResponseModelUser _$MachineCreateResponseModelUserFromJson(
        Map<String, dynamic> json) =>
    MachineCreateResponseModelUser(
      id: json['id'] as String,
      email: json['email'] as String?,
      username: json['username'] as String,
      name: json['name'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MachineCreateResponseModelUserToJson(
        MachineCreateResponseModelUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
