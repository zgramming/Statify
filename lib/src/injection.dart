import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'model/database/database.dart';
import 'model/datasource/local/application_config_local_datasource.dart';
import 'model/datasource/local/logo_local.datasource.dart';
import 'model/datasource/local/temporary_pending_response_local_datasource.dart';
import 'model/datasource/remote/authentication_remote_datasource.dart';
import 'model/datasource/remote/incoming_message_remote_datasource.dart';
import 'model/datasource/remote/machine_remote_datasource.dart';
import 'model/datasource/remote/machine_response_remote_datasource.dart';
import 'model/datasource/remote/machine_setting_remote_datasource.dart';
import 'model/datasource/remote/machine_whatsapp_remote_datasource.dart';
import 'model/datasource/remote/survey_remote_datasource.dart';
import 'model/datasource/remote/survey_response_remote_datasource.dart';
import 'model/datasource/remote/user_remote_datasource.dart';
import 'model/model/helper/dropdown/sim_choose_dropdown_model.dart';
import 'model/model/machine_whatsapp/machine_whatsapp_model.dart';
import 'model/repository/application_config.repository.dart';
import 'model/repository/authentication_repository.dart';
import 'model/repository/machine_repository.dart';
import 'model/repository/machine_response_repository.dart';
import 'model/repository/machine_setting_repository.dart';
import 'model/repository/machine_whatsapp_repository.dart';
import 'model/repository/survey_repository.dart';
import 'model/repository/survey_response_repository.dart';
import 'utils/http_client.dart';
import 'view_model/application_config.notifier.dart';
import 'view_model/authentication_notifier.dart';
import 'view_model/custom_notifier/log_incoming_call.notifier.dart';
import 'view_model/custom_notifier/log_incoming_message.notifier.dart';
import 'view_model/custom_notifier/log_listen_pending_response.notifier.dart';
import 'view_model/machine_notifier.dart';
import 'view_model/machine_response_notifier.dart';
import 'view_model/machine_setting_notifier.dart';
import 'view_model/machine_whatsapp_notifier.dart';
import 'view_model/survey_notifier.dart';
import 'view_model/survey_response_notifier.dart';

// Custom Provider
final userChooseSIMMachineProvider =
    ProviderFamily<int, String>((ref, machineId) {
  final machines = ref.watch(machineNotifier).onGetAll.valueOrNull ?? [];

  final machine = machines.firstWhere(
    (element) => element.id == machineId,
    orElse: () => machines.first,
  );

  final user = ref.watch(userNotifier).user;
  if (user == null) throw Exception('User is null');

  int simSlot = -1;
  if (machine.number == user.sim1) {
    simSlot = 0;
  } else if (machine.number == user.sim2) {
    simSlot = 1;
  } else {
    throw Exception('Machine number is not found in user sim');
  }

  return simSlot;
});
final isUserAlreadySetupSIMProvider = Provider((ref) {
  final user = ref.watch(userNotifier.select((value) => value.user));
  final isExistsSIM1 = user?.sim1 != null && (user?.sim1?.isNotEmpty ?? false);
  final isExistsSIM2 = user?.sim2 != null && (user?.sim2?.isNotEmpty ?? false);
  return isExistsSIM1 || isExistsSIM2;
});
final isEmptyAvailableSIM = Provider((ref) {
  final items = ref.watch(getAvailableSIM);
  return items.isEmpty;
});
final getAvailableSIM = Provider((ref) {
  final user = ref.watch(userNotifier.select((value) => value.user));
  final isExistsSIM1 = user?.sim1 != null && (user?.sim1?.isNotEmpty ?? false);
  final isExistsSIM2 = user?.sim2 != null && (user?.sim2?.isNotEmpty ?? false);
  final List<SimChooseDropdownModel> items = [
    if (isExistsSIM1)
      SimChooseDropdownModel(label: "SIM 1", value: "${user?.sim1}"),
    if (isExistsSIM2)
      SimChooseDropdownModel(label: "SIM 2", value: "${user?.sim2}"),
  ];
  return items;
});
final getOnlyWhatsAppMachine = Provider((ref) {
  final machines = ref.watch(machineNotifier).onGetAll.valueOrNull ?? [];
  final result = machines.map((e) => e.whatsapps).toList();
  final flatten = result.expand((element) => element).toList();
  return flatten;
});
final getMachineWhatsApp =
    Provider.family<List<MachineWhatsappModel>, String>((ref, machineId) {
  final machines = ref.watch(machineNotifier).onGetAll.valueOrNull;

  if (machines == null) return [];

  final result =
      machines.firstWhereOrNull((element) => element.id == machineId);
  final whatsapps = result?.whatsapps ?? [];
  return whatsapps;
});
// End Custom Provider

