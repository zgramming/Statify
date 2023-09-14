// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_whatsapp_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineWhatsappCreateResponseModel _$MachineWhatsappCreateResponseModelFromJson(
        Map<String, dynamic> json) =>
    MachineWhatsappCreateResponseModel(
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
      whatsapps: (json['whatsapps'] as List<dynamic>)
          .map((e) => MachineWhatsappCreateResponseModelWhatsapp.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MachineWhatsappCreateResponseModelToJson(
        MachineWhatsappCreateResponseModel instance) =>
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
      'whatsapps': instance.whatsapps,
    };

MachineWhatsappCreateResponseModelWhatsapp
    _$MachineWhatsappCreateResponseModelWhatsappFromJson(
            Map<String, dynamic> json) =>
        MachineWhatsappCreateResponseModelWhatsapp(
          id: json['id'] as String,
          machineId: json['machine_id'] as String,
          number: json['number'] as String,
          qrCode: json['qr_code'] as String?,
          status: json['status'] as String,
          createdAt: DateTime.parse(json['created_at'] as String),
          updatedAt: DateTime.parse(json['updated_at'] as String),
        );

Map<String, dynamic> _$MachineWhatsappCreateResponseModelWhatsappToJson(
        MachineWhatsappCreateResponseModelWhatsapp instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'number': instance.number,
      'qr_code': instance.qrCode,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
