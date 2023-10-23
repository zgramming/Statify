import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_config_operator.model.g.dart';

@immutable
@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineConfigOperatorModel extends Equatable {
  final int? status;
  final String? label;
  final String? mcc;
  final String? mnc;
  final String? name;
  final String? arfcn;
  final String? timeout;
  final String? country;
  final int? isPlay;
  final int? curr;
  final int? lteArfcn;
  final int? ltePci;
  final int? lteTac;
  final int? lteCellId;
  final int? lteDowngrade;
  final int? lteRotationTime;
  final String? ltePlmn;
  final bool? isDefault;
  final int? threeGArfcn;
  final int? fiveGArfcn;
  const MachineConfigOperatorModel({
    required this.status,
    required this.label,
    required this.mcc,
    required this.mnc,
    required this.name,
    required this.arfcn,
    required this.timeout,
    required this.country,
    required this.isPlay,
    required this.curr,
    required this.lteArfcn,
    required this.ltePci,
    required this.lteTac,
    required this.lteCellId,
    required this.lteDowngrade,
    required this.lteRotationTime,
    required this.ltePlmn,
    required this.isDefault,
    required this.threeGArfcn,
    required this.fiveGArfcn,
  });

  factory MachineConfigOperatorModel.fromJson(Map<String, dynamic> json) =>
      _$MachineConfigOperatorModelFromJson(json);

  /// Connect the generated [_$MachineConfigOperatorModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineConfigOperatorModelToJson(this);

  @override
  List<Object?> get props {
    return [
      status,
      label,
      mcc,
      mnc,
      name,
      arfcn,
      timeout,
      country,
      isPlay,
      curr,
      lteArfcn,
      ltePci,
      lteTac,
      lteCellId,
      lteDowngrade,
      lteRotationTime,
      ltePlmn,
      isDefault,
      threeGArfcn,
      fiveGArfcn,
    ];
  }

  @override
  bool get stringify => true;
}
