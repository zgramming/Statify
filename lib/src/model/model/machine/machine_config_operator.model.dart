import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_config_operator.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineConfigOperatorsModel extends Equatable {
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
  final String? lteArfcn;
  final String? ltePci;
  final String? lteTac;
  final String? lteCellId;
  final String? lteDowngrade;
  final String? lteRotationTime;
  final String? ltePlmn;
  @JsonKey(
    name: 'default',
    fromJson: _fromJsonDefault,
    toJson: _toJsonDefault,
  )
  final bool? isDefault;
  final String? threeGArfcn;
  final String? fiveGArfcn;

  const MachineConfigOperatorsModel({
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

  static bool? _fromJsonDefault(String? value) {
    return value == 'true';
  }

  static String? _toJsonDefault(bool? value) {
    return value == true ? 'true' : 'false';
  }

  factory MachineConfigOperatorsModel.fromJson(Map<String, dynamic> json) =>
      _$MachineConfigOperatorsModelFromJson(json);

  /// Connect the generated [_$MachineConfigOperatorsModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineConfigOperatorsModelToJson(this);

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

  MachineConfigOperatorsModel copyWith({
    int? status,
    String? label,
    String? mcc,
    String? mnc,
    String? name,
    String? arfcn,
    String? timeout,
    String? country,
    int? isPlay,
    int? curr,
    String? lteArfcn,
    String? ltePci,
    String? lteTac,
    String? lteCellId,
    String? lteDowngrade,
    String? lteRotationTime,
    String? ltePlmn,
    bool? isDefault,
    String? threeGArfcn,
    String? fiveGArfcn,
  }) {
    return MachineConfigOperatorsModel(
      status: status ?? this.status,
      label: label ?? this.label,
      mcc: mcc ?? this.mcc,
      mnc: mnc ?? this.mnc,
      name: name ?? this.name,
      arfcn: arfcn ?? this.arfcn,
      timeout: timeout ?? this.timeout,
      country: country ?? this.country,
      isPlay: isPlay ?? this.isPlay,
      curr: curr ?? this.curr,
      lteArfcn: lteArfcn ?? this.lteArfcn,
      ltePci: ltePci ?? this.ltePci,
      lteTac: lteTac ?? this.lteTac,
      lteCellId: lteCellId ?? this.lteCellId,
      lteDowngrade: lteDowngrade ?? this.lteDowngrade,
      lteRotationTime: lteRotationTime ?? this.lteRotationTime,
      ltePlmn: ltePlmn ?? this.ltePlmn,
      isDefault: isDefault ?? this.isDefault,
      threeGArfcn: threeGArfcn ?? this.threeGArfcn,
      fiveGArfcn: fiveGArfcn ?? this.fiveGArfcn,
    );
  }
}
