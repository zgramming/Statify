// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineCreateResponseModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? activeSurveyId;

  const MachineCreateResponseModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
    required this.createdAt,
    required this.updatedAt,
    this.activeSurveyId,
  });

  factory MachineCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MachineCreateResponseModelFromJson(json);

  /// Connect the generated [_$MachineCreateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineCreateResponseModelToJson(this);

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
    ];
  }

  @override
  bool get stringify => true;
}
