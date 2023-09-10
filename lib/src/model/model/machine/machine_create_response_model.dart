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
  final String serialNumber;
  final String name;
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
    required this.serialNumber,
    required this.name,
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
      serialNumber,
      name,
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

  MachineCreateResponseModel copyWith({
    String? id,
    int? send,
    int? replied,
    String? serialNumber,
    String? name,
    String? number,
    String? license,
    String? action,
    String? smsSetting,
    String? userId,
    DateTime? updatedAt,
    DateTime? createdAt,
    MachineCreateResponseModelUser? user,
  }) {
    return MachineCreateResponseModel(
      id: id ?? this.id,
      send: send ?? this.send,
      replied: replied ?? this.replied,
      serialNumber: serialNumber ?? this.serialNumber,
      name: name ?? this.name,
      number: number ?? this.number,
      license: license ?? this.license,
      action: action ?? this.action,
      smsSetting: smsSetting ?? this.smsSetting,
      userId: userId ?? this.userId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      user: user ?? this.user,
    );
  }
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
