import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_response_fail_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseFailModel extends Equatable {
  final String id;
  final String surveyId;
  final String key;
  final String value;
  final String status;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SurveyResponseFailSurvey survey;
  const SurveyResponseFailModel({
    required this.id,
    required this.surveyId,
    required this.key,
    required this.value,
    required this.status,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.survey,
  });

  factory SurveyResponseFailModel.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFailModelFromJson(json);

  /// Connect the generated [_$SurveyResponseFailModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyResponseFailModelToJson(this);

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
      survey,
    ];
  }

  @override
  bool get stringify => true;

  SurveyResponseFailModel copyWith({
    String? id,
    String? surveyId,
    String? key,
    String? value,
    String? status,
    String? type,
    DateTime? createdAt,
    DateTime? updatedAt,
    SurveyResponseFailSurvey? survey,
  }) {
    return SurveyResponseFailModel(
      id: id ?? this.id,
      surveyId: surveyId ?? this.surveyId,
      key: key ?? this.key,
      value: value ?? this.value,
      status: status ?? this.status,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      survey: survey ?? this.survey,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseFailSurvey extends Equatable {
  final String id;
  final String machineId;
  final String number;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int locked;
  final SurveyResponseFailMachine machine;
  const SurveyResponseFailSurvey({
    required this.id,
    required this.machineId,
    required this.number,
    required this.createdAt,
    required this.updatedAt,
    required this.locked,
    required this.machine,
  });

  factory SurveyResponseFailSurvey.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFailSurveyFromJson(json);

  /// Connect the generated [_$SurveyResponseFailSurveyToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyResponseFailSurveyToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      number,
      createdAt,
      updatedAt,
      locked,
      machine,
    ];
  }

  @override
  bool get stringify => true;

  SurveyResponseFailSurvey copyWith({
    String? id,
    String? machineId,
    String? number,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? locked,
    SurveyResponseFailMachine? machine,
  }) {
    return SurveyResponseFailSurvey(
      id: id ?? this.id,
      machineId: machineId ?? this.machineId,
      number: number ?? this.number,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      locked: locked ?? this.locked,
      machine: machine ?? this.machine,
    );
  }
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyResponseFailMachine extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String license;
  final String action;
  final String smsSetting;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SurveyResponseFailMachine({
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
  });

  factory SurveyResponseFailMachine.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFailMachineFromJson(json);

  /// Connect the generated [_$SurveyResponseFailMachineToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveyResponseFailMachineToJson(this);

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
    ];
  }

  @override
  bool get stringify => true;

  SurveyResponseFailMachine copyWith({
    String? id,
    String? userId,
    String? name,
    String? number,
    String? license,
    String? action,
    String? smsSetting,
    int? send,
    int? replied,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SurveyResponseFailMachine(
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
    );
  }
}
