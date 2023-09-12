// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response_sent_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseSentModel extends Equatable {
  final String id;
  final String surveyId;
  final String platform;
  final String key;
  final String value;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SurveySent survey;

  const SurveyResponseSentModel({
    required this.id,
    required this.surveyId,
    required this.platform,
    required this.key,
    required this.value,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.survey,
  });

  factory SurveyResponseSentModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseSentModelFromJson(json);

  /// Connect the generated [_$SurveyResponseSentModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyResponseSentModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      surveyId,
      platform,
      key,
      value,
      status,
      createdAt,
      updatedAt,
      survey,
    ];
  }

  @override
  bool get stringify => true;

  SurveyResponseSentModel copyWith({
    String? id,
    String? surveyId,
    String? platform,
    String? key,
    String? value,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    SurveySent? survey,
  }) {
    return SurveyResponseSentModel(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      platform: platform ?? this.platform,
      key: key ?? this.key,
      value: value ?? this.value,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      survey: survey ?? this.survey,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveySent extends Equatable {
  final String id;
  final String machineId;
  final String? machineWhatsappId;
  final String number;
  final bool locked;
  final int attempt;
  final DateTime? bannedUntil;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveySent({
    required this.id,
    required this.machineId,
    required this.machineWhatsappId,
    required this.number,
    required this.locked,
    required this.attempt,
    required this.bannedUntil,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveySent.fromJson(Map<String, dynamic> json) =>
      _$SurveySentFromJson(json);

  /// Connect the generated [_$SurveySentToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveySentToJson(this);

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
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  SurveySent copyWith({
    String? id,
    String? machineId,
    String? machineWhatsappId,
    String? number,
    bool? locked,
    int? attempt,
    DateTime? bannedUntil,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SurveySent(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      machineWhatsappId: machineWhatsappId ?? this.machineWhatsappId,
      number: number ?? this.number,
      locked: locked ?? this.locked,
      attempt: attempt ?? this.attempt,
      bannedUntil: bannedUntil ?? this.bannedUntil,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
