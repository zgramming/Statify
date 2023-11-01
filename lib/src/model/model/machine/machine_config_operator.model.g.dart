// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_config_operator.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineConfigOperatorsModel _$MachineConfigOperatorsModelFromJson(
        Map<String, dynamic> json) =>
    MachineConfigOperatorsModel(
      mcc: json['mcc'] as String?,
      mnc: json['mnc'] as String?,
      curr: json['curr'] as int?,
      name: json['name'] as String?,
      arfcn: json['arfcn'] as String?,
      label: json['label'] as String?,
      status: json['status'] as int?,
      country: json['country'] as String?,
      operatorDefault: json['default'] as String?,
      isPlay: json['is_play'] as int?,
      ltePci: json['lte_pci'] as String?,
      lteTac: json['lte_tac'] as String?,
      timeout: json['timeout'] as String?,
      ltePlmn: json['lte_plmn'] as String?,
      lteArfcn: json['lte_arfcn'] as String?,
      lteCellId: json['lte_cell_id'] as String?,
      fiveGArfcn: json['five_g_arfcn'] as String?,
      lteDowngrade: json['lte_downgrade'] as String?,
      threeGArfcn: json['three_g_arfcn'] as String?,
      lteRotationTime: json['lte_rotation_time'] as String?,
    );

Map<String, dynamic> _$MachineConfigOperatorsModelToJson(
        MachineConfigOperatorsModel instance) =>
    <String, dynamic>{
      'mcc': instance.mcc,
      'mnc': instance.mnc,
      'curr': instance.curr,
      'name': instance.name,
      'arfcn': instance.arfcn,
      'label': instance.label,
      'status': instance.status,
      'country': instance.country,
      'default': instance.operatorDefault,
      'is_play': instance.isPlay,
      'lte_pci': instance.ltePci,
      'lte_tac': instance.lteTac,
      'timeout': instance.timeout,
      'lte_plmn': instance.ltePlmn,
      'lte_arfcn': instance.lteArfcn,
      'lte_cell_id': instance.lteCellId,
      'five_g_arfcn': instance.fiveGArfcn,
      'lte_downgrade': instance.lteDowngrade,
      'three_g_arfcn': instance.threeGArfcn,
      'lte_rotation_time': instance.lteRotationTime,
    };
