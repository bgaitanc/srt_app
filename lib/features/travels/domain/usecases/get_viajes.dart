import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/viaje_entity.dart';
import '../repositories/viajes_repository.dart';

/// Use case to get all available travels
class GetViajes implements UseCase<Either<Failure, List<ViajeEntity>>, NoParams> {
  final ViajesRepository repository;

  GetViajes(this.repository);

  @override
  Future<Either<Failure, List<ViajeEntity>>> call(NoParams params) async {
    return await repository.getViajes();
  }
}
