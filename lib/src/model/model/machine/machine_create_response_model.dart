import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineCreateResponseModel extends Equatable {
  final String id;
  final int send;
  final int replied;
  final String number;
  final String license;
  final String action;
  final String smsSetting;
  final String userId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final MachineCreateResponseModelUser user;

  const MachineCreateResponseModel({
    required this.id,
    required this.send,
    required this.replied,
    required this.number,
    required this.license,
    required this.action,
    required this.smsSetting,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.user,
  });

  factory MachineCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MachineCreateResponseModelFromJson(json);

  /// Connect the generated [_$MachineCreateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineCreateResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      send,
      replied,
      number,
      license,
      action,
      smsSetting,
      userId,
      updatedAt,
      createdAt,
      user,
    ];
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineCreateResponseModelUser extends Equatable {
  final String id;
  final String? email;
  final String username;
  final String? name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineCreateResponseModelUser({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineCreateResponseModelUser.fromJson(Map<String, dynamic> json) =>
      _$MachineCreateResponseModelUserFromJson(json);

  /// Connect the generated [_$MachineCreateResponseModelUserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineCreateResponseModelUserToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      email,
      username,
      name,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
