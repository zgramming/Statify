// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_create_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyCreateResponseModel _$SurveyCreateResponseModelFromJson(
        Map<String, dynamic> json) =>
    SurveyCreateResponseModel(
      id: json['id'] as String,
      number: json['number'] as String,
      machineId: json['machine_id'] as String,
      updatedAt: DateTime.parse(json['updated_at'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
      machine: SurveyCreateResponseModelMachine.fromJson(
          json['machine'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SurveyCreateResponseModelToJson(
        SurveyCreateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'machine_id': instance.machineId,
      'updated_at': instance.updatedAt.toIso8601String(),
      'created_at': instance.createdAt.toIso8601String(),
      'machine': instance.machine,
    };

SurveyCreateResponseModelMachine _$SurveyCreateResponseModelMachineFromJson(
        Map<String, dynamic> json) =>
    SurveyCreateResponseModelMachine(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      number: json['number'] as String,
      license: json['license'] as String,
      action: json['action'] as String,
      smsSetting: json['sms_setting'] as String,
      send: json['send'] as int,
      replied: json['replied'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      settings: (json['settings'] as List<dynamic>)
          .map((e) => SurveyCreateResponseModelMachineSetting.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurveyCreateResponseModelMachineToJson(
        SurveyCreateResponseModelMachine instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'number': instance.number,
      'license': instance.license,
      'action': instance.action,
      'sms_setting': instance.smsSetting,
      'send': instance.send,
      'replied': instance.replied,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'settings': instance.settings,
    };

SurveyCreateResponseModelMachineSetting
    _$SurveyCreateResponseModelMachineSettingFromJson(
            Map<String, dynamic> json) =>
        SurveyCreateResponseModelMachineSetting(
          id: json['id'] as String,
          machineId: json['machine_id'] as String,
          key: json['key'] as String,
          value: json['value'] as String,
          type: json['type'] as String,
          createdAt: DateTime.parse(json['created_at'] as String),
          updatedAt: DateTime.parse(json['updated_at'] as String),
        );

Map<String, dynamic> _$SurveyCreateResponseModelMachineSettingToJson(
        SurveyCreateResponseModelMachineSetting instance) =>
    <String, dynamic>{
      'id': instance.id,
      'machine_id': instance.machineId,
      'key': instance.key,
      'value': instance.value,
      'type': instance.type,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
