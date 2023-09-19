// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../machine_whatsapp/machine_whatsapp_model.dart';

part 'machine_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? activeSurveyId;
  final List<MachineWhatsappModel> whatsapps;

  const MachineModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
    required this.createdAt,
    required this.updatedAt,
    this.activeSurveyId,
    required this.whatsapps,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) =>
      _$MachineModelFromJson(json);

  /// Connect the generated [_$MachineModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      name,
      number,
      serialNumber,
      license,
      createdAt,
      updatedAt,
      activeSurveyId,
      whatsapps,
    ];
  }

  @override
  bool get stringify => true;
}
