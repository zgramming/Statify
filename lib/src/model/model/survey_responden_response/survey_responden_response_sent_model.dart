import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_responden_response_sent_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyRespondenResponseSentModel extends Equatable {
  final String id;
  final String surveyId;
  final String platform;
  final String key;
  final String value;
  final String status;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SurveyResponseSentSrv survey;

  const SurveyRespondenResponseSentModel({
    required this.id,
    required this.surveyId,
    required this.platform,
    required this.key,
    required this.value,
    required this.status,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
    required this.survey,
  });

  factory SurveyRespondenResponseSentModel.fromJson(
          Map<String, dynamic> json) =>
      _$SurveyRespondenResponseSentModelFromJson(json);

  /// Connect the generated [_$SurveyRespondenResponseSentModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$SurveyRespondenResponseSentModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      surveyId,
      platform,
      key,
      value,
      status,
      finish,
      createdAt,
      updatedAt,
      survey,
    ];
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseSentSrv extends Equatable {
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
  const SurveyResponseSentSrv({
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

  factory SurveyResponseSentSrv.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseSentSrvFromJson(json);

  /// Connect the generated [_$SurveyResponseSentSrvToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyResponseSentSrvToJson(this);

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
