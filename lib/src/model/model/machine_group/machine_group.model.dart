// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../machine/machine_model.dart';

part 'machine_group.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineGroupModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? masterId;
  final bool copySetting;
  final bool copySmsSetting;
  final List<MachineModel>? machines;

  const MachineGroupModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.masterId,
    required this.copySetting,
    required this.copySmsSetting,
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
      userId,
      name,
      createdAt,
      updatedAt,
      masterId,
      copySetting,
      copySmsSetting,
      machines,
    ];
  }

  @override
  bool get stringify => true;

  MachineGroupModel copyWith({
    String? id,
    String? userId,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? masterId,
    bool? copySetting,
    bool? copySmsSetting,
    List<MachineModel>? machines,
  }) {
    return MachineGroupModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      masterId: masterId ?? this.masterId,
      copySetting: copySetting ?? this.copySetting,
      copySmsSetting: copySmsSetting ?? this.copySmsSetting,
      machines: machines ?? this.machines,
    );
  }
}
