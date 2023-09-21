import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_responden_by_number.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyRespondenByNumberModel extends Equatable {
  final String id;
  final String surveyId;
  final String? machineWhatsappId;
  final String number;
  final bool locked;
  final int attempt;
  final DateTime? bannedUntil;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyRespondenByNumberModel({
    required this.id,
    required this.surveyId,
    required this.machineWhatsappId,
    required this.number,
    required this.locked,
    required this.attempt,
    this.bannedUntil,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyRespondenByNumberModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyRespondenByNumberModelFromJson(json);

  /// Connect the generated [_$SurveyRespondenByNumberModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyRespondenByNumberModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      surveyId,
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
}
