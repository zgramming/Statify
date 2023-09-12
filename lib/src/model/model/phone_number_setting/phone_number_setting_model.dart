import 'package:equatable/equatable.dart';

class PhoneNumberSettingModel extends Equatable {
  final int id;
  final String sim1;
  final String sim2;

  const PhoneNumberSettingModel({
    required this.id,
    required this.sim1,
    required this.sim2,
  });

  @override
  List<Object?> get props => [
        id,
        sim1,
        sim2,
      ];

  @override
  bool get stringify => true;

  PhoneNumberSettingModel copyWith({
    int? id,
    String? sim1,
    String? sim2,
  }) {
    return PhoneNumberSettingModel(
      id: id ?? this.id,
      sim1: sim1 ?? this.sim1,
      sim2: sim2 ?? this.sim2,
    );
  }
}
