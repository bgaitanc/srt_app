import 'package:meta/meta.dart';

@immutable
class ValidatedTicketEntity {
  final bool isValid;
  final String? reservationId;
  final String? passengerName;
  final String? passengerSurname;
  final List<int>? seatNumbers;
  final String? origin;
  final String? destination;
  final String? departureDate;
  final String? errorMessage;

  const ValidatedTicketEntity({
    required this.isValid,
    this.reservationId,
    this.passengerName,
    this.passengerSurname,
    this.seatNumbers,
    this.origin,
    this.destination,
    this.departureDate,
    this.errorMessage,
  });

  factory ValidatedTicketEntity.invalid(String errorMessage) {
    return ValidatedTicketEntity(
      isValid: false,
      errorMessage: errorMessage,
    );
  }

  factory ValidatedTicketEntity.valid({
    required String reservationId,
    required String passengerName,
    required String passengerSurname,
    required List<int> seatNumbers,
    required String origin,
    required String destination,
    required String departureDate,
  }) {
    return ValidatedTicketEntity(
      isValid: true,
      reservationId: reservationId,
      passengerName: passengerName,
      passengerSurname: passengerSurname,
      seatNumbers: seatNumbers,
      origin: origin,
      destination: destination,
      departureDate: departureDate,
    );
  }
}
