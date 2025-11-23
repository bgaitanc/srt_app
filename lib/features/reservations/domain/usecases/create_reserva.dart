import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/create_reserva_request_entity.dart';
import '../entities/create_reserva_response_entity.dart';
import '../repositories/reservas_repository.dart';

class CreateReserva {
  final ReservasRepository repository;

  CreateReserva(this.repository);

  Future<Either<Failure, CreateReservaResponseEntity>> call(
      CreateReservaRequestEntity request) async {
    return await repository.createReserva(request);
  }
}
