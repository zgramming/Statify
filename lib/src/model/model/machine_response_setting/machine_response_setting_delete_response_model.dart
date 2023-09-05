// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_response_setting_delete_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineResponseSettingDeleteResponseModel extends Equatable {
  final String id;
  final String machineId;
  final String key;
  final String value;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineResponseSettingDeleteResponseModel({
    required this.id,
    required this.machineId,
    required this.key,
    required this.value,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineResponseSettingDeleteResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MachineResponseSettingDeleteResponseModelFromJson(json);

  /// Connect the generated [_$MachineResponseSettingDeleteResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineResponseSettingDeleteResponseModelToJson(this);

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

  MachineResponseSettingDeleteResponseModel copyWith({
    String? id,
    String? machineId,
    String? key,
    String? value,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MachineResponseSettingDeleteResponseModel(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      key: key ?? this.key,
      value: value ?? this.value,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
