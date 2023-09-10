import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_unlock_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyUnlockResponseModel extends Equatable {
  final String id;
  final String machineId;
  final String number;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool locked;
  const SurveyUnlockResponseModel({
    required this.id,
    required this.machineId,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
    required this.locked,
  });

  factory SurveyUnlockResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyUnlockResponseModelFromJson(json);

  /// Connect the generated [_$SurveyUnlockResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyUnlockResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      number,
      createdAt,
      updatedAt,
      locked,
    ];
  }

  @override
  bool get stringify => true;

  SurveyUnlockResponseModel copyWith({
    String? id,
    String? machineId,
    String? number,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? locked,
  }) {
    return SurveyUnlockResponseModel(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      number: number ?? this.number,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      locked: locked ?? this.locked,
    );
  }
}
