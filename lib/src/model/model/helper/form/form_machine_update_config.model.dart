import 'package:equatable/equatable.dart';

import '../../machine/machine_config.model.dart';
import '../../machine/machine_config_boardips.model.dart';
import '../../machine/machine_config_countries.model.dart';
import '../../machine/machine_config_operator.model.dart';

class FormMachineUpdateConfigModel extends Equatable {
  final String machineId;
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

  const FormMachineUpdateConfigModel({
    required this.machineId,
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

  factory FormMachineUpdateConfigModel.fromMachineConfigModel(
    String machineId,
    MachineConfigModel config,
  ) {
    return FormMachineUpdateConfigModel(
      machineId: machineId,
      count: config.count ?? "0",
      taskCount: config.taskCount ?? "0",
      reboot: config.reboot ?? "0",
      autoArfcn: config.autoArfcn ?? "0",
      autoReset: config.autoReset ?? "0",
      flashSms: config.flashSms ?? "0",
      power: config.power ?? "0",
      powerConfig: config.powerConfig,
      saveSentList: config.saveSentList ?? "0",
      sender1: config.sender1,
      sender2: config.sender2,
      sender3: config.sender3,
      sender4: config.sender4,
      sender5: config.sender5,
      sms1: config.sms1,
      sms2: config.sms2,
      sms3: config.sms3,
      sms4: config.sms4,
      sms5: config.sms5,
      start: config.start ?? "0",
      wifiHidden: config.wifiHidden ?? "0",
      wifiName: config.wifiName,
      wifiPassword: config.wifiPassword,
      arfcnHidden2g: config.arfcnHidden2g,
      arfcnHidden3g: config.arfcnHidden3g,
      arfcnHidden4g: config.arfcnHidden4g,
      arfcnHidden5g: config.arfcnHidden5g,
      arfcnLabel2g: config.arfcnLabel2g,
      arfcnLabel3g: config.arfcnLabel3g,
      arfcnLabel4g: config.arfcnLabel4g,
      arfcnLabel5g: config.arfcnLabel5g,
      managerPassword: config.managerPassword,
      removeManager: config.removeManager,
      unallowed: config.unallowed,
      operators: config.operators,
      boardIps: config.boardIps,
      countries: config.countries,
      adminPassword: config.adminPassword,
      allowed: config.allowed,
      autoClear: config.autoClear,
      band: config.band,
      machineKeyLast: config.machineKeyLast,
      machineKeyType: config.machineKeyType,
      plmn: config.plmn,
      runningText: config.runningText,
      allRotation: config.allRotation,
      autoCellId: config.autoCellId,
      fourGData: config.fourGData,
      fourGDataChanged: config.fourGDataChanged,
      removeAdmin: config.removeAdmin,
      twoGData: config.twoGData,
      twoGDataChanged: config.twoGDataChanged,
    );
  }

  @override
  List<Object?> get props {
    return [
      machineId,
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

  FormMachineUpdateConfigModel copyWith({
    String? machineId,
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
    return FormMachineUpdateConfigModel(
      machineId: machineId ?? this.machineId,
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
