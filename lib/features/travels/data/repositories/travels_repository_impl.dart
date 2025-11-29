import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/safe_call.dart';
import '../../domain/entities/travel_entity.dart';
import '../../domain/entities/reservation_detail_entity.dart';
import '../../domain/repositories/travels_repository.dart';
import '../datasource/travels_remote_data_source.dart';

class TravelsRepositoryImpl implements TravelsRepository {
  final TravelsRemoteDataSource remoteDataSource;

  TravelsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<TravelEntity>>> getTravels() async {
    return await safeCall(() => remoteDataSource.getTravels());
  }

  @override
  Future<Either<Failure, ReservationDetailEntity>> getReservationDetail(
      String travelId) async {
    return await safeCall(() => remoteDataSource.getReservationDetail(travelId));
  }
}
