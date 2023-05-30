import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:telephony/telephony.dart';

import 'model/datasource/sms_local_datasource.dart';
import 'model/model/sms_model.dart';
import 'utils/constant.dart';

final smsNotifier = StateNotifierProvider<SMSNotifier, SMSState>(
    (ref) => SMSNotifier(repository: ref.watch(_smsRepository)));

final _smsRepository = Provider(
    (ref) => SMSRepository(localDatasource: ref.watch(_smsLocalDatasource)));

final _smsLocalDatasource =
    Provider((ref) => SMSLocalDatasource(box: ref.watch(_smsBox)));

final telephony = Provider((ref) => Telephony.instance);
final _smsBox = Provider((ref) => Hive.box<SMSModel>(hiveSMSBox));
