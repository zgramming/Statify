import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'machine_config_operator.model.dart';

part 'machine_config.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.none,
)
class MachineConfigModel extends Equatable {
  final String? count;
  final String? power;
  final String? start;
  final String? reboot;
  final String? flashSms;
  final String? wifiName;
  final String? autoArfcn;
  final String? autoReset;

  @JsonKey(
    fromJson: _fromJsonOperators,
    toJson: _toJsonOperators,
  )
  final List<MachineConfigOperatorsModel> operators;
  final String? taskCount;
  final String? wifiHidden;
  final String? powerConfig;
  final String? saveSentList;
  final String? wifiPassword;

  final String? sms1;
  final String? sms2;
  final String? sms3;
  final String? sms4;
  final String? sms5;
  final String? sender1;
  final String? sender2;
  final String? sender3;
  final String? sender4;
  final String? sender5;

  const MachineConfigModel({
    this.count,
    this.power,
    this.start,
    this.reboot,
    this.flashSms,
    this.wifiName,
    this.autoArfcn,
    this.autoReset,
    this.operators = const [],
    this.taskCount,
    this.wifiHidden,
    this.powerConfig,
    this.saveSentList,
    this.wifiPassword,
    this.sms1,
    this.sms2,
    this.sms3,
    this.sms4,
    this.sms5,
    this.sender1,
    this.sender2,
    this.sender3,
    this.sender4,
    this.sender5,
  });

  static List<MachineConfigOperatorsModel> _fromJsonOperators(String? json) {
    if (json == null) return [];
    final decoded = jsonDecode(json);
    final operators = decoded as List<dynamic>;

    final list = operators.map((e) {
      final map = Map<String, dynamic>.from(e);
      return MachineConfigOperatorsModel.fromJson(map);
    }).toList();
    return list;
  }

  static String _toJsonOperators(List<MachineConfigOperatorsModel> list) {
    final json = jsonEncode(list);
    return json;
  }

  factory MachineConfigModel.fromJson(Map<String, dynamic> json) =>
      _$MachineConfigModelFromJson(json);

  /// Connect the generated [_$MachineConfigModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineConfigModelToJson(this);

  @override
  List<Object?> get props {
    return [
      count,
      power,
      start,
      reboot,
      flashSms,
      wifiName,
      autoArfcn,
      autoReset,
      operators,
      taskCount,
      wifiHidden,
      powerConfig,
      saveSentList,
      wifiPassword,
      sms1,
      sms2,
      sms3,
      sms4,
      sms5,
      sender1,
      sender2,
      sender3,
      sender4,
      sender5,
    ];
  }

  @override
  bool get stringify => true;
}
