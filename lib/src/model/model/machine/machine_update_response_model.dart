import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_update_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineUpdateResponseModel extends Equatable {
  final String id;
  final String userId;
  final String serialNumber;
  final String name;
  final String number;
  final String license;
  final String action;
  final String smsSetting;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineUpdateResponseModel({
    required this.id,
    required this.userId,
    required this.serialNumber,
    required this.name,
    required this.number,
    required this.license,
    required this.action,
    required this.smsSetting,
    required this.send,
    required this.replied,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MachineUpdateResponseModelFromJson(json);

  /// Connect the generated [_$MachineUpdateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineUpdateResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      userId,
      serialNumber,
      name,
      number,
      license,
      action,
      smsSetting,
      send,
      replied,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  MachineUpdateResponseModel copyWith({
    String? id,
    String? userId,
    String? serialNumber,
    String? name,
    String? number,
    String? license,
    String? action,
    String? smsSetting,
    int? send,
    int? replied,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MachineUpdateResponseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      serialNumber: serialNumber ?? this.serialNumber,
      name: name ?? this.name,
      number: number ?? this.number,
      license: license ?? this.license,
      action: action ?? this.action,
      smsSetting: smsSetting ?? this.smsSetting,
      send: send ?? this.send,
      replied: replied ?? this.replied,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineUpdateResponseModelUser extends Equatable {
  final String id;
  final String? email;
  final String username;
  final String? name;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineUpdateResponseModelUser({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineUpdateResponseModelUser.fromJson(Map<String, dynamic> json) =>
      _$MachineUpdateResponseModelUserFromJson(json);

  /// Connect the generated [_$MachineUpdateResponseModelUserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineUpdateResponseModelUserToJson(this);

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
