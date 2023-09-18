import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_responden_response_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyRespondenResponseCreateResponseModel extends Equatable {
  final String id;
  final String surveyId;
  final String platform;
  final String key;
  final String value;
  final String status;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyRespondenResponseCreateResponseModel({
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

  factory SurveyRespondenResponseCreateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$SurveyRespondenResponseCreateResponseModelFromJson(json);

  /// Connect the generated [_$SurveyRespondenResponseCreateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$SurveyRespondenResponseCreateResponseModelToJson(this);

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
