// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_config.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineConfigModel _$MachineConfigModelFromJson(Map<String, dynamic> json) =>
    MachineConfigModel(
      sms1: json['sms1'] as String?,
      sms2: json['sms2'] as String?,
      sms3: json['sms3'] as String?,
      sms4: json['sms4'] as String?,
      sms5: json['sms5'] as String?,
      count: json['count'] as String?,
      reboot: json['reboot'] as String?,
      sender1: json['sender1'] as String?,
      sender2: json['sender2'] as String?,
      sender3: json['sender3'] as String?,
      sender4: json['sender4'] as String?,
      sender5: json['sender5'] as String?,
      taskCount: json['task_count'] as String?,
    );

Map<String, dynamic> _$MachineConfigModelToJson(MachineConfigModel instance) =>
    <String, dynamic>{
      'sms1': instance.sms1,
      'sms2': instance.sms2,
      'sms3': instance.sms3,
      'sms4': instance.sms4,
      'sms5': instance.sms5,
      'count': instance.count,
      'reboot': instance.reboot,
      'sender1': instance.sender1,
      'sender2': instance.sender2,
      'sender3': instance.sender3,
      'sender4': instance.sender4,
      'sender5': instance.sender5,
      'task_count': instance.taskCount,
    };
