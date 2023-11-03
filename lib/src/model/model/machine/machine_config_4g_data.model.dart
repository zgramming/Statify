import 'package:equatable/equatable.dart';

class MachineConfig4GDataModel extends Equatable {
  final String ip;
  final String interval;
  final String mcc;
  final String mnc;
  final String arfcn;
  final String pci;
  final String lac;
  final String cellId;

  const MachineConfig4GDataModel({
    required this.ip,
    required this.interval,
    required this.mcc,
    required this.mnc,
    required this.arfcn,
    required this.pci,
    required this.lac,
    required this.cellId,
  });

  @override
  List<Object> get props {
    return [
      ip,
      interval,
      mcc,
      mnc,
      arfcn,
      pci,
      lac,
      cellId,
    ];
  }

  @override
  bool get stringify => true;

  MachineConfig4GDataModel copyWith({
    String? ip,
    String? interval,
    String? mcc,
    String? mnc,
    String? arfcn,
    String? pci,
    String? lac,
    String? cellId,
  }) {
    return MachineConfig4GDataModel(
      ip: ip ?? this.ip,
      interval: interval ?? this.interval,
      mcc: mcc ?? this.mcc,
      mnc: mnc ?? this.mnc,
      arfcn: arfcn ?? this.arfcn,
      pci: pci ?? this.pci,
      lac: lac ?? this.lac,
      cellId: cellId ?? this.cellId,
    );
  }
}
