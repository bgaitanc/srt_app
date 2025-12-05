import '../entities/driver_trip_entity.dart';
import '../entities/validated_ticket_entity.dart';

abstract class DriverRepository {
  Future<List<DriverTripEntity>> getAssignedTrips();
  Future<DriverTripEntity> getTripDetails(String travelId);
  Future<ValidatedTicketEntity> validateTicket(String reservationId);
  Future<void> completeTrip(String travelId);
}
