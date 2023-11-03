import 'package:equatable/equatable.dart';

class MachineConfig2GDataModel extends Equatable {
  final String ip;
  final String mcc;
  final String mnc;
  final String arfcn;
  const MachineConfig2GDataModel({
    required this.ip,
    required this.mcc,
    required this.mnc,
    required this.arfcn,
  });

  @override
  List<Object> get props => [ip, mcc, mnc, arfcn];

  @override
  bool get stringify => true;

  MachineConfig2GDataModel copyWith({
    String? ip,
    String? mcc,
    String? mnc,
    String? arfcn,
  }) {
    return MachineConfig2GDataModel(
      ip: ip ?? this.ip,
      mcc: mcc ?? this.mcc,
      mnc: mnc ?? this.mnc,
      arfcn: arfcn ?? this.arfcn,
    );
  }
}
