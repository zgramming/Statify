import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/model/helper/form/form_user_update.model.dart';
import '../model/model/machine_whatsapp/machine_whatsapp_model.dart';
import '../model/model/survey/survey.model.dart';
import '../model/model/user/user_model.dart';
import '../model/model/user/user_update.model.dart';
import '../model/repository/user.repository.dart';

class UserState extends Equatable {
  final UserModel? user;
  final AsyncValue<UserModel?> onGetById;
  final AsyncValue<(UserUpdateResponseModel, UserModel)?> onUpdate;
  final AsyncValue<List<SurveyModel>> onGetAllSurvey;
  final AsyncValue<List<MachineWhatsappModel>> onGetAllWhatsApps;
  const UserState({
    this.user,
    this.onGetById = const AsyncData(null),
    this.onUpdate = const AsyncData(null),
    this.onGetAllSurvey = const AsyncData([]),
    this.onGetAllWhatsApps = const AsyncData([]),
  });

  @override
  List<Object?> get props {
    return [
      user,
      onGetById,
      onUpdate,
      onGetAllSurvey,
      onGetAllWhatsApps,
    ];
  }

  @override
  bool get stringify => true;

  UserState copyWith({
    UserModel? user,
    AsyncValue<UserModel?>? onGetById,
    AsyncValue<(UserUpdateResponseModel, UserModel)?>? onUpdate,
    AsyncValue<List<SurveyModel>>? onGetAllSurvey,
    AsyncValue<List<MachineWhatsappModel>>? onGetAllWhatsApps,
  }) {
    return UserState(
      user: user ?? this.user,
      onGetById: onGetById ?? this.onGetById,
      onUpdate: onUpdate ?? this.onUpdate,
      onGetAllSurvey: onGetAllSurvey ?? this.onGetAllSurvey,
      onGetAllWhatsApps: onGetAllWhatsApps ?? this.onGetAllWhatsApps,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository repository;
  UserNotifier({
    required this.repository,
  }) : super(const UserState());

  Future<UserState> getById(String id) async {
    state = state.copyWith(
      onGetById: const AsyncLoading(),
    );
    final result = await repository.getById(id);
    return result.fold(
      (failure) => state = state.copyWith(
        onGetById: AsyncError(
          failure.message,
          StackTrace.current,
        ),
        user: null,
      ),
      (user) => state = state.copyWith(
        user: user,
        onGetById: AsyncData(user),
      ),
    );
  }

  Future<UserState> getAllSurvey(String userId) async {
    final result = await repository.getAllSurvey(userId);

    return result.fold(
      (failure) => state = state.copyWith(
        onGetAllSurvey: AsyncError(
          failure.message,
          StackTrace.current,
        ),
      ),
      (surveys) => state = state.copyWith(
        onGetAllSurvey: AsyncData(surveys),
      ),
    );
  }

  Future<UserState> getAllWhatsApps(String userId) async {
    final result = await repository.getAllWhatsApps(userId);
    return result.fold(
      (failure) => state = state.copyWith(
        onGetAllWhatsApps: AsyncError(
          failure.message,
          StackTrace.current,
        ),
      ),
      (whatsApps) => state = state.copyWith(
        onGetAllWhatsApps: AsyncData(whatsApps),
      ),
    );
  }

  Future<UserState> update({
    required String id,
    required FormUserUpdateModel form,
  }) async {
    state = state.copyWith(
      onUpdate: const AsyncLoading(),
    );
    final result = await repository.update(
      userId: id,
      form: form,
    );
    return result.fold(
      (failure) => state = state.copyWith(
        onUpdate: AsyncError(
          failure.message,
          StackTrace.current,
        ),
      ),
      (user) => state = state.copyWith(
        onUpdate: AsyncData(user),
        user: state.user?.copyWith(
          username: form.username,
          name: form.name,
          sim1: form.sim1,
          sim2: form.sim2,
        ),
      ),
    );
  }

  void setUser(UserModel user) {
    final currentToken = state.user?.token;
    state = state.copyWith(
      user: user.copyWith(
        token: currentToken,
      ),
    );
  }
}
