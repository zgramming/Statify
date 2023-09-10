// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';
import '../../../utils/functions.dart';

part 'machine_setting_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineSettingModel extends Equatable {
  final String id;
  final String machineId;
  final MachineResponsePlatformEnum platform;
  final bool usePassword;
  final int timeout;
  final int tries;
  final int backoff;
  final DateTime createdAt;
  final DateTime updatedAt;

  String? get settingByPlatformReadable {
    final result = getMachineSettingPlatformReadable(
      usePassword: usePassword,
      timeout: timeout,
      tries: tries,
      backoff: backoff,
    );
    return result;
  }

  const MachineSettingModel({
    required this.id,
    required this.machineId,
    required this.platform,
    required this.usePassword,
    required this.timeout,
    required this.tries,
    required this.backoff,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineSettingModel.fromJson(Map<String, dynamic> json) =>
      _$MachineSettingModelFromJson(json);

  /// Connect the generated [_$MachineSettingModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineSettingModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      platform,
      usePassword,
      timeout,
      tries,
      backoff,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  MachineSettingModel copyWith({
    String? id,
    String? machineId,
    MachineResponsePlatformEnum? platform,
    bool? usePassword,
    int? timeout,
    int? tries,
    int? backoff,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MachineSettingModel(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      platform: platform ?? this.platform,
      usePassword: usePassword ?? this.usePassword,
      timeout: timeout ?? this.timeout,
      tries: tries ?? this.tries,
      backoff: backoff ?? this.backoff,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
