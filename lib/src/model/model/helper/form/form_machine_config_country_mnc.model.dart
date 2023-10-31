import 'package:equatable/equatable.dart';

class FormMachineConfigCountryMnc extends Equatable {
  final String label;
  final String name;
  // ignore: non_constant_identifier_names
  final int is_active;
  final List<CountryMnc> mncs;
  const FormMachineConfigCountryMnc({
    required this.label,
    required this.name,
    // ignore: non_constant_identifier_names
    this.is_active = 1,
    this.mncs = const [],
  });

  @override
  List<Object> get props => [label, name, is_active, mncs];

  @override
  bool get stringify => true;

  FormMachineConfigCountryMnc copyWith({
    String? label,
    String? name,
    // ignore: non_constant_identifier_names
    int? is_active,
    List<CountryMnc>? mncs,
  }) {
    return FormMachineConfigCountryMnc(
      label: label ?? this.label,
      name: name ?? this.name,
      is_active: is_active ?? this.is_active,
      mncs: mncs ?? this.mncs,
    );
  }
}

class CountryMnc extends Equatable {
  final int status;
  final String label;
  final String mcc;
  final String mnc;
  final String name;

  const CountryMnc({
    required this.status,
    required this.label,
    required this.mcc,
    required this.mnc,
    required this.name,
  });

  @override
  List<Object> get props {
    return [
      status,
      label,
      mcc,
      mnc,
      name,
    ];
  }

  @override
  bool get stringify => true;

  CountryMnc copyWith({
    int? status,
    String? label,
    String? mcc,
    String? mnc,
    String? name,
  }) {
    return CountryMnc(
      status: status ?? this.status,
      label: label ?? this.label,
      mcc: mcc ?? this.mcc,
      mnc: mnc ?? this.mnc,
      name: name ?? this.name,
    );
  }
}
