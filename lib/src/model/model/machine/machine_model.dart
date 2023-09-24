// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'machine_summary.model.dart';

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
  final MachineSummaryModel? summary;

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
    this.summary,
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
      summary,
    ];
  }

  @override
  bool get stringify => true;

  MachineModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? number,
    String? serialNumber,
    String? license,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? activeSurveyId,
    MachineSummaryModel? summary,
  }) {
    return MachineModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      number: number ?? this.number,
      serialNumber: serialNumber ?? this.serialNumber,
      license: license ?? this.license,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      activeSurveyId: activeSurveyId ?? this.activeSurveyId,
      summary: summary ?? this.summary,
    );
  }
}
