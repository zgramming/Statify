import 'package:equatable/equatable.dart';

import '../../machine/machine_config.model.dart';
import '../../machine/machine_config_operator.model.dart';

class FormMachineUpdateConfigModel extends Equatable {
  final String machineId;
  final int? count;
  final int? taskCount;

  final int? power;
  final int? start;
  final int? flashSms;
  final String? wifiName;
  final int? autoArfcn;
  final int? autoReset;
  final int? wifiHidden;
  final String? powerConfig; // "1_3_5_8_10"
  final int? saveSentList;
  final String? wifiPassword;
  final bool? isReboot;
  final List<MachineConfigOperatorsModel> operators;

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

  final String? sender1;
  final String? sender2;
  final String? sender3;
  final String? sender4;
  final String? sender5;
  final String? sms1;
  final String? sms2;
  final String? sms3;
  final String? sms4;
  final String? sms5;

  const FormMachineUpdateConfigModel({
    required this.machineId,
    required this.count,
    required this.taskCount,
    this.power,
    this.start,
    this.flashSms,
    this.wifiName,
    this.autoArfcn,
    this.autoReset,
    this.wifiHidden,
    this.powerConfig,
    this.saveSentList,
    this.wifiPassword,
    this.isReboot = false,
    this.operators = const [],
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
    this.sender1,
    this.sender2,
    this.sender3,
    this.sender4,
    this.sender5,
    this.sms1,
    this.sms2,
    this.sms3,
    this.sms4,
    this.sms5,
  });

  factory FormMachineUpdateConfigModel.fromMachineConfigModel(
    String machineId,
    MachineConfigModel config,
  ) {
    return FormMachineUpdateConfigModel(
      machineId: machineId,
      count: int.tryParse(config.count ?? "0"),
      taskCount: int.tryParse(config.taskCount ?? "0"),
      isReboot: config.reboot == "1",
      autoArfcn: int.tryParse(config.autoArfcn ?? "0"),
      autoReset: int.tryParse(config.autoReset ?? "0"),
      flashSms: int.tryParse(config.flashSms ?? "0"),
      power: int.tryParse(config.power ?? "0"),
      powerConfig: config.powerConfig,
      saveSentList: int.tryParse(config.saveSentList ?? "0"),
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
      start: int.tryParse(config.start ?? "0"),
      wifiHidden: int.tryParse(config.wifiHidden ?? "0"),
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
    );
  }

  @override
  List<Object?> get props {
    return [
      machineId,
      count,
      taskCount,
      power,
      start,
      flashSms,
      wifiName,
      autoArfcn,
      autoReset,
      wifiHidden,
      powerConfig,
      saveSentList,
      wifiPassword,
      isReboot,
      operators,
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
      sender1,
      sender2,
      sender3,
      sender4,
      sender5,
      sms1,
      sms2,
      sms3,
      sms4,
      sms5,
    ];
  }

  @override
  bool get stringify => true;

  FormMachineUpdateConfigModel copyWith({
    String? machineId,
    int? count,
    int? taskCount,
    int? power,
    int? start,
    int? flashSms,
    String? wifiName,
    int? autoArfcn,
    int? autoReset,
    int? wifiHidden,
    String? powerConfig,
    int? saveSentList,
    String? wifiPassword,
    bool? isReboot,
    List<MachineConfigOperatorsModel>? operators,
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
    String? sender1,
    String? sender2,
    String? sender3,
    String? sender4,
    String? sender5,
    String? sms1,
    String? sms2,
    String? sms3,
    String? sms4,
    String? sms5,
  }) {
    return FormMachineUpdateConfigModel(
      machineId: machineId ?? this.machineId,
      count: count ?? this.count,
      taskCount: taskCount ?? this.taskCount,
      power: power ?? this.power,
      start: start ?? this.start,
      flashSms: flashSms ?? this.flashSms,
      wifiName: wifiName ?? this.wifiName,
      autoArfcn: autoArfcn ?? this.autoArfcn,
      autoReset: autoReset ?? this.autoReset,
      wifiHidden: wifiHidden ?? this.wifiHidden,
      powerConfig: powerConfig ?? this.powerConfig,
      saveSentList: saveSentList ?? this.saveSentList,
      wifiPassword: wifiPassword ?? this.wifiPassword,
      isReboot: isReboot ?? this.isReboot,
      operators: operators ?? this.operators,
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
      sender1: sender1 ?? this.sender1,
      sender2: sender2 ?? this.sender2,
      sender3: sender3 ?? this.sender3,
      sender4: sender4 ?? this.sender4,
      sender5: sender5 ?? this.sender5,
      sms1: sms1 ?? this.sms1,
      sms2: sms2 ?? this.sms2,
      sms3: sms3 ?? this.sms3,
      sms4: sms4 ?? this.sms4,
      sms5: sms5 ?? this.sms5,
    );
  }
}
