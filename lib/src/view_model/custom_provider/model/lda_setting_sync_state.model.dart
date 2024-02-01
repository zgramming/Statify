import 'package:equatable/equatable.dart';

class LDASettingSyncStateModel extends Equatable {
  final String boardIp;
  final String twoGData;
  final List<String> fourGDatas;
  const LDASettingSyncStateModel({
    required this.boardIp,
    required this.twoGData,
    required this.fourGDatas,
  });

  @override
  List<Object> get props => [boardIp, twoGData, fourGDatas];

  @override
  bool get stringify => true;

  LDASettingSyncStateModel copyWith({
    String? boardIp,
    String? twoGData,
    List<String>? fourGDatas,
  }) {
    return LDASettingSyncStateModel(
      boardIp: boardIp ?? this.boardIp,
      twoGData: twoGData ?? this.twoGData,
      fourGDatas: fourGDatas ?? this.fourGDatas,
    );
  }
}
