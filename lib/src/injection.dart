import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:telephony/telephony.dart';

import 'model/datasource/application_config_local_datasource.dart';
import 'model/datasource/local/authentication_local_datasource.dart';
import 'model/datasource/phone_local_datasource.dart';
import 'model/datasource/remote/authentication_remote_datasource.dart';
import 'model/datasource/remote/machine_remote_datasource.dart';
import 'model/datasource/remote/machine_response_setting_remote_datasource.dart';
import 'model/datasource/remote/machine_whatsapp_remote_datasource.dart';
import 'model/datasource/remote/survey_remote_datasource.dart';
import 'model/datasource/remote/survey_response_remote_datasource.dart';
import 'model/datasource/sms_local_datasource.dart';
import 'model/model/application_config_model.dart';
import 'model/model/machine/machine_whatsapp_model.dart';
import 'model/model/phone_model.dart';
import 'model/model/sms_model.dart';
import 'model/repository/application_config_repository.dart';
import 'model/repository/authentication_repository.dart';
import 'model/repository/machine_repository.dart';
import 'model/repository/machine_response_setting_repository.dart';
import 'model/repository/machine_whatsapp_repository.dart';
import 'model/repository/sms_repository.dart';
import 'model/repository/survey_repository.dart';
import 'model/repository/survey_response_repository.dart';
import 'utils/constant.dart';
import 'utils/http_client.dart';
import 'view_model/application_config_notifier.dart';
import 'view_model/authentication_notifier.dart';
import 'view_model/machine_notifier.dart';
import 'view_model/machine_response_setting_notifier.dart';
import 'view_model/machine_whatsapp_notifier.dart';
import 'view_model/sms_view_notifier.dart';
import 'view_model/survey_notifier.dart';
import 'view_model/survey_response_notifier.dart';

// Custom Provider
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

final surveyNotifier = StateNotifierProvider<SurveyNotifier, SurveyState>(
  (ref) => SurveyNotifier(repository: ref.watch(_surveyRepository)),
);
final surveyResponseNotifier =
    StateNotifierProvider<SurveyResponseNotifier, SurveyResponseState>(
  (ref) => SurveyResponseNotifier(
    repository: ref.watch(_surveyResponseRepository),
  ),
);
final machineResponseSettingNotifier = StateNotifierProvider<
    MachineResponseSettingNotifier, MachineResponseSettingState>(
  (ref) => MachineResponseSettingNotifier(
    repository: ref.watch(_machineResponseSettingRepository),
  ),
);
final machineWhatsappNotifier =
    StateNotifierProvider<MachineWhatsappNotifier, MachineWhatsappState>(
  (ref) => MachineWhatsappNotifier(
    repository: ref.watch(_machineWhatsappRepository),
  ),
);
final machineNotifier = StateNotifierProvider<MachineNotifier, MachineState>(
  (ref) => MachineNotifier(repository: ref.watch(_machineRepository)),
);
final authenticationNotifier =
    StateNotifierProvider<AuthenticationNotifier, AuthenticationState>(
  (ref) => AuthenticationNotifier(
    repository: ref.watch(_authenticationRepository),
  ),
);
final applicationConfigNotifier =
    StateNotifierProvider<ApplicationConfigNotifier, ApplicationConfigState>(
        (ref) => ApplicationConfigNotifier(
            repository: ref.watch(_applicationConfigRepository)));
final smsNotifier = StateNotifierProvider<SMSNotifier, SMSState>(
    (ref) => SMSNotifier(repository: ref.watch(_smsRepository)));
final phoneNotifier = StateNotifierProvider<PhoneNotifier, PhoneState>(
    (ref) => PhoneNotifier(repository: ref.watch(_phoneRepository)));

// repository

final _surveyRepository = Provider((ref) =>
    SurveyRepository(remoteDatasource: ref.watch(_surveyRemoteDatasource)));
final _surveyResponseRepository = Provider((ref) => SurveyResponseRepository(
    remoteDatasource: ref.watch(_surveyResponseRemoteDatasource)));
final _machineResponseSettingRepository = Provider((ref) =>
    MachineResponseSettingRepository(
        remoteDatasource: ref.watch(_machineResponseSettingRemoteDatasource)));
final _machineWhatsappRepository = Provider((ref) => MachineWhatsappRepository(
    remoteDatasource: ref.watch(_machineWhatsappRemoteDatasource)));
final _machineRepository = Provider((ref) =>
    MachineRepository(remoteDatasource: ref.watch(_machineRemoteDatasource)));
final _authenticationRepository = Provider(
  (ref) => AuthenticationRepository(
    remoteDatasource: ref.watch(_authenticationRemoteDatasource),
    localDatasource: ref.watch(_authenticationLocalDatasource),
  ),
);
final _applicationConfigRepository = Provider((ref) =>
    ApplicationConfigRepository(
        localDatasource: ref.watch(_applicationConfigLocalDatasource)));
final _smsRepository = Provider(
    (ref) => SMSRepository(localDatasource: ref.watch(_smsLocalDatasource)));
final _phoneRepository = Provider((ref) =>
    PhoneRepository(localDatasource: ref.watch(_phoneLocalDatasource)));

// remote datasource

final _surveyResponseRemoteDatasource = Provider(
    (ref) => SurveyResponseRemoteDatasource(client: ref.watch(_httpClient)));
final _surveyRemoteDatasource =
    Provider((ref) => SurveyRemoteDatasource(client: ref.watch(_httpClient)));
final _machineResponseSettingRemoteDatasource = Provider((ref) =>
    MachineResponseSettingRemoteDatasource(client: ref.watch(_httpClient)));
final _machineWhatsappRemoteDatasource = Provider(
    (ref) => MachineWhatsappRemoteDatasource(client: ref.watch(_httpClient)));
final _machineRemoteDatasource =
    Provider((ref) => MachineRemoteDatasource(client: ref.watch(_httpClient)));
final _authenticationRemoteDatasource = Provider(
    (ref) => AuthenticationRemoteDatasource(client: ref.watch(_httpClient)));

// local datasource
final _authenticationLocalDatasource =
    Provider((ref) => AuthenticationLocalDatasource());
final _applicationConfigLocalDatasource = Provider((ref) =>
    ApplicationConfigLocalDatasource(box: ref.watch(_applicationConfigBox)));
final _smsLocalDatasource =
    Provider((ref) => SMSLocalDatasource(box: ref.watch(_smsBox)));
final _phoneLocalDatasource =
    Provider((ref) => PhoneLocalDatasource(box: ref.watch(_phoneBox)));

final telephony = Provider((ref) => Telephony.instance);
final _applicationConfigBox = Provider(
    (ref) => Hive.box<ApplicationConfigModel>(hiveApplicationConfigBox));
final _phoneBox = Provider((ref) => Hive.box<PhoneModel>(hivePhoneBox));
final _smsBox = Provider((ref) => Hive.box<SMSModel>(hiveSMSBox));

final _httpClient = Provider((ref) {
  final client = CustomHTTPClient();

  ref.onDispose(() => client.close());

  return client;
});
