// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyModel _$SurveyModelFromJson(Map<String, dynamic> json) => SurveyModel(
      id: json['id'] as String,
      totalReplied: json['total_replied'] as int,
      totalFinished: json['total_finished'] as int,
      totalVoted: json['total_voted'] as int,
      totalSent: json['total_sent'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      action: $enumDecode(_$MachineActionEnumEnumMap, json['action']),
      machineId: json['machine_id'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$SurveyModelToJson(SurveyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'total_replied': instance.totalReplied,
      'total_finished': instance.totalFinished,
      'total_voted': instance.totalVoted,
      'total_sent': instance.totalSent,
      'name': instance.name,
      'slug': instance.slug,
      'action': _$MachineActionEnumEnumMap[instance.action]!,
      'machine_id': instance.machineId,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
    };

const _$MachineActionEnumEnumMap = {
  MachineActionEnum.sms: 'sms',
  MachineActionEnum.whatsapp: 'whatsapp',
  MachineActionEnum.whatsapp_priority: 'whatsapp_priority',
  MachineActionEnum.whatsapp_sms: 'whatsapp_sms',
};
