import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_whatsapp_disconnected_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineWhatsappDisconnectedResponseModel extends Equatable {
  final String id;
  final String machineId;
  final String number;
  final String qrCode;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineWhatsappDisconnectedResponseModel({
    required this.id,
    required this.machineId,
    required this.number,
    required this.qrCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineWhatsappDisconnectedResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MachineWhatsappDisconnectedResponseModelFromJson(json);

  /// Connect the generated [_$MachineWhatsappDisconnectedResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineWhatsappDisconnectedResponseModelToJson(this);

  @override
  List<Object> get props {
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

  MachineWhatsappDisconnectedResponseModel copyWith({
    String? id,
    String? machineId,
    String? number,
    String? qrCode,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MachineWhatsappDisconnectedResponseModel(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      number: number ?? this.number,
      qrCode: qrCode ?? this.qrCode,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
