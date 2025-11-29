import 'package:equatable/equatable.dart';

class TravelEntity extends Equatable {
  final String travelId;
  final double price;
  final String departureDate;
  final String arrivalDate;
  //TODO convertirlo a enum para que coincida con el enum del BE
  final String status;
  
  // Ruta info
  final String originDestination;
  final String finalDestination;
  final double distanceInKm;
  final String estimatedTime;
  
  // Vehiculo info
  final String registrationPlate;
  final String model;
  final int capacity;
  
  // Conductor info
  final String driverName;
  final String driverSurname;

  const TravelEntity({
    required this.travelId,
    required this.price,
    required this.departureDate,
    required this.arrivalDate,
    required this.status,
    required this.originDestination,
    required this.finalDestination,
    required this.distanceInKm,
    required this.estimatedTime,
    required this.registrationPlate,
    required this.model,
    required this.capacity,
    required this.driverName,
    required this.driverSurname,
  });

  @override
  List<Object?> get props => [
        travelId,
        price,
        departureDate,
        arrivalDate,
        status,
        originDestination,
        finalDestination,
        distanceInKm,
        estimatedTime,
        registrationPlate,
        model,
        capacity,
        driverName,
        driverSurname,
      ];
}
