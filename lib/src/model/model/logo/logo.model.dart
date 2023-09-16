import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';

class LogoModel extends Equatable {
  final int id;
  final Uint8List? logo;
  const LogoModel({
    required this.id,
    this.logo,
  });

  @override
  List<Object?> get props => [id, logo];

  @override
  bool get stringify => true;
}
