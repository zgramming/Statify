// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final List<MachineConfigOperatorsModel> operators;

  final bool? isReboot;
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
    this.operators = const [],
    required this.isReboot,
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
      operators,
      isReboot,
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
    List<MachineConfigOperatorsModel>? operators,
    bool? isReboot,
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
      operators: operators ?? this.operators,
      isReboot: isReboot ?? this.isReboot,
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
