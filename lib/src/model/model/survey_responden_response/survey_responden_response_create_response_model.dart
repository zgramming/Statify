import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_responden_response_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyRespondenResponseCreateResponseModel extends Equatable {
  final String id;
  final String surveyRespondentId;
  final String platform;
  final String key;
  final String value;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool finish;

  const SurveyRespondenResponseCreateResponseModel({
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
