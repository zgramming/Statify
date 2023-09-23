// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_whatsapp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineWhatsappModel _$MachineWhatsappModelFromJson(
        Map<String, dynamic> json) =>
    MachineWhatsappModel(
      id: json['id'] as String,
      machineId: json['machine_id'] as String,
      number: json['number'] as String,
      qrCode: json['qr_code'] as String?,
      status: $enumDecode(_$MachineWhatsappStatusEnumEnumMap, json['status']),
      totalReplied: json['total_replied'] as int,
      totalFinished: json['total_finished'] as int,
      totalVoted: json['total_voted'] as int,
      totalSent: json['total_sent'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$MachineWhatsappModelToJson(
        MachineWhatsappModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'number': instance.number,
      'qr_code': instance.qrCode,
      'status': _$MachineWhatsappStatusEnumEnumMap[instance.status]!,
      'total_replied': instance.totalReplied,
      'total_finished': instance.totalFinished,
      'total_voted': instance.totalVoted,
      'total_sent': instance.totalSent,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$MachineWhatsappStatusEnumEnumMap = {
  MachineWhatsappStatusEnum.connected: 'connected',
  MachineWhatsappStatusEnum.disconnected: 'disconnected',
};
