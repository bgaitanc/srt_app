import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/create_reservation_request_entity.dart';
import '../entities/create_reservation_response_entity.dart';
import '../repositories/reservas_repository.dart';

class CreateReservation {
  final ReservasRepository repository;

  CreateReservation(this.repository);

  Future<Either<Failure, CreateReservationResponseEntity>> call(
      CreateReservationRequestEntity request) async {
    return await repository.createReserva(request);
  }
}
