// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_update.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UserUpdateResponseModel extends Equatable {
  final String id;
  final String? email;
  final String? username;
  final String? name;
  @JsonValue("sim_1")
  final String sim1;
  @JsonValue("sim_2")
  final String sim2;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserUpdateResponseModel({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.sim1,
    required this.sim2,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserUpdateResponseModelFromJson(json);

  /// Connect the generated [_$UserUpdateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserUpdateResponseModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      email,
      username,
      name,
      sim1,
      sim2,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  UserUpdateResponseModel copyWith({
    String? id,
    String? email,
    String? username,
    String? name,
    String? sim1,
    String? sim2,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserUpdateResponseModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      sim1: sim1 ?? this.sim1,
      sim2: sim2 ?? this.sim2,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
