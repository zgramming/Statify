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
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      masterId: json['master_id'] as String,
      copySetting: json['copy_setting'] as bool,
      copySmsSetting: json['copy_sms_setting'] as bool,
      machines: (json['machines'] as List<dynamic>?)
              ?.map((e) => MachineModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MachineGroupModelToJson(MachineGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'master_id': instance.masterId,
      'copy_setting': instance.copySetting,
      'copy_sms_setting': instance.copySmsSetting,
      'machines': instance.machines,
    };
