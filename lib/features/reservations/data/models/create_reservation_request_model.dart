import '../../domain/entities/create_reservation_request_entity.dart';

class CreateReservationRequestModel {
  CreateReservationRequestModel._();

  static Map<String, dynamic> toJson(CreateReservationRequestEntity entity) {
    return {
      'clientId': entity.userId,
      'travelId': entity.travelId,
      'details': entity.seats,
      'reservationDate': DateTime.now().toIso8601String(),
    };
  }
}
