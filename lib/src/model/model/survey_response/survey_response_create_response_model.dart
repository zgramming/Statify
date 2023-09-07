// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseCreateResponseModel extends Equatable {
  final String id;
  final String surveyId;
  final String key;
  final String value;
  final String status;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SurveyResponseCreateResponseModel({
    required this.id,
    required this.surveyId,
    required this.key,
    required this.value,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyResponseCreateResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$SurveyResponseCreateResponseModelFromJson(json);

  /// Connect the generated [_$SurveyResponseCreateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$SurveyResponseCreateResponseModelToJson(this);

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

  SurveyResponseCreateResponseModel copyWith({
    String? id,
    String? surveyId,
    String? key,
    String? value,
    String? status,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SurveyResponseCreateResponseModel(
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
