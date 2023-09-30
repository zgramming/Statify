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
  final String type;
  final String key;
  final String value;
  final String status;
  final bool finish;
  final bool voting;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyRespondenCreateModel({
    required this.id,
    required this.surveyRespondentId,
    required this.platform,
    required this.type,
    required this.key,
    required this.value,
    required this.status,
    required this.finish,
    required this.voting,
    required this.createdAt,
    required this.updatedAt,
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
      type,
      key,
      value,
      status,
      finish,
      voting,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
