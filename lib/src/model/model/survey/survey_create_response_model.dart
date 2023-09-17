// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';

part 'survey_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyCreateResponseModel extends Equatable {
  final String id;
  final bool locked;
  final int attempt;
  final bool finish;
  final String number;
  final String machineId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final SurveyMachine machine;

  const SurveyCreateResponseModel({
    required this.id,
    required this.locked,
    required this.attempt,
    required this.finish,
    required this.number,
    required this.machineId,
    required this.updatedAt,
    required this.createdAt,
    required this.machine,
  });

  factory SurveyCreateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyCreateResponseModelFromJson(json);

  /// Connect the generated [_$SurveyCreateResponseModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyCreateResponseModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      locked,
      attempt,
      finish,
      number,
      machineId,
      updatedAt,
      createdAt,
      machine,
    ];
  }

  @override
  bool get stringify => true;

  SurveyCreateResponseModel copyWith({
    String? id,
    bool? locked,
    int? attempt,
    bool? finish,
    String? number,
    String? machineId,
    DateTime? updatedAt,
    DateTime? createdAt,
    SurveyMachine? machine,
  }) {
    return SurveyCreateResponseModel(
      id: id ?? this.id,
      locked: locked ?? this.locked,
      attempt: attempt ?? this.attempt,
      finish: finish ?? this.finish,
      number: number ?? this.number,
      machineId: machineId ?? this.machineId,
      updatedAt: updatedAt ?? this.updatedAt,
      createdAt: createdAt ?? this.createdAt,
      machine: machine ?? this.machine,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyMachine extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final MachineActionEnum action;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyMachine({
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

  factory SurveyMachine.fromJson(Map<String, dynamic> json) =>
      _$SurveyMachineFromJson(json);

  /// Connect the generated [_$SurveyMachineToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyMachineToJson(this);

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
class SurveyMachineResponse extends Equatable {
  final String id;
  final String machineId;
  final MachineResponsePlatformEnum platform;
  final String key;
  final String value;
  final String type;
  final bool finish;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyMachineResponse({
    required this.id,
    required this.machineId,
    required this.platform,
    required this.key,
    required this.value,
    required this.type,
    required this.finish,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyMachineResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyMachineResponseFromJson(json);

  /// Connect the generated [_$SurveyMachineResponseToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyMachineResponseToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      platform,
      key,
      value,
      type,
      finish,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  SurveyMachineResponse copyWith({
    String? id,
    String? machineId,
    MachineResponsePlatformEnum? platform,
    String? key,
    String? value,
    String? type,
    bool? finish,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SurveyMachineResponse(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      platform: platform ?? this.platform,
      key: key ?? this.key,
      value: value ?? this.value,
      type: type ?? this.type,
      finish: finish ?? this.finish,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
