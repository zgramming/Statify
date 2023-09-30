import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_summary.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveySummaryModel extends Equatable {
  final String key;
  final int count;
  const SurveySummaryModel({
    required this.key,
    required this.count,
  });

  factory SurveySummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SurveySummaryModelFromJson(json);

  /// Connect the generated [_$SurveySummaryModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveySummaryModelToJson(this);

  @override
  List<Object> get props => [key, count];

  @override
  bool get stringify => true;
}
