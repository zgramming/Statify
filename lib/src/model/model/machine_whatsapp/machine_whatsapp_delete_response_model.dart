import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'machine_whatsapp_delete_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineWhatsappDeleteResponseModel extends Equatable {
  final String id;
  final String machineId;
  final String number;
  final String qrCode;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineWhatsappDeleteResponseModel({
    required this.id,
    required this.machineId,
    required this.number,
    required this.qrCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineWhatsappDeleteResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MachineWhatsappDeleteResponseModelFromJson(json);

  /// Connect the generated [_$MachineWhatsappDeleteResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineWhatsappDeleteResponseModelToJson(this);

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

  MachineWhatsappDeleteResponseModel copyWith({
    String? id,
    String? machineId,
    String? number,
    String? qrCode,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MachineWhatsappDeleteResponseModel(
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
