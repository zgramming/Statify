import 'package:equatable/equatable.dart';

class ScanQRCodeSerialNumberRouteExtraModel extends Equatable {
  final bool isNewMachine;
  const ScanQRCodeSerialNumberRouteExtraModel({
    this.isNewMachine = false,
  });

  @override
  List<Object?> get props => [isNewMachine];

  @override
  bool get stringify => true;
}
