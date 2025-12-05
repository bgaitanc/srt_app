import 'package:meta/meta.dart';

@immutable
class DriverTripEntity {
  final String travelId;
  final String status;
  final String originDestination;
  final String finalDestination;
  final String departureDate;
  final String arrivalDate;
  final double distanceInKm;
  final String vehicleModel;
  final String registrationPlate;
  final int passengerCount;
  final int capacity;

  const DriverTripEntity({
    required this.travelId,
    required this.status,
    required this.originDestination,
    required this.finalDestination,
    required this.departureDate,
    required this.arrivalDate,
    required this.distanceInKm,
    required this.vehicleModel,
    required this.registrationPlate,
    required this.passengerCount,
    required this.capacity,
  });
}
