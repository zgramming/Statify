// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UserModel extends Equatable {
  final List<UserRoleModel> roles;
  final String id;
  final String? email;
  final String username;
  final String name;
  final String? countryCode;
  @JsonKey(name: "sim_1")
  final String? sim1;
  @JsonKey(name: "sim_2")
  final String? sim2;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? token;

  const UserModel({
    required this.roles,
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    this.countryCode,
    this.sim1,
    this.sim2,
    required this.createdAt,
    required this.updatedAt,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props {
    return [
      roles,
      id,
      email,
      username,
      name,
      countryCode,
      sim1,
      sim2,
      createdAt,
      updatedAt,
      token,
    ];
  }

  @override
  bool get stringify => true;

  UserModel copyWith({
    List<UserRoleModel>? roles,
    String? id,
    String? email,
    String? username,
    String? name,
    String? countryCode,
    String? sim1,
    String? sim2,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
  }) {
    return UserModel(
      roles: roles ?? this.roles,
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      sim1: sim1 ?? this.sim1,
      sim2: sim2 ?? this.sim2,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UserRoleModel {
  final String id;
  final String name;
  final String label;
  final String pivotUserId;
  final String pivotRoleId;

  UserRoleModel({
    required this.id,
    required this.name,
    required this.label,
    required this.pivotUserId,
    required this.pivotRoleId,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) =>
      _$UserRoleModelFromJson(json);

  /// Connect the generated [_$UserRoleModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserRoleModelToJson(this);
}
