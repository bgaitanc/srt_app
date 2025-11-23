import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/viaje_entity.dart';
import '../entities/reserva_detalle_entity.dart';

/// Repository interface for travels
abstract class ViajesRepository {
  Future<Either<Failure, List<ViajeEntity>>> getViajes();
  Future<Either<Failure, ReservaDetalleEntity>> getReservaDetalle(int viajeId);
}
