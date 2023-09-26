// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_whatsapp_update_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineWhatsappUpdateResponseModel extends Equatable {
  final String id;
  final String machineId;
  final String number;
  final String qrCode;
  final String status;
  final int totalReplied;
  final int totalFinished;
  final int totalVoted;
  final int totalSent;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MachineWhatsappUpdateResponseModel({
    required this.id,
    required this.machineId,
    required this.number,
    required this.qrCode,
    required this.status,
    required this.totalReplied,
    required this.totalFinished,
    required this.totalVoted,
    required this.totalSent,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MachineWhatsappUpdateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MachineWhatsappUpdateResponseModelFromJson(json);

  /// Connect the generated [_$MachineWhatsappUpdateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$MachineWhatsappUpdateResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      number,
      qrCode,
      status,
      totalReplied,
      totalFinished,
      totalVoted,
      totalSent,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
