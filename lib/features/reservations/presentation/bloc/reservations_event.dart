import '../../domain/entities/create_reservation_request_entity.dart';

abstract class ReservationsEvent {
  const ReservationsEvent();
}

class FetchReservations extends ReservationsEvent {
  final String userId;
  const FetchReservations(this.userId);
}

class CreateReservationEvent extends ReservationsEvent {
  final CreateReservationRequestEntity request;
  const CreateReservationEvent(this.request);
}
