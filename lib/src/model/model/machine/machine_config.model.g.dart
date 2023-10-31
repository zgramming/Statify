// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_config.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineConfigModel _$MachineConfigModelFromJson(Map<String, dynamic> json) =>
    MachineConfigModel(
      count: json['count'] as String?,
      power: json['power'] as String?,
      start: json['start'] as String?,
      reboot: json['reboot'] as String?,
      flashSms: json['flashSms'] as String?,
      wifiName: json['wifiName'] as String?,
      autoArfcn: json['autoArfcn'] as String?,
      autoReset: json['autoReset'] as String?,
      taskCount: json['taskCount'] as String?,
      wifiHidden: json['wifiHidden'] as String?,
      powerConfig: json['powerConfig'] as String?,
      saveSentList: json['saveSentList'] as String?,
      wifiPassword: json['wifiPassword'] as String?,
      unallowed: json['unallowed'] as String?,
      arfcnLabel2g: json['arfcnLabel2g'] as String?,
      arfcnLabel3g: json['arfcnLabel3g'] as String?,
      arfcnLabel4g: json['arfcnLabel4g'] as String?,
      arfcnLabel5g: json['arfcnLabel5g'] as String?,
      arfcnHidden2g: json['arfcnHidden2g'] as String?,
      arfcnHidden3g: json['arfcnHidden3g'] as String?,
      arfcnHidden4g: json['arfcnHidden4g'] as String?,
      arfcnHidden5g: json['arfcnHidden5g'] as String?,
      removeManager: json['removeManager'] as String?,
      managerPassword: json['managerPassword'] as String?,
      operators: (json['operators'] as List<dynamic>?)
              ?.map((e) => MachineConfigOperatorsModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      boardIps: (json['boardIps'] as List<dynamic>?)
              ?.map((e) =>
                  MachineBoardIpsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      countries: (json['countries'] as List<dynamic>?)
              ?.map((e) => MachineConfigCountriesModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      sms1: json['sms1'] as String?,
      sms2: json['sms2'] as String?,
      sms3: json['sms3'] as String?,
      sms4: json['sms4'] as String?,
      sms5: json['sms5'] as String?,
      sender1: json['sender1'] as String?,
      sender2: json['sender2'] as String?,
      sender3: json['sender3'] as String?,
      sender4: json['sender4'] as String?,
      sender5: json['sender5'] as String?,
    );

Map<String, dynamic> _$MachineConfigModelToJson(MachineConfigModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'power': instance.power,
      'start': instance.start,
      'reboot': instance.reboot,
      'flashSms': instance.flashSms,
      'wifiName': instance.wifiName,
      'autoArfcn': instance.autoArfcn,
      'autoReset': instance.autoReset,
      'taskCount': instance.taskCount,
      'wifiHidden': instance.wifiHidden,
      'powerConfig': instance.powerConfig,
      'saveSentList': instance.saveSentList,
      'wifiPassword': instance.wifiPassword,
      'unallowed': instance.unallowed,
      'arfcnLabel2g': instance.arfcnLabel2g,
      'arfcnLabel3g': instance.arfcnLabel3g,
      'arfcnLabel4g': instance.arfcnLabel4g,
      'arfcnLabel5g': instance.arfcnLabel5g,
      'arfcnHidden2g': instance.arfcnHidden2g,
      'arfcnHidden3g': instance.arfcnHidden3g,
      'arfcnHidden4g': instance.arfcnHidden4g,
      'arfcnHidden5g': instance.arfcnHidden5g,
      'removeManager': instance.removeManager,
      'managerPassword': instance.managerPassword,
      'operators': instance.operators,
      'boardIps': instance.boardIps,
      'countries': instance.countries,
      'sms1': instance.sms1,
      'sms2': instance.sms2,
      'sms3': instance.sms3,
      'sms4': instance.sms4,
      'sms5': instance.sms5,
      'sender1': instance.sender1,
      'sender2': instance.sender2,
      'sender3': instance.sender3,
      'sender4': instance.sender4,
      'sender5': instance.sender5,
    };