final logIncomingCallNotifier =
    StateNotifierProvider<LogIncomingCallNotifier, LogIncomingCallState>(
  (ref) => LogIncomingCallNotifier(),
);
final logListenPendingResponseNotifier = StateNotifierProvider<
    LogListenPendingResponseNotifier, LogListenPendingResponseState>(
  (ref) => LogListenPendingResponseNotifier(),
);
final logIncomingMessageNotifier =
    StateNotifierProvider<LogIncomingMessageNotifier, LogIncomingMessageState>(
  (ref) => LogIncomingMessageNotifier(),
);
final incomingMessageNotifier =
    StateNotifierProvider<IncomingMessageNotifier, IncomingMessageState>((ref) {
  return IncomingMessageNotifier(
    repository: ref.watch(_incomingMessageRepository),
  );
});
final surveyNotifier = StateNotifierProvider<SurveyNotifier, SurveyState>(
  (ref) => SurveyNotifier(repository: ref.watch(_surveyRepository)),
);
final surveyResponseNotifier =
    StateNotifierProvider<SurveyResponseNotifier, SurveyResponseState>(
  (ref) => SurveyResponseNotifier(
    repository: ref.watch(_surveyResponseRepository),
  ),
);
final machineSettingNotifier = StateNotifierProviderFamily<
    MachineSettingNotifier, MachineSettingState, String>((ref, machineId) {
  return MachineSettingNotifier(
    repository: ref.watch(_machineSettingRepository),
    machineId: machineId,
  );
});
final machineResponseNotifier = StateNotifierProviderFamily<
    MachineResponseNotifier, MachineResponseState, String>(
  (ref, machineId) => MachineResponseNotifier(
    repository: ref.watch(_machineResponseRepository),
    machineId: machineId,
  ),
);
final machineWhatsappNotifier =
    StateNotifierProvider<MachineWhatsappNotifier, MachineWhatsappState>(
  (ref) => MachineWhatsappNotifier(
    repository: ref.watch(_machineWhatsappRepository),
  ),
);
final machineNotifier = StateNotifierProvider<MachineNotifier, MachineState>(
  (ref) {
    final userId = ref.watch(userNotifier).user?.id;
    if (userId == null) throw UnimplementedError('User Id is null');
    return MachineNotifier(
      repository: ref.watch(_machineRepository),
      userId: userId,
    );
  },
);
final authenticationNotifier =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
  (ref) => AuthenticationNotifier(
    repository: ref.watch(_authenticationRepository),
  ),
);
final userNotifier = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier(
    repository: ref.watch(_userRepository),
  );
});

final temporaryPendingResponseNotifier = StateNotifierProvider<
    TemporaryPendingResponseNotifier, TemporaryPendingResponseState>(
  (ref) => TemporaryPendingResponseNotifier(
    repository: ref.watch(_temporaryPendingResponseRepository),
  ),
);
final applicationConfigNotifier =
    StateNotifierProvider<ApplicationConfigNotifier, ApplicationConfigState>(
  (ref) => ApplicationConfigNotifier(
    repository: ref.watch(_applicationConfigRepository),
  ),
);
final logoNotifier = StateNotifierProvider<LogoNotifier, LogoState>((ref) {
  return LogoNotifier(
    repository: ref.watch(_logoRepository),
  );
});

// repository

final _incomingMessageRepository = Provider((ref) => IncomingMessageRepository(
    remoteDatasource: ref.watch(_incomingMessageRemoteDatasource)));
final _surveyRepository = Provider((ref) =>
    SurveyRepository(remoteDatasource: ref.watch(_surveyRemoteDatasource)));
