import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_responden_response_fail_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyRespondenResponseFailModel extends Equatable {
  final String id;
  final String surveyId;
  final String platform;
  final String key;
  final String value;
  final String status;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyRespondenResponseFailModel({
    required this.id,
    required this.surveyId,
    required this.platform,
    required this.key,
    required this.value,
    required this.status,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyRespondenResponseFailModel.fromJson(
          Map<String, dynamic> json) =>
      _$SurveyRespondenResponseFailModelFromJson(json);

  /// Connect the generated [_$SurveyRespondenResponseFailModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$SurveyRespondenResponseFailModelToJson(this);

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
    ];
  }

  @override
  bool get stringify => true;
}
