import '../../domain/entities/driver_trip_entity.dart';

abstract class DriverTripsState {}

class DriverTripsInitial extends DriverTripsState {}

class DriverTripsLoading extends DriverTripsState {}

class DriverTripsLoaded extends DriverTripsState {
  final List<DriverTripEntity> trips;

  DriverTripsLoaded(this.trips);
}

class DriverTripsError extends DriverTripsState {
  final String message;

  DriverTripsError(this.message);
}

class TripCompletedSuccess extends DriverTripsState {
  final String travelId;

  TripCompletedSuccess(this.travelId);
}
