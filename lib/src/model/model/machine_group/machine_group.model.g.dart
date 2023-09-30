// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_group.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineGroupModel _$MachineGroupModelFromJson(Map<String, dynamic> json) =>
    MachineGroupModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      masterMachineId: json['master_machine_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      master: json['master'] == null
          ? null
          : MasterMachineGroup.fromJson(json['master'] as Map<String, dynamic>),
      machines: (json['machines'] as List<dynamic>?)
          ?.map((e) => MasterMachineGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MachineGroupModelToJson(MachineGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'master_machine_id': instance.masterMachineId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'master': instance.master,
      'machines': instance.machines,
    };

MasterMachineGroup _$MasterMachineGroupFromJson(Map<String, dynamic> json) =>
    MasterMachineGroup(
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
      pivotMachineGroupId: json['pivot_machine_group_id'] as String?,
      pivotMachineId: json['pivot_machine_id'] as String?,
    );

Map<String, dynamic> _$MasterMachineGroupToJson(MasterMachineGroup instance) =>
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
      'pivot_machine_group_id': instance.pivotMachineGroupId,
      'pivot_machine_id': instance.pivotMachineId,
    };
