import '../../domain/entities/create_reserva_request_entity.dart';

abstract class ReservasEvent {
  const ReservasEvent();
}

class FetchReservas extends ReservasEvent {
  final int userId;
  const FetchReservas(this.userId);
}

class CreateReservaEvent extends ReservasEvent {
  final CreateReservaRequestEntity request;
  const CreateReservaEvent(this.request);
}
