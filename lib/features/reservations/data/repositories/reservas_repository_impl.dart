import 'package:dartz/dartz.dart';
import 'package:srt_app/core/errors/failures.dart';
import 'package:srt_app/core/utils/safe_call.dart';
import 'package:srt_app/features/reservations/data/datasource/reservations_remote_data_source.dart';
import '../../domain/entities/reservation_info_entity.dart';
import '../../domain/entities/create_reservation_request_entity.dart';
import '../../domain/entities/create_reservation_response_entity.dart';
import '../../domain/repositories/reservas_repository.dart';

class ReservasRepositoryImpl implements ReservasRepository {
  final ReservationsRemoteDataSource remoteDataSource;

  ReservasRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ReservationInfoEntity>>> getReservasByUser(
    String userId,
  ) async {
    return safeCall(() => remoteDataSource.getReservationsByUser(userId));
  }

  @override
  Future<Either<Failure, CreateReservationResponseEntity>> createReserva(
      CreateReservationRequestEntity request) async {
    return safeCall(() => remoteDataSource.createReservation(request));
  }
}
