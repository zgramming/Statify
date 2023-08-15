import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_create_response_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyCreateResponseModel extends Equatable {
  final String id;
  final String number;
  final String machineId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final SurveyCreateResponseModelMachine machine;

  const SurveyCreateResponseModel({
    required this.id,
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
      number,
      machineId,
      updatedAt,
      createdAt,
      machine,
    ];
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyCreateResponseModelMachine extends Equatable {
  final String id;
  final String userId;
  final String number;
  final String license;
  final String action;
  final String smsSetting;
  final int send;
  final int replied;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<SurveyCreateResponseModelMachineSetting> settings;

  const SurveyCreateResponseModelMachine({
    required this.id,
    required this.userId,
    required this.number,
    required this.license,
    required this.action,
    required this.smsSetting,
    required this.send,
    required this.replied,
    required this.createdAt,
    required this.updatedAt,
    required this.settings,
  });

  factory SurveyCreateResponseModelMachine.fromJson(
          Map<String, dynamic> json) =>
      _$SurveyCreateResponseModelMachineFromJson(json);

  /// Connect the generated [_$SurveyCreateResponseModelMachineToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$SurveyCreateResponseModelMachineToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      userId,
      number,
      license,
      action,
      smsSetting,
      send,
      replied,
      createdAt,
      updatedAt,
      settings,
    ];
  }

  @override
  bool get stringify => true;
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveyCreateResponseModelMachineSetting extends Equatable {
  final String id;
  final String machineId;
  final String key;
  final String value;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SurveyCreateResponseModelMachineSetting({
    required this.id,
    required this.machineId,
    required this.key,
    required this.value,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveyCreateResponseModelMachineSetting.fromJson(
          Map<String, dynamic> json) =>
      _$SurveyCreateResponseModelMachineSettingFromJson(json);

  /// Connect the generated [_$SurveyCreateResponseModelMachineSettingToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() =>
      _$SurveyCreateResponseModelMachineSettingToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      machineId,
      key,
      value,
      type,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
