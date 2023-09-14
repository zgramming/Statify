// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_whatsapp_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineWhatsappCreateResponseModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final String action;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MachineWhatsappCreateResponseModelWhatsapp> whatsapps;

  const MachineWhatsappCreateResponseModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
    required this.action,
    required this.send,
    required this.replied,
    required this.createdAt,
    required this.updatedAt,
    required this.whatsapps,
  });

  factory MachineWhatsappCreateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MachineWhatsappCreateResponseModelFromJson(json);

  /// Connect the generated [_$MachineWhatsappCreateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineWhatsappCreateResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      userId,
      name,
      number,
      serialNumber,
      license,
      action,
      send,
      replied,
      createdAt,
      updatedAt,
      whatsapps,
    ];
  }

  @override
  bool get stringify => true;

  MachineWhatsappCreateResponseModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? number,
    String? serialNumber,
    String? license,
    String? action,
    int? send,
    int? replied,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<MachineWhatsappCreateResponseModelWhatsapp>? whatsapps,
  }) {
    return MachineWhatsappCreateResponseModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      number: number ?? this.number,
      serialNumber: serialNumber ?? this.serialNumber,
      license: license ?? this.license,
      action: action ?? this.action,
      send: send ?? this.send,
      replied: replied ?? this.replied,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      whatsapps: whatsapps ?? this.whatsapps,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineWhatsappCreateResponseModelWhatsapp extends Equatable {
  final String id;
  final String machineId;
  final String number;
  final String? qrCode;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineWhatsappCreateResponseModelWhatsapp({
    required this.id,
    required this.machineId,
    required this.number,
    required this.qrCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineWhatsappCreateResponseModelWhatsapp.fromJson(
          Map<String, dynamic> json) =>
      _$MachineWhatsappCreateResponseModelWhatsappFromJson(json);

  /// Connect the generated [_$MachineWhatsappCreateResponseModelWhatsappToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineWhatsappCreateResponseModelWhatsappToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      machineId,
      number,
      qrCode,
      status,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
