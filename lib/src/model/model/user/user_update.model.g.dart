// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserUpdateResponseModel _$UserUpdateResponseModelFromJson(
        Map<String, dynamic> json) =>
    UserUpdateResponseModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      username: json['username'] as String,
      name: json['name'] as String,
      countryCode: json['country_code'] as String?,
      sim1: json['sim1'] as String?,
      sim2: json['sim2'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$UserUpdateResponseModelToJson(
        UserUpdateResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'name': instance.name,
      'country_code': instance.countryCode,
      'sim1': instance.sim1,
      'sim2': instance.sim2,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
