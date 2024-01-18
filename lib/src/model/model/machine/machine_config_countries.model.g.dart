// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_config_countries.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineConfigCountriesModel _$MachineConfigCountriesModelFromJson(
        Map<String, dynamic> json) =>
    MachineConfigCountriesModel(
      name: json['name'] as String? ?? '',
      label: json['label'] as String? ?? '',
      isActive: json['is_active'] as int? ?? 1,
      mncs: (json['mncs'] as List<dynamic>?)
              ?.map((e) => MachineConfigCountriesMNCModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MachineConfigCountriesModelToJson(
        MachineConfigCountriesModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'label': instance.label,
      'is_active': instance.isActive,
      'mncs': instance.mncs,
    };

MachineConfigCountriesMNCModel _$MachineConfigCountriesMNCModelFromJson(
        Map<String, dynamic> json) =>
    MachineConfigCountriesMNCModel(
      mcc: json['mcc'] as String,
      mnc: json['mnc'] as String,
      name: json['name'] as String,
      label: json['label'] as String,
      status: json['status'] as int? ?? 1,
      country: json['country'] as String? ?? 'Indonesia',
    );

Map<String, dynamic> _$MachineConfigCountriesMNCModelToJson(
        MachineConfigCountriesMNCModel instance) =>
    <String, dynamic>{
      'mcc': instance.mcc,
      'mnc': instance.mnc,
      'name': instance.name,
      'label': instance.label,
      'status': instance.status,
      'country': instance.country,
    };
