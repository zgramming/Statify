import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:telephony/telephony.dart';

import 'model/datasource/application_config_local_datasource.dart';
import 'model/datasource/phone_local_datasource.dart';
import 'model/datasource/sms_local_datasource.dart';
import 'model/model/application_config_model.dart';
import 'model/model/phone_model.dart';
import 'model/model/sms_model.dart';
import 'model/repository/application_config_repository.dart';
import 'model/repository/sms_repository.dart';
import 'utils/constant.dart';
import 'view_model/application_config_notifier.dart';
import 'view_model/sms_view_notifier.dart';

final applicationConfigNotifier =
    StateNotifierProvider<ApplicationConfigNotifier, ApplicationConfigState>(
        (ref) => ApplicationConfigNotifier(
            repository: ref.watch(_applicationConfigRepository)));
final smsNotifier = StateNotifierProvider<SMSNotifier, SMSState>(
    (ref) => SMSNotifier(repository: ref.watch(_smsRepository)));
final phoneNotifier = StateNotifierProvider<PhoneNotifier, PhoneState>(
    (ref) => PhoneNotifier(repository: ref.watch(_phoneRepository)));

final _applicationConfigRepository = Provider((ref) =>
    ApplicationConfigRepository(
        localDatasource: ref.watch(_applicationConfigLocalDatasource)));
final _smsRepository = Provider(
    (ref) => SMSRepository(localDatasource: ref.watch(_smsLocalDatasource)));
final _phoneRepository = Provider((ref) =>
    PhoneRepository(localDatasource: ref.watch(_phoneLocalDatasource)));

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
