import 'package:equatable/equatable.dart';

class FormMachineCreateUpdateModel extends Equatable {
  const FormMachineCreateUpdateModel({
    required this.name,
    required this.number,
    required this.serialNumber,
    required this.license,
  });

  final String name;
  final String number;
  final String serialNumber;
  final String license;

  @override
  List<Object> get props => [name, number, serialNumber, license];

  @override
  bool get stringify => true;
}
