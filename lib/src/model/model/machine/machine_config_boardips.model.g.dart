// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_config_boardips.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineBoardIpsModel _$MachineBoardIpsModelFromJson(
        Map<String, dynamic> json) =>
    MachineBoardIpsModel(
      name: json['name'] as String,
      ip: json['ip'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$MachineBoardIpsModelToJson(
        MachineBoardIpsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'ip': instance.ip,
      'status': instance.status,
    };
