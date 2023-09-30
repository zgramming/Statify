// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_group.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineGroupModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String masterMachineId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final MasterMachineGroup? master;
  final List<MasterMachineGroup>? machines;
  const MachineGroupModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.masterMachineId,
    required this.createdAt,
    required this.updatedAt,
    this.master,
    this.machines,
  });

  factory MachineGroupModel.fromJson(Map<String, dynamic> json) =>
      _$MachineGroupModelFromJson(json);

  /// Connect the generated [_$MachineGroupModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineGroupModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      name,
      masterMachineId,
      createdAt,
      updatedAt,
      master,
      machines,
    ];
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MasterMachineGroup extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final int totalSmsSent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? activeSurveyId;
  final String? pivotMachineGroupId;
  final String? pivotMachineId;
  const MasterMachineGroup({
    required this.id,
    required this.userId,
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
    required this.totalSmsSent,
    required this.createdAt,
    required this.updatedAt,
    this.activeSurveyId,
    this.pivotMachineGroupId,
    this.pivotMachineId,
  });

  factory MasterMachineGroup.fromJson(Map<String, dynamic> json) =>
      _$MasterMachineGroupFromJson(json);

  /// Connect the generated [_$MasterMachineGroupToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MasterMachineGroupToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      name,
      number,
      serialNumber,
      license,
      totalSmsSent,
      createdAt,
      updatedAt,
      activeSurveyId,
      pivotMachineGroupId,
      pivotMachineId,
    ];
  }

  @override
  bool get stringify => true;
}
