import 'package:equatable/equatable.dart';

class FormMachineSettingCreateUpdateModel extends Equatable {
  final String machineId;
  final bool usePassword;
  final int timeout;
  final int tries;
  final int backoff;

  const FormMachineSettingCreateUpdateModel({
    required this.machineId,
    required this.usePassword,
    required this.timeout,
    required this.tries,
    required this.backoff,
  });

  @override
  List<Object> get props {
    return [
      machineId,
      usePassword,
      timeout,
      tries,
      backoff,
    ];
  }

  @override
  bool get stringify => true;

  FormMachineSettingCreateUpdateModel copyWith({
    String? machineId,
    bool? usePassword,
    int? timeout,
    int? tries,
    int? backoff,
  }) {
    return FormMachineSettingCreateUpdateModel(
      machineId: machineId ?? this.machineId,
      usePassword: usePassword ?? this.usePassword,
      timeout: timeout ?? this.timeout,
      tries: tries ?? this.tries,
      backoff: backoff ?? this.backoff,
    );
  }
}
