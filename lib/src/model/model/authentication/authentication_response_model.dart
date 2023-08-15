import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authentication_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class AuthenticationResponseModel extends Equatable {
  final int expiresIn;
  final String token;
  final String type;

  const AuthenticationResponseModel({
    required this.expiresIn,
    required this.token,
    required this.type,
  });

  factory AuthenticationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseModelFromJson(json);

  /// Connect the generated [_$AuthenticationResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AuthenticationResponseModelToJson(this);

  @override
  List<Object> get props => [expiresIn, token, type];

  @override
  bool get stringify => true;
}
