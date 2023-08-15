// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseModel extends Equatable {
  final String id;
  final String surveyId;
  final String key;
  final String value;
  final String status;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SurveyResponseModelSurvey survey;

  const SurveyResponseModel({
    required this.id,
    required this.surveyId,
    required this.key,
    required this.value,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.survey,
  });

  factory SurveyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseModelFromJson(json);

  /// Connect the generated [_$SurveyResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      surveyId,
      key,
      value,
      status,
      type,
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
class SurveyResponseModelSurvey extends Equatable {
  final String id;
  final String machineId;
  final String number;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyResponseModelSurvey({
    required this.id,
    required this.machineId,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyResponseModelSurvey.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseModelSurveyFromJson(json);

  /// Connect the generated [_$SurveyResponseModelSurveyToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyResponseModelSurveyToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      number,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
