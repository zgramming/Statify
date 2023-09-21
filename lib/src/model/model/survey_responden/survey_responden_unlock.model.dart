import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_responden_unlock.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyRespondenUnlockModel extends Equatable {
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

  const SurveyRespondenUnlockModel({
    required this.id,
    required this.surveyId,
    this.machineWhatsappId,
    required this.number,
    required this.locked,
    required this.attempt,
    this.bannedUntil,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyRespondenUnlockModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyRespondenUnlockModelFromJson(json);

  /// Connect the generated [_$SurveyRespondenUnlockModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyRespondenUnlockModelToJson(this);

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
