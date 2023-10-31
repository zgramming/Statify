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
  final String? wifiHidden;
  final String? powerConfig;
  final String? saveSentList;
  final String? wifiPassword;

  final String? unallowed;
  final String? arfcnLabel2g;
  final String? arfcnLabel3g;
  final String? arfcnLabel4g;
  final String? arfcnLabel5g;
  final String? arfcnHidden2g;
  final String? arfcnHidden3g;
  final String? arfcnHidden4g;
  final String? arfcnHidden5g;
  final String? removeManager;
  final String? managerPassword;

  final List<MachineConfigOperatorsModel> operators;
  final List<MachineBoardIpsModel> boardIps;
  final List<MachineConfigCountriesModel> countries;

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
    this.taskCount,
    this.wifiHidden,
    this.powerConfig,
    this.saveSentList,
    this.wifiPassword,
    this.unallowed,
    this.arfcnLabel2g,
    this.arfcnLabel3g,
    this.arfcnLabel4g,
    this.arfcnLabel5g,
    this.arfcnHidden2g,
    this.arfcnHidden3g,
    this.arfcnHidden4g,
    this.arfcnHidden5g,
    this.removeManager,
    this.managerPassword,
    this.operators = const [],
    this.boardIps = const [],
    this.countries = const [],
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
      wifiHidden,
      powerConfig,
      saveSentList,
      wifiPassword,
      unallowed,
      arfcnLabel2g,
      arfcnLabel3g,
      arfcnLabel4g,
      arfcnLabel5g,
      arfcnHidden2g,
      arfcnHidden3g,
      arfcnHidden4g,
      arfcnHidden5g,
      removeManager,
      managerPassword,
      operators,
      boardIps,
      countries,
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
    String? wifiHidden,
    String? powerConfig,
    String? saveSentList,
    String? wifiPassword,
    String? unallowed,
    String? arfcnLabel2g,
    String? arfcnLabel3g,
    String? arfcnLabel4g,
    String? arfcnLabel5g,
    String? arfcnHidden2g,
    String? arfcnHidden3g,
    String? arfcnHidden4g,
    String? arfcnHidden5g,
    String? removeManager,
    String? managerPassword,
    List<MachineConfigOperatorsModel>? operators,
    List<MachineBoardIpsModel>? boardIps,
    List<MachineConfigCountriesModel>? countries,
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
      wifiHidden: wifiHidden ?? this.wifiHidden,
      powerConfig: powerConfig ?? this.powerConfig,
      saveSentList: saveSentList ?? this.saveSentList,
      wifiPassword: wifiPassword ?? this.wifiPassword,
      unallowed: unallowed ?? this.unallowed,
      arfcnLabel2g: arfcnLabel2g ?? this.arfcnLabel2g,
      arfcnLabel3g: arfcnLabel3g ?? this.arfcnLabel3g,
      arfcnLabel4g: arfcnLabel4g ?? this.arfcnLabel4g,
      arfcnLabel5g: arfcnLabel5g ?? this.arfcnLabel5g,
      arfcnHidden2g: arfcnHidden2g ?? this.arfcnHidden2g,
      arfcnHidden3g: arfcnHidden3g ?? this.arfcnHidden3g,
      arfcnHidden4g: arfcnHidden4g ?? this.arfcnHidden4g,
      arfcnHidden5g: arfcnHidden5g ?? this.arfcnHidden5g,
      removeManager: removeManager ?? this.removeManager,
      managerPassword: managerPassword ?? this.managerPassword,
      operators: operators ?? this.operators,
      boardIps: boardIps ?? this.boardIps,
      countries: countries ?? this.countries,
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
    );
  }
}
