// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_config_operator.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineConfigOperatorsModel _$MachineConfigOperatorsModelFromJson(
        Map<String, dynamic> json) =>
    MachineConfigOperatorsModel(
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
      lteArfcn: json['lte_arfcn'] as String?,
      ltePci: json['lte_pci'] as String?,
      lteTac: json['lte_tac'] as String?,
      lteCellId: json['lte_cell_id'] as String?,
      lteDowngrade: json['lte_downgrade'] as String?,
      lteRotationTime: json['lte_rotation_time'] as String?,
      ltePlmn: json['lte_plmn'] as String?,
      isDefault: MachineConfigOperatorsModel._fromJsonDefault(
          json['default'] as String?),
      threeGArfcn: json['three_g_arfcn'] as String?,
      fiveGArfcn: json['five_g_arfcn'] as String?,
    );

Map<String, dynamic> _$MachineConfigOperatorsModelToJson(
        MachineConfigOperatorsModel instance) =>
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
      'default': MachineConfigOperatorsModel._toJsonDefault(instance.isDefault),
      'three_g_arfcn': instance.threeGArfcn,
      'five_g_arfcn': instance.fiveGArfcn,
    };
