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
  final String number;
  final String machineId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final SurveyMachine machine;

  const SurveyCreateResponseModel({
    required this.id,
    required this.locked,
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
    String? number,
    String? machineId,
    DateTime? updatedAt,
    DateTime? createdAt,
    SurveyMachine? machine,
  }) {
    return SurveyCreateResponseModel(
      id: id ?? this.id,
      locked: locked ?? this.locked,
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
  final String license;
  final MachineActionEnum action;
  final String smsSetting;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SurveyMachineResponse> responses;

  const SurveyMachine({
    required this.id,
    required this.userId,
    required this.name,
    required this.number,
    required this.license,
    required this.action,
    required this.smsSetting,
    required this.send,
    required this.replied,
    required this.createdAt,
    required this.updatedAt,
    required this.responses,
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
      license,
      action,
      smsSetting,
      send,
      replied,
      createdAt,
      updatedAt,
      responses,
    ];
  }

  @override
  bool get stringify => true;

  SurveyMachine copyWith({
    String? id,
    String? userId,
    String? name,
    String? number,
    String? license,
    MachineActionEnum? action,
    String? smsSetting,
    int? send,
    int? replied,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<SurveyMachineResponse>? responses,
  }) {
    return SurveyMachine(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      number: number ?? this.number,
      license: license ?? this.license,
      action: action ?? this.action,
      smsSetting: smsSetting ?? this.smsSetting,
      send: send ?? this.send,
      replied: replied ?? this.replied,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      responses: responses ?? this.responses,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyMachineResponse extends Equatable {
  final String id;
  final String machineId;
  final MachineActionEnum platform;
  final String key;
  final String value;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyMachineResponse({
    required this.id,
    required this.machineId,
    required this.platform,
    required this.key,
    required this.value,
    required this.type,
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
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;

  SurveyMachineResponse copyWith({
    String? id,
    String? machineId,
    MachineActionEnum? platform,
    String? key,
    String? value,
    String? type,
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
