import 'package:hive/hive.dart';

import '../model/sms_model.dart';

class SMSLocalDatasource {
  final Box<SMSModel> box;
  SMSLocalDatasource({
    required this.box,
  });

  Future<String> insert(SMSModel model) async {
    await box.put(model.id, model);

    return "Berhasil menyimpan SMS";
  }

  Future<String> delete(String id) async {
    await box.delete(id);

    return "Berhasil menghapus SMS";
  }

  List<SMSModel> getAll() {
    return box.values.toList();
  }
}
