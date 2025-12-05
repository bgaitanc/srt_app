import '../../domain/entities/driver_trip_entity.dart';
import '../../domain/entities/validated_ticket_entity.dart';
import '../../domain/repositories/driver_repository.dart';
import '../datasources/driver_remote_data_source.dart';

class DriverRepositoryImpl implements DriverRepository {
  final DriverRemoteDataSource remoteDataSource;

  DriverRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<DriverTripEntity>> getAssignedTrips() async {
    return await remoteDataSource.getAssignedTrips();
  }

  @override
  Future<DriverTripEntity> getTripDetails(String travelId) async {
    final trips = await getAssignedTrips();
    return trips.firstWhere((trip) => trip.travelId == travelId);
  }

  @override
  Future<ValidatedTicketEntity> validateTicket(String reservationId) async {
    try {
      return await remoteDataSource.validateTicket(reservationId);
    } catch (e) {
      return ValidatedTicketEntity.invalid('Error al validar ticket');
    }
  }

  @override
  Future<void> completeTrip(String travelId) async {
    await remoteDataSource.completeTrip(travelId);
  }
}
