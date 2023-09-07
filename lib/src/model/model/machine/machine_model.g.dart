// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineModel _$MachineModelFromJson(Map<String, dynamic> json) => MachineModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      serialNumber: json['serial_number'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      license: json['license'] as String,
      action: json['action'] as String,
      smsSetting: json['sms_setting'] as String,
      send: json['send'] as int,
      replied: json['replied'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      whatsapps: (json['whatsapps'] as List<dynamic>)
          .map((e) => MachineWhatsappModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MachineModelToJson(MachineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'serial_number': instance.serialNumber,
      'name': instance.name,
      'number': instance.number,
      'license': instance.license,
      'action': instance.action,
      'sms_setting': instance.smsSetting,
      'send': instance.send,
      'replied': instance.replied,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'whatsapps': instance.whatsapps,
    };
