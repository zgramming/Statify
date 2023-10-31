// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_config_countries.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineConfigCountriesModel _$MachineConfigCountriesModelFromJson(
        Map<String, dynamic> json) =>
    MachineConfigCountriesModel(
      label: json['label'] as String,
      name: json['name'] as String,
      mncs: (json['mncs'] as List<dynamic>?)
              ?.map((e) => MachineConfigCountriesMNCModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      is_active: json['is_active'] as int? ?? 1,
    );

Map<String, dynamic> _$MachineConfigCountriesModelToJson(
        MachineConfigCountriesModel instance) =>
    <String, dynamic>{
      'label': instance.label,
      'name': instance.name,
      'mncs': instance.mncs,
      'is_active': instance.is_active,
    };

MachineConfigCountriesMNCModel _$MachineConfigCountriesMNCModelFromJson(
        Map<String, dynamic> json) =>
    MachineConfigCountriesMNCModel(
      status: json['status'] as int,
      label: json['label'] as String,
      mcc: json['mcc'] as String,
      mnc: json['mnc'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$MachineConfigCountriesMNCModelToJson(
        MachineConfigCountriesMNCModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'label': instance.label,
      'mcc': instance.mcc,
      'mnc': instance.mnc,
      'name': instance.name,
    };
