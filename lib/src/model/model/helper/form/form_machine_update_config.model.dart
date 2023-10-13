import 'package:equatable/equatable.dart';

class FormMachineUpdateConfigModel extends Equatable {
  final String machineId;
  final int count;
  final int taskCount;
  final String? sender1;
  final String? sender2;
  final String? sender3;
  final String? sender4;
  final String? sender5;
  final String? sms1;
  final String? sms2;
  final String? sms3;
  final String? sms4;
  final String? sms5;
  final bool isReboot;
  const FormMachineUpdateConfigModel({
    required this.machineId,
    required this.count,
    required this.taskCount,
    this.sender1,
    this.sender2,
    this.sender3,
    this.sender4,
    this.sender5,
    this.sms1,
    this.sms2,
    this.sms3,
    this.sms4,
    this.sms5,
    required this.isReboot,
  });

  @override
  List<Object?> get props {
    return [
      machineId,
      count,
      taskCount,
      sender1,
      sender2,
      sender3,
      sender4,
      sender5,
      sms1,
      sms2,
      sms3,
      sms4,
      sms5,
      isReboot,
    ];
  }

  @override
  bool get stringify => true;

  FormMachineUpdateConfigModel copyWith({
    String? machineId,
    int? count,
    int? taskCount,
    String? sender1,
    String? sender2,
    String? sender3,
    String? sender4,
    String? sender5,
    String? sms1,
    String? sms2,
    String? sms3,
    String? sms4,
    String? sms5,
    bool? isReboot,
  }) {
    return FormMachineUpdateConfigModel(
      machineId: machineId ?? this.machineId,
      count: count ?? this.count,
      taskCount: taskCount ?? this.taskCount,
      sender1: sender1 ?? this.sender1,
      sender2: sender2 ?? this.sender2,
      sender3: sender3 ?? this.sender3,
      sender4: sender4 ?? this.sender4,
      sender5: sender5 ?? this.sender5,
      sms1: sms1 ?? this.sms1,
      sms2: sms2 ?? this.sms2,
      sms3: sms3 ?? this.sms3,
      sms4: sms4 ?? this.sms4,
      sms5: sms5 ?? this.sms5,
      isReboot: isReboot ?? this.isReboot,
    );
  }
}
