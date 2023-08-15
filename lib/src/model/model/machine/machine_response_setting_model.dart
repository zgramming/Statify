import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_response_setting_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineResponseSettingModel extends Equatable {
  final String id;
  final String machineId;
  final String key;
  final String value;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineResponseSettingModel({
    required this.id,
    required this.machineId,
    required this.key,
    required this.value,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineResponseSettingModel.fromJson(Map<String, dynamic> json) =>
      _$MachineResponseSettingModelFromJson(json);

  /// Connect the generated [_$MachineResponseSettingModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineResponseSettingModelToJson(this);

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
