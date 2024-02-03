import 'package:equatable/equatable.dart';

class PropsIsMachineConfigOperatorsSelectedModel extends Equatable {
  final String mcc;
  final String mnc;

  const PropsIsMachineConfigOperatorsSelectedModel({
    required this.mcc,
    required this.mnc,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        mcc,
        mnc,
      ];
}
