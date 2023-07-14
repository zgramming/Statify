// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'application_config_model.g.dart';

@HiveType(typeId: 3)
class ApplicationConfigModel extends Equatable {
  @HiveField(0)
  final bool isIntroductionDone;

  @HiveField(1)
  final bool isDarkMode;

  const ApplicationConfigModel({
    this.isIntroductionDone = false,
    this.isDarkMode = false,
  });

  @override
  List<Object> get props => [isIntroductionDone, isDarkMode];

  @override
  bool get stringify => true;

  ApplicationConfigModel copyWith({
    bool? isIntroductionDone,
    bool? isDarkMode,
  }) {
    return ApplicationConfigModel(
      isIntroductionDone: isIntroductionDone ?? this.isIntroductionDone,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}
