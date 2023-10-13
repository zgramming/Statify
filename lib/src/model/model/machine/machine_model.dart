import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../utils/enum.dart';
import 'machine_config.model.dart';
import 'machine_summary.model.dart';

part 'machine_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineModel extends Equatable {
  final String id;
  final String userId;
  final String name;
  final String number;
  final String serialNumber;
  final String license;
  final int totalSmsSent;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? activeSurveyId;
  final bool group;
  final MachineStatusEnum status;
  final MachineConfigModel? config;
  final DateTime? lastOnline;
  final bool isUpdating;
  final MachineSummaryModel? summary;

  const MachineModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
    required this.totalSmsSent,
    required this.createdAt,
    required this.updatedAt,
    this.activeSurveyId,
    required this.group,
    required this.status,
    this.config,
    this.lastOnline,
    required this.isUpdating,
    this.summary,
  });

  factory MachineModel.fromJson(Map<String, dynamic> json) =>
      _$MachineModelFromJson(json);

  /// Connect the generated [_$MachineModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineModelToJson(this);

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      name,
      number,
      serialNumber,
      license,
      totalSmsSent,
      createdAt,
      updatedAt,
      activeSurveyId,
      group,
      status,
      config,
      lastOnline,
      isUpdating,
      summary,
    ];
  }

  @override
  bool get stringify => true;

  MachineModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? number,
    String? serialNumber,
    String? license,
    int? totalSmsSent,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? activeSurveyId,
    bool? group,
    MachineStatusEnum? status,
    MachineConfigModel? config,
    DateTime? lastOnline,
    bool? isUpdating,
    MachineSummaryModel? summary,
  }) {
    return MachineModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      number: number ?? this.number,
      serialNumber: serialNumber ?? this.serialNumber,
      license: license ?? this.license,
      totalSmsSent: totalSmsSent ?? this.totalSmsSent,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      activeSurveyId: activeSurveyId ?? this.activeSurveyId,
      group: group ?? this.group,
      status: status ?? this.status,
      config: config ?? this.config,
      lastOnline: lastOnline ?? this.lastOnline,
      isUpdating: isUpdating ?? this.isUpdating,
      summary: summary ?? this.summary,
    );
  }
}
