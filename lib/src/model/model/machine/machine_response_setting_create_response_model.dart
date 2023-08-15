// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_response_setting_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineResponseSettingCreateResponseModel extends Equatable {
  final String id;
  final String userId;
  final String number;
  final String license;
  final String action;
  final String smsSetting;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MachineResponseSettingCreateResponseModelSetting> settings;

  const MachineResponseSettingCreateResponseModel({
    required this.id,
    required this.userId,
    required this.number,
    required this.license,
    required this.action,
    required this.smsSetting,
    required this.send,
    required this.replied,
    required this.createdAt,
    required this.updatedAt,
    required this.settings,
  });

  factory MachineResponseSettingCreateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MachineResponseSettingCreateResponseModelFromJson(json);

  /// Connect the generated [_$MachineResponseSettingCreateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineResponseSettingCreateResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      userId,
      number,
      license,
      action,
      smsSetting,
      send,
      replied,
      createdAt,
      updatedAt,
      settings,
    ];
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineResponseSettingCreateResponseModelSetting extends Equatable {
  final String id;
  final String machineId;
  final String key;
  final String value;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineResponseSettingCreateResponseModelSetting({
    required this.id,
    required this.machineId,
    required this.key,
    required this.value,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineResponseSettingCreateResponseModelSetting.fromJson(
          Map<String, dynamic> json) =>
      _$MachineResponseSettingCreateResponseModelSettingFromJson(json);

  /// Connect the generated [_$MachineResponseSettingCreateResponseModelSettingToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineResponseSettingCreateResponseModelSettingToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      key,
      value,
      type,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
