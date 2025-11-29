import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/travel_entity.dart';
import '../entities/reservation_detail_entity.dart';

/// Repository interface for travels
abstract class TravelsRepository {
  Future<Either<Failure, List<TravelEntity>>> getTravels();
  Future<Either<Failure, ReservationDetailEntity>> getReservationDetail(String travelId);
}
