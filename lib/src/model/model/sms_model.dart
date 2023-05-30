import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'sms_model.g.dart';

@HiveType(typeId: 1)
class SMSModel extends Equatable {
  const SMSModel({
    required this.id,
    required this.address,
    required this.body,
    required this.date,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String address;
  @HiveField(2)
  final String body;
  @HiveField(3)
  final DateTime date;

  @override
  List<Object> get props => [id, address, body, date];

  @override
  bool get stringify => true;

  SMSModel copyWith({
    String? id,
    String? address,
    String? body,
    DateTime? date,
  }) {
    return SMSModel(
      id: id ?? this.id,
      address: address ?? this.address,
      body: body ?? this.body,
      date: date ?? this.date,
    );
  }
}
