import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/reserva_info_entity.dart';
import '../entities/create_reserva_request_entity.dart';
import '../entities/create_reserva_response_entity.dart';

abstract class ReservasRepository {
  Future<Either<Failure, List<ReservaInfoEntity>>> getReservasByUser(int userId);
  Future<Either<Failure, CreateReservaResponseEntity>> createReserva(
      CreateReservaRequestEntity request);
}
