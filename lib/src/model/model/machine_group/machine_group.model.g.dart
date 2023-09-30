// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_group.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineGroupModel _$MachineGroupModelFromJson(Map<String, dynamic> json) =>
    MachineGroupModel(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['user_id'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      machines: (json['machines'] as List<dynamic>?)
              ?.map((e) => MachineModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MachineGroupModelToJson(MachineGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'user_id': instance.userId,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'machines': instance.machines,
    };
