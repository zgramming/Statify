import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'machine_config.model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class MachineConfigModel extends Equatable {
  final String? sms1;
  final String? sms2;
  final String? sms3;
  final String? sms4;
  final String? sms5;
  final String? count;
  final String? reboot;
  final String? sender1;
  final String? sender2;
  final String? sender3;
  final String? sender4;
  final String? sender5;
  final String? taskCount;

  const MachineConfigModel({
    this.sms1,
    this.sms2,
    this.sms3,
    this.sms4,
    this.sms5,
    this.count,
    this.reboot,
    this.sender1,
    this.sender2,
    this.sender3,
    this.sender4,
    this.sender5,
    this.taskCount,
  });

  factory MachineConfigModel.fromJson(Map<String, dynamic> json) =>
      _$MachineConfigModelFromJson(json);

  /// Connect the generated [_$MachineConfigModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MachineConfigModelToJson(this);

  @override
  List<Object?> get props {
    return [
      sms1,
      sms2,
      sms3,
      sms4,
      sms5,
      count,
      reboot,
      sender1,
      sender2,
      sender3,
      sender4,
      sender5,
      taskCount,
    ];
  }

  @override
  bool get stringify => true;
}
