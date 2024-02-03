import 'package:equatable/equatable.dart';

class PropsIsMachineConfigOperatorsSelectedModel extends Equatable {
  final String mcc;
  final String mnc;
  final String country;
  final String label;

  const PropsIsMachineConfigOperatorsSelectedModel({
    required this.mcc,
    required this.mnc,
    required this.country,
    required this.label,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [mcc, mnc, country, label];
}
