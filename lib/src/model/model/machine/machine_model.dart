// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';
import '../../../utils/functions.dart';
import '../machine_setting/machine_setting_model.dart';
import '../machine_whatsapp/machine_whatsapp_model.dart';

part 'machine_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final MachineActionEnum action;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MachineWhatsappModel> whatsapps;
  final List<MachineSettingModel> settings;

  MachineSettingModel? get settingsPlatformSMS {
    final result = getMachineSettingPlatformList(
      settings,
      MachineResponsePlatformEnum.sms,
    );

    return result;
  }

  MachineSettingModel? get settingsPlatformWhatsapp {
    final result = getMachineSettingPlatformList(
      settings,
      MachineResponsePlatformEnum.whatsapp,
    );

    return result;
  }

  String? settingByPlatformReadable(MachineSettingModel? setting) {
    final result = getMachineSettingPlatformReadable(
      usePassword: setting?.usePassword,
      timeout: setting?.timeout,
      tries: setting?.tries,
      backoff: setting?.backoff,
    );
    return result;
  }

  const MachineModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
    required this.action,
    required this.send,
    required this.replied,
    required this.createdAt,
    required this.updatedAt,
    required this.whatsapps,
    required this.settings,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) =>
      _$MachineModelFromJson(json);

  /// Connect the generated [_$MachineModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      userId,
      name,
      number,
      serialNumber,
      license,
      action,
      send,
      replied,
      createdAt,
      updatedAt,
      whatsapps,
      settings,
    ];
  }

  @override
  bool get stringify => true;

  MachineModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? number,
    String? serialNumber,
    String? license,
    MachineActionEnum? action,
    int? send,
    int? replied,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<MachineWhatsappModel>? whatsapps,
    List<MachineSettingModel>? settings,
  }) {
    return MachineModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      number: number ?? this.number,
      serialNumber: serialNumber ?? this.serialNumber,
      license: license ?? this.license,
      action: action ?? this.action,
      send: send ?? this.send,
      replied: replied ?? this.replied,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      whatsapps: whatsapps ?? this.whatsapps,
      settings: settings ?? this.settings,
    );
  }
}
