import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UserModel extends Equatable {
  final String id;
  final String? email;
  final String username;
  final String? name;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<RoleModel> roles;
  final String? token;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      email,
      username,
      name,
      createdAt,
      updatedAt,
      roles,
      token,
    ];
  }

  @override
  bool get stringify => true;

  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<RoleModel>? roles,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      roles: roles ?? this.roles,
      token: token ?? this.token,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class RoleModel {
  final String id;
  final String name;
  final String label;
  final String pivotUserId;
  final String pivotRoleId;

  RoleModel({
    required this.id,
    required this.name,
    required this.label,
    required this.pivotUserId,
    required this.pivotRoleId,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) =>
      _$RoleModelFromJson(json);

  /// Connect the generated [_$RoleModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$RoleModelToJson(this);
}
