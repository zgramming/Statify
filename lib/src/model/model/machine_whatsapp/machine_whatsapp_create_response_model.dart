import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'machine_whatsapp_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineWhatsappCreateResponseModel extends Equatable {
  final String id;
  final String userId;
  final String number;
  final String license;
  final String action;
  final String smsSetting;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<MachineWhatsappCreateResponseModelWhatsapp> whatsapps;

  const MachineWhatsappCreateResponseModel({
    required this.id,
    required this.userId,
    required this.number,
    required this.license,
    required this.action,
    required this.smsSetting,
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
      number,
      license,
      action,
      smsSetting,
      send,
      replied,
      createdAt,
      updatedAt,
      whatsapps,
    ];
  }

  @override
  bool get stringify => true;
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
