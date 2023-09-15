// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      username: json['username'] as String?,
      name: json['name'] as String?,
      countryCode: json['country_code'] as String?,
      sim1: json['sim_1'] as String?,
      sim2: json['sim_2'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      token: json['token'] as String?,
      roles: (json['roles'] as List<dynamic>)
          .map((e) => UserRoleModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'name': instance.name,
      'country_code': instance.countryCode,
      'sim_1': instance.sim1,
      'sim_2': instance.sim2,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'token': instance.token,
      'roles': instance.roles,
    };

UserRoleModel _$UserRoleModelFromJson(Map<String, dynamic> json) =>
    UserRoleModel(
      id: json['id'] as String,
      name: json['name'] as String,
      label: json['label'] as String,
      pivotUserId: json['pivot_user_id'] as String,
      pivotRoleId: json['pivot_role_id'] as String,
    );

Map<String, dynamic> _$UserRoleModelToJson(UserRoleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'label': instance.label,
      'pivot_user_id': instance.pivotUserId,
      'pivot_role_id': instance.pivotRoleId,
    };
