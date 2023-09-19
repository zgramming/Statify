import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';

part 'survey.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyModel extends Equatable {
  final String id;
  final String machineId;
  final String name;
  final String slug;
  final MachineActionEnum action;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SurveyModel({
    required this.id,
    required this.machineId,
    required this.name,
    required this.slug,
    required this.action,
    required this.send,
    required this.replied,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyModelFromJson(json);

  /// Connect the generated [_$SurveyModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      name,
      slug,
      action,
      send,
      replied,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
