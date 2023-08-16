import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../datasource/remote/machine_whatsapp_remote_datasource.dart';
import '../model/machine/machine_whatsapp_create_response_model.dart';

class MachineWhatsappRepository {
  final MachineWhatsappRemoteDatasource remoteDatasource;
  const MachineWhatsappRepository({
    required this.remoteDatasource,
  });

  Future<Either<Failure, MachineWhatsappCreateResponseModel>> create({
    required String number,
    required String machineId,
  }) async {
    try {
      final result = await remoteDatasource.create(
        number: number,
        machineId: machineId,
      );

      return Right(result);
    } on Exception catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
