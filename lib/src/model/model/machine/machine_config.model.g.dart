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
      unallowed: json['unallowed'] as String?,
      wifiHidden: json['wifiHidden'] as String?,
      powerConfig: json['powerConfig'] as String?,
      arfcnLabel2G: json['arfcnLabel2G'] as String?,
      arfcnLabel3G: json['arfcnLabel3G'] as String?,
      arfcnLabel4G: json['arfcnLabel4G'] as String?,
      arfcnLabel5G: json['arfcnLabel5G'] as String?,
      saveSentList: json['saveSentList'] as String?,
      wifiPassword: json['wifiPassword'] as String?,
      arfcnHidden2G: json['arfcnHidden2G'] as String?,
      arfcnHidden3G: json['arfcnHidden3G'] as String?,
      arfcnHidden4G: json['arfcnHidden4G'] as String?,
      arfcnHidden5G: json['arfcnHidden5G'] as String?,
      removeManager: json['removeManager'] as String?,
      managerPassword: json['managerPassword'] as String?,
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
      'unallowed': instance.unallowed,
      'wifiHidden': instance.wifiHidden,
      'powerConfig': instance.powerConfig,
      'arfcnLabel2G': instance.arfcnLabel2G,
      'arfcnLabel3G': instance.arfcnLabel3G,
      'arfcnLabel4G': instance.arfcnLabel4G,
      'arfcnLabel5G': instance.arfcnLabel5G,
      'saveSentList': instance.saveSentList,
      'wifiPassword': instance.wifiPassword,
      'arfcnHidden2G': instance.arfcnHidden2G,
      'arfcnHidden3G': instance.arfcnHidden3G,
      'arfcnHidden4G': instance.arfcnHidden4G,
      'arfcnHidden5G': instance.arfcnHidden5G,
      'removeManager': instance.removeManager,
      'managerPassword': instance.managerPassword,
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
      'operators': instance.operators,
      'boardIps': instance.boardIps,
      'countries': instance.countries,
    };
