import 'package:equatable/equatable.dart';

class ApplicationConfigModel extends Equatable {
  final String id;
  final String key;
  final String value;
  const ApplicationConfigModel({
    required this.id,
    required this.key,
    required this.value,
  });

  @override
  List<Object> get props => [id, key, value];

  @override
  bool get stringify => true;

  ApplicationConfigModel copyWith({
    String? id,
    String? key,
    String? value,
  }) {
    return ApplicationConfigModel(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
    );
  }
}
