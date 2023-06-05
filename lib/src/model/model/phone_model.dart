import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'phone_model.g.dart';

@HiveType(typeId: 2)
class PhoneModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String number;
  @HiveField(2)
  final DateTime date;
  const PhoneModel({
    required this.id,
    required this.number,
    required this.date,
  });

  @override
  List<Object> get props => [id, number, date];

  @override
  bool get stringify => true;

  PhoneModel copyWith({
    String? id,
    String? number,
    DateTime? date,
  }) {
    return PhoneModel(
      id: id ?? this.id,
      number: number ?? this.number,
      date: date ?? this.date,
    );
  }
}
