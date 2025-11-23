import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srt_app/features/reservations/domain/usecases/get_reservas_by_user.dart';
import 'package:srt_app/features/reservations/domain/usecases/get_reservas_params.dart';
import 'package:srt_app/features/reservations/domain/usecases/create_reserva.dart';
import 'reservas_event.dart';
import 'reservas_state.dart';

class ReservasBloc extends Bloc<ReservasEvent, ReservasState> {
  final GetReservasByUser getReservasByUser;
  final CreateReserva createReserva;

  ReservasBloc({
    required this.getReservasByUser,
    required this.createReserva,
  }) : super(const ReservasInitial()) {
    on<FetchReservas>(_onFetchReservas);
    on<CreateReservaEvent>(_onCreateReserva);
  }

  Future<void> _onFetchReservas(
    FetchReservas event,
    Emitter<ReservasState> emit,
  ) async {
    emit(const ReservasLoading());
    
    final result = await getReservasByUser(
      GetReservasParams(event.userId),
    );
    
    result.fold(
      (failure) => emit(ReservasError(failure)),
      (reservas) => emit(ReservasLoaded(reservas)),
    );
  }

  Future<void> _onCreateReserva(
    CreateReservaEvent event,
    Emitter<ReservasState> emit,
  ) async {
    emit(const ReservaCreating());
    
    final result = await createReserva(event.request);
    
    result.fold(
      (failure) => emit(ReservaCreateError(failure)),
      (reserva) => emit(ReservaCreated(reserva)),
    );
  }
}
