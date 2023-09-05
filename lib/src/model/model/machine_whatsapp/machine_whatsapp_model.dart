import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';

part 'machine_whatsapp_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineWhatsappModel extends Equatable {
  final String id;
  final String machineId;
  final String number;
  final String? qrCode;
  final MachineWhatsappStatusEnum status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MachineWhatsappModel({
    required this.id,
    required this.machineId,
    required this.number,
    required this.qrCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineWhatsappModel.fromJson(Map<String, dynamic> json) =>
      _$MachineWhatsappModelFromJson(json);

  /// Connect the generated [_$MachineWhatsappModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineWhatsappModelToJson(this);

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
