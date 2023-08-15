// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authentication_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticationResponseModel _$AuthenticationResponseModelFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponseModel(
      expiresIn: json['expires_in'] as int,
      token: json['token'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$AuthenticationResponseModelToJson(
        AuthenticationResponseModel instance) =>
    <String, dynamic>{
      'expires_in': instance.expiresIn,
      'token': instance.token,
      'type': instance.type,
    };
