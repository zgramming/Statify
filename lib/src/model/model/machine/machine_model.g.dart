// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineModel _$MachineModelFromJson(Map<String, dynamic> json) => MachineModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      serialNumber: json['serial_number'] as String,
      license: json['license'] as String,
      totalSmsSent: json['total_sms_sent'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      activeSurveyId: json['active_survey_id'] as String?,
      group: json['group'] as bool,
      status: $enumDecode(_$MachineStatusEnumEnumMap, json['status']),
      lastOnline: json['last_online'] == null
          ? null
          : DateTime.parse(json['last_online'] as String),
      config: json['config'] == null
          ? null
          : MachineConfigModel.fromJson(json['config'] as Map<String, dynamic>),
      isUpdating: json['is_updating'] as bool,
      result: json['result'] as String?,
      logo: json['logo'] as String?,
      summary: json['summary'] == null
          ? null
          : MachineSummaryModel.fromJson(
              json['summary'] as Map<String, dynamic>),
      code: json['code'] as String?,
      ip: json['ip'] as String?,
      pivotMachineGroupId: json['pivot_machine_group_id'] as String?,
      pivotMachineId: json['pivot_machine_id'] as String?,
    );

Map<String, dynamic> _$MachineModelToJson(MachineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'number': instance.number,
      'serial_number': instance.serialNumber,
      'license': instance.license,
      'total_sms_sent': instance.totalSmsSent,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'active_survey_id': instance.activeSurveyId,
      'group': instance.group,
      'status': _$MachineStatusEnumEnumMap[instance.status]!,
      'last_online': instance.lastOnline?.toIso8601String(),
      'config': instance.config,
      'is_updating': instance.isUpdating,
      'result': instance.result,
      'logo': instance.logo,
      'summary': instance.summary,
      'code': instance.code,
      'ip': instance.ip,
      'pivot_machine_group_id': instance.pivotMachineGroupId,
      'pivot_machine_id': instance.pivotMachineId,
    };

const _$MachineStatusEnumEnumMap = {
  MachineStatusEnum.offline: 'offline',
  MachineStatusEnum.online: 'online',
};
