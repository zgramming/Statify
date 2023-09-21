import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_responden_create.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyRespondenCreateModel extends Equatable {
  final String id;
  final String surveyRespondentId;
  final String platform;
  final String key;
  final String value;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool finish;

  const SurveyRespondenCreateModel({
    required this.id,
    required this.surveyRespondentId,
    required this.platform,
    required this.key,
    required this.value,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.finish,
  });

  factory SurveyRespondenCreateModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyRespondenCreateModelFromJson(json);

  /// Connect the generated [_$SurveyRespondenCreateModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyRespondenCreateModelToJson(this);

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
    ];
  }

  @override
  bool get stringify => true;
}
