// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'machine_response_delete_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineResponseDeleteResponseModel extends Equatable {
  final String id;
  final String machineId;
  final String platform;
  final String key;
  final String value;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineResponseDeleteResponseModel({
    required this.id,
    required this.machineId,
    required this.platform,
    required this.key,
    required this.value,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineResponseDeleteResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MachineResponseDeleteResponseModelFromJson(json);

  /// Connect the generated [_$MachineResponseDeleteResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineResponseDeleteResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      platform,
      key,
      value,
      type,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  MachineResponseDeleteResponseModel copyWith({
    String? id,
    String? machineId,
    String? platform,
    String? key,
    String? value,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MachineResponseDeleteResponseModel(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      platform: platform ?? this.platform,
      key: key ?? this.key,
      value: value ?? this.value,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
