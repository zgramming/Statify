import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'machine_setting_update_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineSettingUpdateResponseModel extends Equatable {
  final String id;
  final String machineId;
  final String platform;
  final bool usePassword;
  final int timeout;
  final int tries;
  final int backoff;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineSettingUpdateResponseModel({
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

  factory MachineSettingUpdateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MachineSettingUpdateResponseModelFromJson(json);

  /// Connect the generated [_$MachineSettingUpdateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineSettingUpdateResponseModelToJson(this);

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

  MachineSettingUpdateResponseModel copyWith({
    String? id,
    String? machineId,
    String? platform,
    bool? usePassword,
    int? timeout,
    int? tries,
    int? backoff,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MachineSettingUpdateResponseModel(
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
