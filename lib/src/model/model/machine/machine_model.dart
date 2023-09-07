// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';
import '../machine_setting/machine_setting_model.dart';
import '../machine_whatsapp/machine_whatsapp_model.dart';

part 'machine_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineModel extends Equatable {
  final String id;
  final String userId;
  final String serialNumber;
  final String name;
  final String number;
  final String license;
  final String action;
  final String smsSetting;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MachineWhatsappModel> whatsapps;
  final List<MachineSettingModel> settings;

  MachineSettingModel? get settingsPlatformSMS {
    final result = settings
        .where((element) => element.platform == MachineResponsePlatform.sms)
        .toList();

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  MachineSettingModel? get settingsPlatformWhatsapp {
    final result = settings
        .where(
            (element) => element.platform == MachineResponsePlatform.whatsapp)
        .toList();

    if (result.isEmpty) {
      return null;
    }

    return result.first;
  }

  String? settingByPlatformReadable(MachineSettingModel? setting) {
    if (setting == null) {
      return null;
    }

    if (setting.usePassword == 1) {
      return """
Only Invited Numbers Can Join Survey \n
Invitation Password Timeout since received : ${setting.timeout} hours \n
Disqualified / Banned Numbers for ${setting.backoff} hours, when ${setting.tries} times wrong password
""";
    }

    return "All Numbers Can Join Survey";
  }

  const MachineModel({
    required this.id,
    required this.userId,
    required this.serialNumber,
    required this.name,
    required this.number,
    required this.license,
    required this.action,
    required this.smsSetting,
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
      serialNumber,
      name,
      number,
      license,
      action,
      smsSetting,
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
    String? serialNumber,
    String? name,
    String? number,
    String? license,
    String? action,
    String? smsSetting,
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
      serialNumber: serialNumber ?? this.serialNumber,
      name: name ?? this.name,
      number: number ?? this.number,
      license: license ?? this.license,
      action: action ?? this.action,
      smsSetting: smsSetting ?? this.smsSetting,
      send: send ?? this.send,
      replied: replied ?? this.replied,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      whatsapps: whatsapps ?? this.whatsapps,
      settings: settings ?? this.settings,
    );
  }
}
