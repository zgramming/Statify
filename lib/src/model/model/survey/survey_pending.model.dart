// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_pending.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyPendingModel extends Equatable {
  final String id;
  final String surveyRespondentId;
  final String platform;
  final String key;
  final String value;
  final String status;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SurveyPendingRespondenModel responden;

  const SurveyPendingModel({
    required this.id,
    required this.surveyRespondentId,
    required this.platform,
    required this.key,
    required this.value,
    required this.status,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
    required this.responden,
  });

  factory SurveyPendingModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyPendingModelFromJson(json);

  /// Connect the generated [_$SurveyPendingModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyPendingModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      surveyRespondentId,
      platform,
      key,
      value,
      status,
      finish,
      createdAt,
      updatedAt,
      responden,
    ];
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyPendingRespondenModel extends Equatable {
  final String id;
  final String surveyId;
  final dynamic machineWhatsappId;
  final String number;
  final bool locked;
  final int attempt;
  final dynamic bannedUntil;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SurveyPendingRespondenModel({
    required this.id,
    required this.surveyId,
    required this.machineWhatsappId,
    required this.number,
    required this.locked,
    required this.attempt,
    required this.bannedUntil,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyPendingRespondenModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyPendingRespondenModelFromJson(json);

  /// Connect the generated [_$SurveyPendingRespondenModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyPendingRespondenModelToJson(this);

  @override
  List<Object> get props {
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
