import 'package:equatable/equatable.dart';

class MachineFormRouteExtraModel extends Equatable {
  final String? scannedQRCodeValueNewMachine;
  const MachineFormRouteExtraModel({
    this.scannedQRCodeValueNewMachine,
  });

  @override
  List<Object?> get props => [scannedQRCodeValueNewMachine];

  @override
  bool get stringify => true;

  MachineFormRouteExtraModel copyWith({
    String? scannedQRCodeValueNewMachine,
  }) {
    return MachineFormRouteExtraModel(
      scannedQRCodeValueNewMachine:
          scannedQRCodeValueNewMachine ?? this.scannedQRCodeValueNewMachine,
    );
  }
}
