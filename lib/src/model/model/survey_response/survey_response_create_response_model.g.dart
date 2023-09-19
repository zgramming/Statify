// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_response_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResponseCreateModel _$SurveyResponseCreateModelFromJson(
        Map<String, dynamic> json) =>
    SurveyResponseCreateModel(
      id: json['id'] as String,
      machineId: json['machine_id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      action: $enumDecode(_$MachineActionEnumEnumMap, json['action']),
      send: json['send'] as int,
      replied: json['replied'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$SurveyResponseCreateModelToJson(
        SurveyResponseCreateModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'name': instance.name,
      'slug': instance.slug,
      'action': _$MachineActionEnumEnumMap[instance.action]!,
      'send': instance.send,
      'replied': instance.replied,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };

const _$MachineActionEnumEnumMap = {
  MachineActionEnum.sms: 'sms',
  MachineActionEnum.whatsapp: 'whatsapp',
  MachineActionEnum.whatsapp_priority: 'whatsapp_priority',
  MachineActionEnum.whatsapp_sms: 'whatsapp_sms',
};
