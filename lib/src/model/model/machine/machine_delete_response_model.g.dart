// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_delete_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineDeleteResponseModel _$MachineDeleteResponseModelFromJson(
        Map<String, dynamic> json) =>
    MachineDeleteResponseModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      number: json['number'] as String,
      serialNumber: json['serial_number'] as String,
      license: json['license'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      activeSurveyId: json['active_survey_id'] as String?,
    );

Map<String, dynamic> _$MachineDeleteResponseModelToJson(
        MachineDeleteResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'number': instance.number,
      'serial_number': instance.serialNumber,
      'license': instance.license,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'active_survey_id': instance.activeSurveyId,
    };
