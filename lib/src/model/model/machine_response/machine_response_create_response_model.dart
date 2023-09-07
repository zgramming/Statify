// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';

part 'machine_response_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineResponseCreateResponseModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String license;
  final MachineActionEnum action;
  final String smsSetting;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Response> responses;

  const MachineResponseCreateResponseModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.number,
    required this.license,
    required this.action,
    required this.smsSetting,
    required this.send,
    required this.replied,
    required this.createdAt,
    required this.updatedAt,
    required this.responses,
  });

  factory MachineResponseCreateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MachineResponseCreateResponseModelFromJson(json);

  /// Connect the generated [_$MachineResponseCreateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineResponseCreateResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      userId,
      name,
      number,
      license,
      action,
      smsSetting,
      send,
      replied,
      createdAt,
      updatedAt,
      responses,
    ];
  }

  @override
  bool get stringify => true;

  MachineResponseCreateResponseModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? number,
    String? license,
    MachineActionEnum? action,
    String? smsSetting,
    int? send,
    int? replied,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Response>? responses,
  }) {
    return MachineResponseCreateResponseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      number: number ?? this.number,
      license: license ?? this.license,
      action: action ?? this.action,
      smsSetting: smsSetting ?? this.smsSetting,
      send: send ?? this.send,
      replied: replied ?? this.replied,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      responses: responses ?? this.responses,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Response extends Equatable {
  final String id;
  final String machineId;
  final MachineResponsePlatform platform;
  final String key;
  final String value;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Response({
    required this.id,
    required this.machineId,
    required this.platform,
    required this.key,
    required this.value,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Response.fromJson(Map<String, dynamic> json) =>
      _$ResponseFromJson(json);

  /// Connect the generated [_$ResponseToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ResponseToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      platform,
      key,
      value,
      type,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  Response copyWith({
    String? id,
    String? machineId,
    MachineResponsePlatform? platform,
    String? key,
    String? value,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Response(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      platform: platform ?? this.platform,
      key: key ?? this.key,
      value: value ?? this.value,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
