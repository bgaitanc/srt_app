import '../../domain/entities/driver_trip_entity.dart';

abstract class DriverTripsEvent {}

class LoadAssignedTripsEvent extends DriverTripsEvent {}

class CompleteTripEvent extends DriverTripsEvent {
  final String travelId;

  CompleteTripEvent(this.travelId);
}

class RefreshTripsEvent extends DriverTripsEvent {}
