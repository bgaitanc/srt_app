import '../../domain/entities/reservation_info_entity.dart';
import '../../domain/entities/create_reservation_response_entity.dart';
import '../../../../core/errors/failures.dart';

abstract class ReservationsState {
  const ReservationsState();
}

class ReservationsInitial extends ReservationsState {
  const ReservationsInitial();
}

class ReservationsLoading extends ReservationsState {
  const ReservationsLoading();
}

class ReservationsLoaded extends ReservationsState {
  final List<ReservationInfoEntity> reservations;
  const ReservationsLoaded(this.reservations);
}

class ReservationsError extends ReservationsState {
  final Failure failure;
  const ReservationsError(this.failure);
}

class ReservationCreating extends ReservationsState {
  const ReservationCreating();
}

class ReservationCreated extends ReservationsState {
  final CreateReservationResponseEntity reservation;
  const ReservationCreated(this.reservation);
}

class ReservationCreateError extends ReservationsState {
  final Failure failure;
  const ReservationCreateError(this.failure);
}
