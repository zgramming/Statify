// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_config_operator.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineConfigOperatorModel _$MachineConfigOperatorModelFromJson(
        Map<String, dynamic> json) =>
    MachineConfigOperatorModel(
      status: json['status'] as int?,
      label: json['label'] as String?,
      mcc: json['mcc'] as String?,
      mnc: json['mnc'] as String?,
      name: json['name'] as String?,
      arfcn: json['arfcn'] as String?,
      timeout: json['timeout'] as String?,
      country: json['country'] as String?,
      isPlay: json['is_play'] as int?,
      curr: json['curr'] as int?,
      lteArfcn: json['lte_arfcn'] as int?,
      ltePci: json['lte_pci'] as int?,
      lteTac: json['lte_tac'] as int?,
      lteCellId: json['lte_cell_id'] as int?,
      lteDowngrade: json['lte_downgrade'] as int?,
      lteRotationTime: json['lte_rotation_time'] as int?,
      ltePlmn: json['lte_plmn'] as String?,
      isDefault: json['is_default'] as bool?,
      threeGArfcn: json['three_g_arfcn'] as int?,
      fiveGArfcn: json['five_g_arfcn'] as int?,
    );

Map<String, dynamic> _$MachineConfigOperatorModelToJson(
        MachineConfigOperatorModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'label': instance.label,
      'mcc': instance.mcc,
      'mnc': instance.mnc,
      'name': instance.name,
      'arfcn': instance.arfcn,
      'timeout': instance.timeout,
      'country': instance.country,
      'is_play': instance.isPlay,
      'curr': instance.curr,
      'lte_arfcn': instance.lteArfcn,
      'lte_pci': instance.ltePci,
      'lte_tac': instance.lteTac,
      'lte_cell_id': instance.lteCellId,
      'lte_downgrade': instance.lteDowngrade,
      'lte_rotation_time': instance.lteRotationTime,
      'lte_plmn': instance.ltePlmn,
      'is_default': instance.isDefault,
      'three_g_arfcn': instance.threeGArfcn,
      'five_g_arfcn': instance.fiveGArfcn,
    };
