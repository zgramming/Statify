import 'dart:convert';

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
  final String? arfcnLabel2g;
  final String? arfcnLabel3g;
  final String? arfcnLabel4g;
  final String? arfcnLabel5g;
  final String? saveSentList;
  final String? wifiPassword;
  final String? arfcnHidden2g;
  final String? arfcnHidden3g;
  final String? arfcnHidden4g;
  final String? arfcnHidden5g;
  final String? removeManager;
  final String? managerPassword;

  // New Input Admin Response
  final String? plmn;
  final String? band;
  final String? allowed;
  final String? autoClear;
  final String? runningText;
  final String? adminPassword;
  final String? machineKeyLast;
  final String? machineKeyType;

  // New Input Again
  final String? allRotation;
  final String? autoCellId;
  final String? fourGData;
  final String? fourGDataChanged;
  final String? removeAdmin;
  final String? twoGData;
  final String? twoGDataChanged;

  // New Input Again
  final String? clientAllowed;
  final String? hiddenManager;
  final String? updateLogo;
  final String? registeredMccMnc;

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

  final String? fake;

  @JsonKey(fromJson: fromJsonOperators)
  final List<MachineConfigOperatorsModel> operators;

  @JsonKey(fromJson: fromJsonBoardIps)
  final List<MachineBoardIpsModel> boardIps;

  @JsonKey(fromJson: fromJsonCountries)
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
    this.arfcnLabel2g,
    this.arfcnLabel3g,
    this.arfcnLabel4g,
    this.arfcnLabel5g,
    this.saveSentList,
    this.wifiPassword,
    this.arfcnHidden2g,
    this.arfcnHidden3g,
    this.arfcnHidden4g,
    this.arfcnHidden5g,
    this.removeManager,
    this.managerPassword,
    this.plmn,
    this.band,
    this.allowed,
    this.autoClear,
    this.runningText,
    this.adminPassword,
    this.machineKeyLast,
    this.machineKeyType,
    this.allRotation,
    this.autoCellId,
    this.fourGData,
    this.fourGDataChanged,
    this.removeAdmin,
    this.twoGData,
    this.twoGDataChanged,
    this.clientAllowed,
    this.hiddenManager,
    this.updateLogo,
    this.registeredMccMnc,
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
    this.fake,
    this.operators = const [],
    this.boardIps = const [],
    this.countries = const [],
  });

  factory MachineConfigModel.fromJson(Map<String, dynamic> json) =>
      _$MachineConfigModelFromJson(json);

  /// Connect the generated [_$MachineConfigModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineConfigModelToJson(this);

  static List<MachineConfigOperatorsModel> fromJsonOperators(String json) {
    final List<dynamic> data = jsonDecode(json);
    final result =
        data.map((e) => MachineConfigOperatorsModel.fromJson(e)).toList();
    return result;
  }

  static List<MachineBoardIpsModel> fromJsonBoardIps(String json) {
    final List<dynamic> data = jsonDecode(json);
    final result = data.map((e) => MachineBoardIpsModel.fromJson(e)).toList();
    return result;
  }

  static List<MachineConfigCountriesModel> fromJsonCountries(String json) {
    final List<dynamic> data = jsonDecode(json);
    final result =
        data.map((e) => MachineConfigCountriesModel.fromJson(e)).toList();
    return result;
  }

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
      arfcnLabel2g,
      arfcnLabel3g,
      arfcnLabel4g,
      arfcnLabel5g,
      saveSentList,
      wifiPassword,
      arfcnHidden2g,
      arfcnHidden3g,
      arfcnHidden4g,
      arfcnHidden5g,
      removeManager,
      managerPassword,
      plmn,
      band,
      allowed,
      autoClear,
      runningText,
      adminPassword,
      machineKeyLast,
      machineKeyType,
      allRotation,
      autoCellId,
      fourGData,
      fourGDataChanged,
      removeAdmin,
      twoGData,
      twoGDataChanged,
      clientAllowed,
      hiddenManager,
      updateLogo,
      registeredMccMnc,
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
      fake,
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
    String? arfcnLabel2g,
    String? arfcnLabel3g,
    String? arfcnLabel4g,
    String? arfcnLabel5g,
    String? saveSentList,
    String? wifiPassword,
    String? arfcnHidden2g,
    String? arfcnHidden3g,
    String? arfcnHidden4g,
    String? arfcnHidden5g,
    String? removeManager,
    String? managerPassword,
    String? plmn,
    String? band,
    String? allowed,
    String? autoClear,
    String? runningText,
    String? adminPassword,
    String? machineKeyLast,
    String? machineKeyType,
    String? allRotation,
    String? autoCellId,
    String? fourGData,
    String? fourGDataChanged,
    String? removeAdmin,
    String? twoGData,
    String? twoGDataChanged,
    String? clientAllowed,
    String? hiddenManager,
    String? updateLogo,
    String? registeredMccMnc,
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
    String? fake,
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
      arfcnLabel2g: arfcnLabel2g ?? this.arfcnLabel2g,
      arfcnLabel3g: arfcnLabel3g ?? this.arfcnLabel3g,
      arfcnLabel4g: arfcnLabel4g ?? this.arfcnLabel4g,
      arfcnLabel5g: arfcnLabel5g ?? this.arfcnLabel5g,
      saveSentList: saveSentList ?? this.saveSentList,
      wifiPassword: wifiPassword ?? this.wifiPassword,
      arfcnHidden2g: arfcnHidden2g ?? this.arfcnHidden2g,
      arfcnHidden3g: arfcnHidden3g ?? this.arfcnHidden3g,
      arfcnHidden4g: arfcnHidden4g ?? this.arfcnHidden4g,
      arfcnHidden5g: arfcnHidden5g ?? this.arfcnHidden5g,
      removeManager: removeManager ?? this.removeManager,
      managerPassword: managerPassword ?? this.managerPassword,
      plmn: plmn ?? this.plmn,
      band: band ?? this.band,
      allowed: allowed ?? this.allowed,
      autoClear: autoClear ?? this.autoClear,
      runningText: runningText ?? this.runningText,
      adminPassword: adminPassword ?? this.adminPassword,
      machineKeyLast: machineKeyLast ?? this.machineKeyLast,
      machineKeyType: machineKeyType ?? this.machineKeyType,
      allRotation: allRotation ?? this.allRotation,
      autoCellId: autoCellId ?? this.autoCellId,
      fourGData: fourGData ?? this.fourGData,
      fourGDataChanged: fourGDataChanged ?? this.fourGDataChanged,
      removeAdmin: removeAdmin ?? this.removeAdmin,
      twoGData: twoGData ?? this.twoGData,
      twoGDataChanged: twoGDataChanged ?? this.twoGDataChanged,
      clientAllowed: clientAllowed ?? this.clientAllowed,
      hiddenManager: hiddenManager ?? this.hiddenManager,
      updateLogo: updateLogo ?? this.updateLogo,
      registeredMccMnc: registeredMccMnc ?? this.registeredMccMnc,
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
      fake: fake ?? this.fake,
      operators: operators ?? this.operators,
      boardIps: boardIps ?? this.boardIps,
      countries: countries ?? this.countries,
    );
  }
}
