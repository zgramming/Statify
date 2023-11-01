// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'machine_config_boardips.model.dart';
import 'machine_config_countries.model.dart';
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
  final String? taskCount;
  final String? unallowed;
  final String? wifiHidden;
  final String? powerConfig;
  final String? arfcnLabel2G;
  final String? arfcnLabel3G;
  final String? arfcnLabel4G;
  final String? arfcnLabel5G;
  final String? saveSentList;
  final String? wifiPassword;
  final String? arfcnHidden2G;
  final String? arfcnHidden3G;
  final String? arfcnHidden4G;
  final String? arfcnHidden5G;
  final String? removeManager;
  final String? managerPassword;

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

  final List<MachineConfigOperatorsModel> operators;
  final List<MachineBoardIpsModel> boardIps;
  final List<MachineConfigCountriesModel> countries;

  const MachineConfigModel({
    this.count,
    this.power,
    this.start,
    this.reboot,
    this.flashSms,
    this.wifiName,
    this.autoArfcn,
    this.autoReset,
    this.taskCount,
    this.unallowed,
    this.wifiHidden,
    this.powerConfig,
    this.arfcnLabel2G,
    this.arfcnLabel3G,
    this.arfcnLabel4G,
    this.arfcnLabel5G,
    this.saveSentList,
    this.wifiPassword,
    this.arfcnHidden2G,
    this.arfcnHidden3G,
    this.arfcnHidden4G,
    this.arfcnHidden5G,
    this.removeManager,
    this.managerPassword,
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
    this.operators = const [],
    this.boardIps = const [],
    this.countries = const [],
  });

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
      taskCount,
      unallowed,
      wifiHidden,
      powerConfig,
      arfcnLabel2G,
      arfcnLabel3G,
      arfcnLabel4G,
      arfcnLabel5G,
      saveSentList,
      wifiPassword,
      arfcnHidden2G,
      arfcnHidden3G,
      arfcnHidden4G,
      arfcnHidden5G,
      removeManager,
      managerPassword,
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
      operators,
      boardIps,
      countries,
    ];
  }

  @override
  bool get stringify => true;

  MachineConfigModel copyWith({
    String? count,
    String? power,
    String? start,
    String? reboot,
    String? flashSms,
    String? wifiName,
    String? autoArfcn,
    String? autoReset,
    String? taskCount,
    String? unallowed,
    String? wifiHidden,
    String? powerConfig,
    String? arfcnLabel2G,
    String? arfcnLabel3G,
    String? arfcnLabel4G,
    String? arfcnLabel5G,
    String? saveSentList,
    String? wifiPassword,
    String? arfcnHidden2G,
    String? arfcnHidden3G,
    String? arfcnHidden4G,
    String? arfcnHidden5G,
    String? removeManager,
    String? managerPassword,
    String? sms1,
    String? sms2,
    String? sms3,
    String? sms4,
    String? sms5,
    String? sender1,
    String? sender2,
    String? sender3,
    String? sender4,
    String? sender5,
    List<MachineConfigOperatorsModel>? operators,
    List<MachineBoardIpsModel>? boardIps,
    List<MachineConfigCountriesModel>? countries,
  }) {
    return MachineConfigModel(
      count: count ?? this.count,
      power: power ?? this.power,
      start: start ?? this.start,
      reboot: reboot ?? this.reboot,
      flashSms: flashSms ?? this.flashSms,
      wifiName: wifiName ?? this.wifiName,
      autoArfcn: autoArfcn ?? this.autoArfcn,
      autoReset: autoReset ?? this.autoReset,
      taskCount: taskCount ?? this.taskCount,
      unallowed: unallowed ?? this.unallowed,
      wifiHidden: wifiHidden ?? this.wifiHidden,
      powerConfig: powerConfig ?? this.powerConfig,
      arfcnLabel2G: arfcnLabel2G ?? this.arfcnLabel2G,
      arfcnLabel3G: arfcnLabel3G ?? this.arfcnLabel3G,
      arfcnLabel4G: arfcnLabel4G ?? this.arfcnLabel4G,
      arfcnLabel5G: arfcnLabel5G ?? this.arfcnLabel5G,
      saveSentList: saveSentList ?? this.saveSentList,
      wifiPassword: wifiPassword ?? this.wifiPassword,
      arfcnHidden2G: arfcnHidden2G ?? this.arfcnHidden2G,
      arfcnHidden3G: arfcnHidden3G ?? this.arfcnHidden3G,
      arfcnHidden4G: arfcnHidden4G ?? this.arfcnHidden4G,
      arfcnHidden5G: arfcnHidden5G ?? this.arfcnHidden5G,
      removeManager: removeManager ?? this.removeManager,
      managerPassword: managerPassword ?? this.managerPassword,
      sms1: sms1 ?? this.sms1,
      sms2: sms2 ?? this.sms2,
      sms3: sms3 ?? this.sms3,
      sms4: sms4 ?? this.sms4,
      sms5: sms5 ?? this.sms5,
      sender1: sender1 ?? this.sender1,
      sender2: sender2 ?? this.sender2,
      sender3: sender3 ?? this.sender3,
      sender4: sender4 ?? this.sender4,
      sender5: sender5 ?? this.sender5,
      operators: operators ?? this.operators,
      boardIps: boardIps ?? this.boardIps,
      countries: countries ?? this.countries,
    );
  }
}
