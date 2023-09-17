// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_unlock_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyUnlockResponseModel extends Equatable {
  final String id;
  final String machineId;
  final dynamic machineWhatsappId;
  final String number;
  final bool locked;
  final int attempt;
  final DateTime? bannedUntil;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyUnlockResponseModel({
    required this.id,
    required this.machineId,
    this.machineWhatsappId,
    required this.number,
    required this.locked,
    required this.attempt,
    this.bannedUntil,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyUnlockResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyUnlockResponseModelFromJson(json);

  /// Connect the generated [_$SurveyUnlockResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyUnlockResponseModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      machineId,
      machineWhatsappId,
      number,
      locked,
      attempt,
      bannedUntil,
      finish,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
