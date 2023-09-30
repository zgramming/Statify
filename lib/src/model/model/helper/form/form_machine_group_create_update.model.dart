import 'package:equatable/equatable.dart';

class FormMachineGroupCreateOrUpdateModel extends Equatable {
  final String? machineGroupId;
  final String userId;
  final String name;
  final List<String> machineIds;
  const FormMachineGroupCreateOrUpdateModel({
    this.machineGroupId,
    required this.userId,
    required this.name,
    required this.machineIds,
  });

  @override
  List<Object?> get props => [machineGroupId, userId, name, machineIds];

  @override
  bool get stringify => true;

  FormMachineGroupCreateOrUpdateModel copyWith({
    String? machineGroupId,
    String? userId,
    String? name,
    List<String>? machineIds,
  }) {
    return FormMachineGroupCreateOrUpdateModel(
      machineGroupId: machineGroupId ?? this.machineGroupId,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      machineIds: machineIds ?? this.machineIds,
    );
  }
}
