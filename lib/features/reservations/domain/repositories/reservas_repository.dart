import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/reservation_info_entity.dart';
import '../entities/create_reservation_request_entity.dart';
import '../entities/create_reservation_response_entity.dart';

abstract class ReservasRepository {
  Future<Either<Failure, List<ReservationInfoEntity>>> getReservasByUser(String userId);
  Future<Either<Failure, CreateReservationResponseEntity>> createReserva(
      CreateReservationRequestEntity request);
}
