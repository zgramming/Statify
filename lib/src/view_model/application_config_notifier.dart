import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/application_config_model.dart';
import '../model/repository/application_config_repository.dart';

class ApplicationConfigState extends Equatable {
  final ApplicationConfigModel item;

  final AsyncValue<String?> onIntroductionSaved;
  final AsyncValue<String?> onDarkModeSaved;

  const ApplicationConfigState({
    this.item = const ApplicationConfigModel(),
    this.onIntroductionSaved = const AsyncData(null),
    this.onDarkModeSaved = const AsyncData(null),
  });

  @override
  List<Object> get props => [item, onIntroductionSaved, onDarkModeSaved];

  @override
  bool get stringify => true;

  ApplicationConfigState copyWith({
    ApplicationConfigModel? item,
    AsyncValue<String?>? onIntroductionSaved,
    AsyncValue<String?>? onDarkModeSaved,
  }) {
    return ApplicationConfigState(
      item: item ?? this.item,
      onIntroductionSaved: onIntroductionSaved ?? this.onIntroductionSaved,
      onDarkModeSaved: onDarkModeSaved ?? this.onDarkModeSaved,
    );
  }
}

class ApplicationConfigNotifier extends StateNotifier<ApplicationConfigState> {
  final ApplicationConfigRepository repository;
  ApplicationConfigNotifier({
    required this.repository,
  }) : super(const ApplicationConfigState()) {
    getApplicationConfig();
  }

  Future<void> getApplicationConfig() async {
    final result = await repository.getApplicationConfig();
    state = state.copyWith(item: result);
  }

  Future<void> saveIntroduction(bool value) async {
    state = state.copyWith(onIntroductionSaved: const AsyncLoading());
    final result = await repository.saveIntroduction(value);
    state = state.copyWith(onIntroductionSaved: AsyncData(result));
  }

  Future<void> saveDarkMode(bool isDarkMode) async {
    state = state.copyWith(onDarkModeSaved: const AsyncLoading());
    final result = await repository.saveDarkMode(isDarkMode);
    state = state.copyWith(onDarkModeSaved: AsyncData(result));
  }
}
