// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_whatsapp_send_qrcode_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineWhatsappSendQRCodeResponseModel
    _$MachineWhatsappSendQRCodeResponseModelFromJson(
            Map<String, dynamic> json) =>
        MachineWhatsappSendQRCodeResponseModel(
          id: json['id'] as String,
          machineId: json['machine_id'] as String,
          number: json['number'] as String,
          qrCode: json['qr_code'] as String,
          status: json['status'] as String,
          createdAt: DateTime.parse(json['created_at'] as String),
          updatedAt: DateTime.parse(json['updated_at'] as String),
        );

Map<String, dynamic> _$MachineWhatsappSendQRCodeResponseModelToJson(
        MachineWhatsappSendQRCodeResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'number': instance.number,
      'qr_code': instance.qrCode,
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
