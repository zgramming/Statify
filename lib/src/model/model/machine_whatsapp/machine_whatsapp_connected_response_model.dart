import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_whatsapp_connected_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineWhatsappConnectedResponseModel extends Equatable {
  final String id;
  final String machineId;
  final String number;
  final String qrCode;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineWhatsappConnectedResponseModel({
    required this.id,
    required this.machineId,
    required this.number,
    required this.qrCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineWhatsappConnectedResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MachineWhatsappConnectedResponseModelFromJson(json);

  /// Connect the generated [_$MachineWhatsappConnectedResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineWhatsappConnectedResponseModelToJson(this);

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

  MachineWhatsappConnectedResponseModel copyWith({
    String? id,
    String? machineId,
    String? number,
    String? qrCode,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MachineWhatsappConnectedResponseModel(
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
