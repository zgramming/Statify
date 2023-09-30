import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineCreateResponseModel extends Equatable {
  final String id;
  final int totalSmsSent;
  final bool group;
  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final String userId;
  final DateTime updatedAt;
  final DateTime createdAt;

  const MachineCreateResponseModel({
    required this.id,
    required this.totalSmsSent,
    required this.group,
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
  });

  factory MachineCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MachineCreateResponseModelFromJson(json);

  /// Connect the generated [_$MachineCreateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineCreateResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      totalSmsSent,
      group,
      name,
      number,
      serialNumber,
      license,
      userId,
      updatedAt,
      createdAt,
    ];
  }

  @override
  bool get stringify => true;
}
