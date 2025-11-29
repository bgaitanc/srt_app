import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/travel_entity.dart';
import '../repositories/travels_repository.dart';

/// Use case to get all available travels
class GetTravels implements UseCase<Either<Failure, List<TravelEntity>>, NoParams> {
  final TravelsRepository repository;

  GetTravels(this.repository);

  @override
  Future<Either<Failure, List<TravelEntity>>> call(NoParams params) async {
    return await repository.getTravels();
  }
}
