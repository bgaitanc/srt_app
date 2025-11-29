import 'package:meta/meta.dart';

@immutable
class ReservationInfoEntity {
  final int reservationId;
  final int travelId;
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
  });
}
