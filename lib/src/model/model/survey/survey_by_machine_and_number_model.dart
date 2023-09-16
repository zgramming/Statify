import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_by_machine_and_number_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyByMachineAndNumberModel extends Equatable {
  final String id;
  final String machineId;
  final String? machineWhatsappId;
  final String number;
  final bool locked;
  final int attempt;
  final DateTime? bannedUntil;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyByMachineAndNumberModel({
    required this.id,
    required this.machineId,
    required this.machineWhatsappId,
    required this.number,
    required this.locked,
    required this.attempt,
    this.bannedUntil,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyByMachineAndNumberModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyByMachineAndNumberModelFromJson(json);

  /// Connect the generated [_$SurveyByMachineAndNumberModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyByMachineAndNumberModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      machineId,
      machineWhatsappId,
      number,
      locked,
      attempt,
      bannedUntil,
      finish,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  SurveyByMachineAndNumberModel copyWith({
    String? id,
    String? machineId,
    String? machineWhatsappId,
    String? number,
    bool? locked,
    int? attempt,
    DateTime? bannedUntil,
    bool? finish,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SurveyByMachineAndNumberModel(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      machineWhatsappId: machineWhatsappId ?? this.machineWhatsappId,
      number: number ?? this.number,
      locked: locked ?? this.locked,
      attempt: attempt ?? this.attempt,
      bannedUntil: bannedUntil ?? this.bannedUntil,
      finish: finish ?? this.finish,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
