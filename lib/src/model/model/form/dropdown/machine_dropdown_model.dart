import 'package:equatable/equatable.dart';

class MachineDropdownModel extends Equatable {
  final String id;
  final String name;
  const MachineDropdownModel({
    required this.id,
    required this.name,
  });

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;

  MachineDropdownModel copyWith({
    String? id,
    String? name,
  }) {
    return MachineDropdownModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
