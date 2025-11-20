import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/reserva_info_entity.dart';

abstract class ReservasRepository {
  Future<Either<Failure, List<ReservaInfoEntity>>> getReservasByUser(int userId);
}
