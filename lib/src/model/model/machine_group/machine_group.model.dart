import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../machine/machine_model.dart';

part 'machine_group.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineGroupModel extends Equatable {
  final String id;
  final String name;
  final String userId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final List<MachineModel>? machines;

  const MachineGroupModel({
    required this.id,
    required this.name,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    this.machines = const [],
  });

  factory MachineGroupModel.fromJson(Map<String, dynamic> json) =>
      _$MachineGroupModelFromJson(json);

  /// Connect the generated [_$MachineGroupModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineGroupModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      name,
      userId,
      updatedAt,
      createdAt,
      machines,
    ];
  }

  @override
  bool get stringify => true;
}
