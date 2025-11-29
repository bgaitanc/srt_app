import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srt_app/features/reservations/domain/usecases/get_reservas_by_user.dart';
import 'package:srt_app/features/reservations/domain/usecases/get_reservas_params.dart';
import 'package:srt_app/features/reservations/domain/usecases/create_reserva.dart';
import 'reservations_event.dart';
import 'reservations_state.dart';

class ReservationsBloc extends Bloc<ReservationsEvent, ReservationsState> {
  final GetReservationsByUser getReservationsByUser;
  final CreateReservation createReservation;

  ReservationsBloc({
    required this.getReservationsByUser,
    required this.createReservation,
  }) : super(const ReservationsInitial()) {
    on<FetchReservations>(_onFetchReservations);
    on<CreateReservationEvent>(_onCreateReservation);
  }

  Future<void> _onFetchReservations(
    FetchReservations event,
    Emitter<ReservationsState> emit,
  ) async {
    emit(const ReservationsLoading());
    
    final result = await getReservationsByUser(
      GetReservationsParams(event.userId),
    );
    
    result.fold(
      (failure) => emit(ReservationsError(failure)),
      (reservations) => emit(ReservationsLoaded(reservations)),
    );
  }

  Future<void> _onCreateReservation(
    CreateReservationEvent event,
    Emitter<ReservationsState> emit,
  ) async {
    emit(const ReservationCreating());
    
    final result = await createReservation(event.request);
    
    result.fold(
      (failure) => emit(ReservationCreateError(failure)),
      (reservation) => emit(ReservationCreated(reservation)),
    );
  }
}
