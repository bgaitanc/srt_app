import 'package:dartz/dartz.dart';
import 'package:srt_app/core/errors/failures.dart';
import 'package:srt_app/core/usecases/usecase.dart';
import 'package:srt_app/features/reservations/domain/repositories/reservas_repository.dart';
import '../entities/reservation_info_entity.dart';
import 'get_reservas_params.dart';

class GetReservationsByUser
    implements UseCase<Either<Failure, List<ReservationInfoEntity>>, GetReservationsParams> {
  final ReservasRepository repository;

  GetReservationsByUser(this.repository);

  @override
  Future<Either<Failure, List<ReservationInfoEntity>>> call(
    GetReservationsParams params,
  ) async {
    return await repository.getReservasByUser(params.userId);
  }
}
