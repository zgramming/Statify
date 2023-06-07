import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:telephony/telephony.dart';

import 'model/datasource/phone_local_datasource.dart';
import 'model/datasource/sms_local_datasource.dart';
import 'model/model/phone_model.dart';
import 'model/model/sms_model.dart';
import 'model/repository/sms_repository.dart';
import 'utils/constant.dart';
import 'view_model/sms_view_model.dart';

final smsNotifier = StateNotifierProvider<SMSNotifier, SMSState>(
    (ref) => SMSNotifier(repository: ref.watch(_smsRepository)));
final phoneNotifier = StateNotifierProvider<PhoneNotifier, PhoneState>(
    (ref) => PhoneNotifier(repository: ref.watch(_phoneRepository)));

final _smsRepository = Provider(
    (ref) => SMSRepository(localDatasource: ref.watch(_smsLocalDatasource)));
final _phoneRepository = Provider((ref) =>
    PhoneRepository(localDatasource: ref.watch(_phoneLocalDatasource)));

final _smsLocalDatasource =
    Provider((ref) => SMSLocalDatasource(box: ref.watch(_smsBox)));
final _phoneLocalDatasource =
    Provider((ref) => PhoneLocalDatasource(box: ref.watch(_phoneBox)));

final telephony = Provider((ref) => Telephony.instance);
final _phoneBox = Provider((ref) => Hive.box<PhoneModel>(hivePhoneBox));
final _smsBox = Provider((ref) => Hive.box<SMSModel>(hiveSMSBox));
