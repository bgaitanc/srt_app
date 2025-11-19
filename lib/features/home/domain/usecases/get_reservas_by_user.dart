import 'package:dartz/dartz.dart';
import 'package:srt_app/core/errors/failures.dart';
import 'package:srt_app/core/usecases/usecase.dart';
import 'package:srt_app/features/home/domain/repositories/reservas_repository.dart';
import '../entities/reserva_info_entity.dart';
import 'get_reservas_params.dart';

class GetReservasByUser
    implements UseCase<Either<Failure, List<ReservaInfoEntity>>, GetReservasParams> {
  final ReservasRepository repository;

  GetReservasByUser(this.repository);

  @override
  Future<Either<Failure, List<ReservaInfoEntity>>> call(
    GetReservasParams params,
  ) async {
    return await repository.getReservasByUser(params.userId);
  }
}
