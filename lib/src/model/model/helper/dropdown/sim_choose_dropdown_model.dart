import 'package:equatable/equatable.dart';

class SimChooseDropdownModel extends Equatable {
  final String label;
  final String value;
  const SimChooseDropdownModel({
    required this.label,
    required this.value,
  });

  @override
  List<Object> get props => [label, value];

  @override
  bool get stringify => true;

  SimChooseDropdownModel copyWith({
    String? label,
    String? value,
  }) {
    return SimChooseDropdownModel(
      label: label ?? this.label,
      value: value ?? this.value,
    );
  }
}
