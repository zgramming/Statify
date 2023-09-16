import 'package:equatable/equatable.dart';

class FormUserUpdateModel extends Equatable {
  final String username;
  final String name;
  final String countryCode;
  final String sim1;
  final String sim2;

  const FormUserUpdateModel({
    required this.username,
    required this.name,
    required this.countryCode,
    required this.sim1,
    required this.sim2,
  });

  @override
  List<Object> get props {
    return [
      username,
      name,
      countryCode,
      sim1,
      sim2,
    ];
  }

  @override
  bool get stringify => true;

  FormUserUpdateModel copyWith({
    String? username,
    String? name,
    String? countryCode,
    String? sim1,
    String? sim2,
  }) {
    return FormUserUpdateModel(
      username: username ?? this.username,
      name: name ?? this.name,
      countryCode: countryCode ?? this.countryCode,
      sim1: sim1 ?? this.sim1,
      sim2: sim2 ?? this.sim2,
    );
  }
}
