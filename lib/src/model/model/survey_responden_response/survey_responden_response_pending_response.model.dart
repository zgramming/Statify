import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_responden_response_pending_response.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyRespondenResponsePendingResponseModel extends Equatable {
  final String id;
  final String surveyRespondentId;
  final String platform;
  final String key;
  final String value;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool finish;
  final SurveyResponseSurvey survey;

  const SurveyRespondenResponsePendingResponseModel({
    required this.id,
    required this.surveyRespondentId,
    required this.platform,
    required this.key,
    required this.value,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.finish,
    required this.survey,
  });

  factory SurveyRespondenResponsePendingResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$SurveyRespondenResponsePendingResponseModelFromJson(json);

  /// Connect the generated [_$SurveyRespondenResponsePendingResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$SurveyRespondenResponsePendingResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      surveyRespondentId,
      platform,
      key,
      value,
      status,
      createdAt,
      updatedAt,
      finish,
      survey,
    ];
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseSurvey extends Equatable {
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
  const SurveyResponseSurvey({
    required this.id,
    required this.machineId,
    this.machineWhatsappId,
    required this.number,
    required this.locked,
    required this.attempt,
    this.bannedUntil,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyResponseSurvey.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseSurveyFromJson(json);

  /// Connect the generated [_$SurveyResponseSurveyToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyResponseSurveyToJson(this);

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
}
