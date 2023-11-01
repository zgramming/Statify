import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_config_operator.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineConfigOperatorsModel extends Equatable {
  final String? mcc;
  final String? mnc;
  final int? curr;
  final String? name;
  final String? arfcn;
  final String? label;
  final int? status;
  final String? country;
  @JsonKey(
    name: 'default',
  )
  final String? operatorDefault;
  final int? isPlay;
  final String? ltePci;
  final String? lteTac;
  final String? timeout;
  final String? ltePlmn;
  final String? lteArfcn;
  final String? lteCellId;
  final String? fiveGArfcn;
  final String? lteDowngrade;
  final String? threeGArfcn;
  final String? lteRotationTime;

  const MachineConfigOperatorsModel({
    this.mcc,
    this.mnc,
    this.curr,
    this.name,
    this.arfcn,
    this.label,
    this.status,
    this.country,
    this.operatorDefault,
    this.isPlay,
    this.ltePci,
    this.lteTac,
    this.timeout,
    this.ltePlmn,
    this.lteArfcn,
    this.lteCellId,
    this.fiveGArfcn,
    this.lteDowngrade,
    this.threeGArfcn,
    this.lteRotationTime,
  });

  factory MachineConfigOperatorsModel.fromJson(Map<String, dynamic> json) =>
      _$MachineConfigOperatorsModelFromJson(json);

  /// Connect the generated [_$MachineConfigOperatorsModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineConfigOperatorsModelToJson(this);

  @override
  List<Object?> get props {
    return [
      mcc,
      mnc,
      curr,
      name,
      arfcn,
      label,
      status,
      country,
      operatorDefault,
      isPlay,
      ltePci,
      lteTac,
      timeout,
      ltePlmn,
      lteArfcn,
      lteCellId,
      fiveGArfcn,
      lteDowngrade,
      threeGArfcn,
      lteRotationTime,
    ];
  }

  @override
  bool get stringify => true;

  MachineConfigOperatorsModel copyWith({
    String? mcc,
    String? mnc,
    int? curr,
    String? name,
    String? arfcn,
    String? label,
    int? status,
    String? country,
    String? operatorDefault,
    int? isPlay,
    String? ltePci,
    String? lteTac,
    String? timeout,
    String? ltePlmn,
    String? lteArfcn,
    String? lteCellId,
    String? fiveGArfcn,
    String? lteDowngrade,
    String? threeGArfcn,
    String? lteRotationTime,
  }) {
    return MachineConfigOperatorsModel(
      mcc: mcc ?? this.mcc,
      mnc: mnc ?? this.mnc,
      curr: curr ?? this.curr,
      name: name ?? this.name,
      arfcn: arfcn ?? this.arfcn,
      label: label ?? this.label,
      status: status ?? this.status,
      country: country ?? this.country,
      operatorDefault: operatorDefault ?? this.operatorDefault,
      isPlay: isPlay ?? this.isPlay,
      ltePci: ltePci ?? this.ltePci,
      lteTac: lteTac ?? this.lteTac,
      timeout: timeout ?? this.timeout,
      ltePlmn: ltePlmn ?? this.ltePlmn,
      lteArfcn: lteArfcn ?? this.lteArfcn,
      lteCellId: lteCellId ?? this.lteCellId,
      fiveGArfcn: fiveGArfcn ?? this.fiveGArfcn,
      lteDowngrade: lteDowngrade ?? this.lteDowngrade,
      threeGArfcn: threeGArfcn ?? this.threeGArfcn,
      lteRotationTime: lteRotationTime ?? this.lteRotationTime,
    );
  }
}
