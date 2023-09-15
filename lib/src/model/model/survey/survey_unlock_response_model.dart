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
  final String? machineWhatsappId;
  final String number;
  final bool locked;
  final int attempt;
  final DateTime? bannedUntil;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SurveyUnlockMachine machine;
  final List<SurveyUnlockRsp> responses;

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
    required this.machine,
    required this.responses,
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
      machine,
      responses,
    ];
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyUnlockMachine extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final String action;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SurveyUnlockMachine({
    required this.id,
    required this.userId,
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
    required this.action,
    required this.send,
    required this.replied,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyUnlockMachine.fromJson(Map<String, dynamic> json) =>
      _$SurveyUnlockMachineFromJson(json);

  /// Connect the generated [_$SurveyUnlockMachineToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyUnlockMachineToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      userId,
      name,
      number,
      serialNumber,
      license,
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

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyUnlockRsp extends Equatable {
  final String id;
  final String surveyId;
  final String platform;
  final String key;
  final String value;
  final String status;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SurveyUnlockRsp({
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

  factory SurveyUnlockRsp.fromJson(Map<String, dynamic> json) =>
      _$SurveyUnlockRspFromJson(json);

  /// Connect the generated [_$SurveyUnlockRspToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyUnlockRspToJson(this);

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
