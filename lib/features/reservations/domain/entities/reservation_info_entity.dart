import 'package:meta/meta.dart';

@immutable
class ReservationInfoEntity {
  final String reservationId;
  final String travelId;
  final DateTime reservationDate;
  final List<int> seats;
  final double total;
  final String originDestination;
  final String finalDestination;
  final String departureDate;
  final String arrivalDate;
  final String vehicleType;
  final String vehicle;
  final String model;
  final String brand;
  final String driverName;
  final String driverSurname;
  final String registrationPlate;

  const ReservationInfoEntity({
    required this.reservationId,
    required this.travelId,
    required this.reservationDate,
    required this.seats,
    required this.total,
    required this.originDestination,
    required this.finalDestination,
    required this.departureDate,
    required this.arrivalDate,
    required this.vehicleType,
    required this.vehicle,
    required this.model,
    required this.brand,
    required this.driverName,
    required this.driverSurname,
    required this.registrationPlate,
  });
}
