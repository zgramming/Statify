import 'package:equatable/equatable.dart';

class PropsGetMachineByIPModel extends Equatable {
  final String ip;
  final String machineId;

  const PropsGetMachineByIPModel({
    required this.ip,
    required this.machineId,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [ip, machineId];
}
