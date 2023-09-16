import 'package:equatable/equatable.dart';

import 'logo/logo.model.dart';
import 'user/user_model.dart';

class InitializeApplicationModel extends Equatable {
  final UserModel? user;
  final bool isAlreadyIntroduction;
  final LogoModel? logo;

  const InitializeApplicationModel({
    this.user,
    required this.isAlreadyIntroduction,
    this.logo,
  });

  @override
  List<Object?> get props => [user, isAlreadyIntroduction, logo];

  @override
  bool get stringify => true;
}
