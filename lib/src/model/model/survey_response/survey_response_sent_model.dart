import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response_sent_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseSentModel extends Equatable {
  final String id;
  final String surveyId;
  final String key;
  final String value;
  final String status;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SurveyResponseSentModel({
    required this.id,
    required this.surveyId,
    required this.key,
    required this.value,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
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
      key,
      value,
      status,
      type,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  SurveyResponseSentModel copyWith({
    String? id,
    String? surveyId,
    String? key,
    String? value,
    String? status,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SurveyResponseSentModel(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      key: key ?? this.key,
      value: value ?? this.value,
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
