import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';

part 'survey_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseModel extends Equatable {
  final String id;
  final String surveyId;
  final MachineResponsePlatformEnum platform;
  final String key;
  final String value;
  final MachineResponseTypeEnum type;
  final bool voting;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyResponseModel({
    required this.id,
    required this.surveyId,
    required this.platform,
    required this.key,
    required this.value,
    required this.type,
    required this.voting,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
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
      platform,
      key,
      value,
      type,
      voting,
      finish,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
