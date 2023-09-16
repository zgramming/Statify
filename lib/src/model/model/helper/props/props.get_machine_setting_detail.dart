import 'package:equatable/equatable.dart';

class PropsGetMachineSettingDetail extends Equatable {
  final String machineId;
  final String settingId;
  const PropsGetMachineSettingDetail({
    required this.machineId,
    required this.settingId,
  });

  @override
  List<Object> get props => [machineId, settingId];

  @override
  bool get stringify => true;
}
