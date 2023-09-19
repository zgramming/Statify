// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';
import '../../../utils/functions.dart';

part 'survey_setting_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class SurveySettingModel extends Equatable {
  final String id;
  final String surveyId;
  final MachineResponsePlatformEnum platform;
  final bool usePassword;
  final int timeout;
  final int tries;
  final int backoff;
  final DateTime createdAt;
  final DateTime updatedAt;

  String? get settingByPlatformReadable {
    final result = getMachineSettingPlatformReadable(
      usePassword: usePassword,
      timeout: timeout,
      tries: tries,
      backoff: backoff,
    );
    return result;
  }

  const SurveySettingModel({
    required this.id,
    required this.surveyId,
    required this.platform,
    required this.usePassword,
    required this.timeout,
    required this.tries,
    required this.backoff,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SurveySettingModel.fromJson(Map<String, dynamic> json) =>
      _$SurveySettingModelFromJson(json);

  /// Connect the generated [_$SurveySettingModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SurveySettingModelToJson(this);

  @override
  List<Object> get props {
    return [
      id,
      surveyId,
      platform,
      usePassword,
      timeout,
      tries,
      backoff,
      createdAt,
      updatedAt,
    ];
  }

  @override
  bool get stringify => true;
}
