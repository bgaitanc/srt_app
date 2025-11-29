import 'package:equatable/equatable.dart';

class CreateReservationResponseEntity extends Equatable {
  final int reservationId;
  final int travelId;
  final String reservationDate;
  final double total;
  final TravelInfo travel;
  final RouteInfo route;

  const CreateReservationResponseEntity({
    required this.reservationId,
    required this.travelId,
    required this.reservationDate,
    required this.total,
    required this.travel,
    required this.route,
  });

  @override
  List<Object?> get props => [
        reservationId,
        travelId,
        reservationDate,
        total,
        travel,
        route,
      ];
}

class TravelInfo extends Equatable {
  final double price;
  final String departureDate;
  final String arrivalDate;

  const TravelInfo({
    required this.price,
    required this.departureDate,
    required this.arrivalDate,
  });

  @override
  List<Object?> get props => [price, departureDate, arrivalDate];
}

class RouteInfo extends Equatable {
  final String originDestination;
  final String finalDestination;
  final double distanceInKm;
  final String estimatedTime;

  const RouteInfo({
    required this.originDestination,
    required this.finalDestination,
    required this.distanceInKm,
    required this.estimatedTime,
  });

  @override
  List<Object?> get props => [
        originDestination,
        finalDestination,
        distanceInKm,
        estimatedTime,
      ];
}
