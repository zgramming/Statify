// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';

part 'survey.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyModel extends Equatable {
  final String id;
  final int totalReplied;
  final int totalFinished;
  final int totalVoted;
  final int totalSent;
  final String name;
  final String slug;
  final MachineActionEnum action;
  final String machineId;
  final DateTime updatedAt;
  final DateTime createdAt;

  const SurveyModel({
    required this.id,
    required this.totalReplied,
    required this.totalFinished,
    required this.totalVoted,
    required this.totalSent,
    required this.name,
    required this.slug,
    required this.action,
    required this.machineId,
    required this.updatedAt,
    required this.createdAt,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyModelFromJson(json);

  /// Connect the generated [_$SurveyModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      totalReplied,
      totalFinished,
      totalVoted,
      totalSent,
      name,
      slug,
      action,
      machineId,
      updatedAt,
      createdAt,
    ];
  }

  @override
  bool get stringify => true;
}