final _surveyResponseRepository = Provider((ref) => SurveyResponseRepository(
    remoteDatasource: ref.watch(_surveyResponseRemoteDatasource)));
final _machineSettingRepository = Provider((ref) => MachineSettingRepository(
    remoteDatasource: ref.watch(_machineSettingRemoteDatasource)));
final _machineResponseRepository = Provider((ref) => MachineResponseRepository(
    remoteDatasource: ref.watch(_machineResponseRemoteDatasource)));
final _machineWhatsappRepository = Provider((ref) => MachineWhatsappRepository(
    remoteDatasource: ref.watch(_machineWhatsappRemoteDatasource)));
final _machineRepository = Provider((ref) =>
    MachineRepository(remoteDatasource: ref.watch(_machineRemoteDatasource)));
final _authenticationRepository = Provider(
  (ref) => AuthenticationRepository(
    remoteDatasource: ref.watch(_authenticationRemoteDatasource),
  ),
);
final _userRepository = Provider(
  (ref) => UserRepository(
    remoteDatasource: ref.watch(_userRemoteDatasource),
  ),
);

final _temporaryPendingResponseRepository = Provider(
  (ref) => TemporaryPendingResponseRepository(
    localDatasource: ref.watch(_temporaryPendingResponseLocalDatasource),
  ),
);
final _applicationConfigRepository = Provider(
  (ref) => ApplicationConfigRepository(
    localDatasource: ref.watch(_applicationConfigLocalDatasource),
  ),
);
final _logoRepository = Provider(
  (ref) => LogoRepository(
    localDatasource: ref.watch(_logoLocalDatasource),
  ),
);

// remote datasource

final _incomingMessageRemoteDatasource = Provider(
  (ref) => IncomingMessageRemoteDatasource(
    client: ref.watch(_httpClient),
    surveyRemoteDatasource: ref.watch(_surveyRemoteDatasource),
    surveyResponseRemoteDatasource: ref.watch(_surveyResponseRemoteDatasource),
  ),
);
final _surveyResponseRemoteDatasource = Provider(
  (ref) => SurveyResponseRemoteDatasource(
    client: ref.watch(_httpClient),
    surveyRemoteDatasource: ref.watch(_surveyRemoteDatasource),
    temporaryPendingResponseLocalDatasource:
        ref.watch(_temporaryPendingResponseLocalDatasource),
  ),
);
final _surveyRemoteDatasource =
    Provider((ref) => SurveyRemoteDatasource(client: ref.watch(_httpClient)));
final _machineSettingRemoteDatasource = Provider(
    (ref) => MachineSettingRemoteDatasource(client: ref.watch(_httpClient)));
final _machineResponseRemoteDatasource = Provider(
    (ref) => MachineResponseRemoteDatasource(client: ref.watch(_httpClient)));
final _machineWhatsappRemoteDatasource = Provider(
    (ref) => MachineWhatsappRemoteDatasource(client: ref.watch(_httpClient)));
final _machineRemoteDatasource =
    Provider((ref) => MachineRemoteDatasource(client: ref.watch(_httpClient)));
final _authenticationRemoteDatasource = Provider(
  (ref) => AuthenticationRemoteDatasource(
    client: ref.watch(_httpClient),
    userRemoteDatasource: ref.watch(_userRemoteDatasource),
  ),
);
final _userRemoteDatasource =
    Provider((ref) => UserRemoteDatasource(client: ref.watch(_httpClient)));

// local datasource

final _temporaryPendingResponseLocalDatasource = Provider(
  (ref) => TemporaryPendingResponseLocalDatasource(
    database: ref.watch(databaseProvider),
  ),
);
final _applicationConfigLocalDatasource = Provider(
  (ref) => ApplicationConfigLocalDatasource(
    database: ref.watch(databaseProvider),
  ),
);
final _logoLocalDatasource = Provider(
  (ref) => LogoLocalDatasource(database: ref.watch(databaseProvider)),
);

// Utils & Helpers

final databaseProvider = Provider<MyDatabase>(
  (ref) => throw UnimplementedError(),
);
final _httpClient = Provider((ref) {
  final client = CustomHTTPClient();

  ref.onDispose(() => client.close());

  return client;
});
