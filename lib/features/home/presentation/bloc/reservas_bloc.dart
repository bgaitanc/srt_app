import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:srt_app/features/home/domain/usecases/get_reservas_by_user.dart';
import 'package:srt_app/features/home/domain/usecases/get_reservas_params.dart';
import 'reservas_event.dart';
import 'reservas_state.dart';

class ReservasBloc extends Bloc<ReservasEvent, ReservasState> {
  final GetReservasByUser getReservasByUser;

  ReservasBloc(this.getReservasByUser) : super(const ReservasInitial()) {
    on<FetchReservas>(_onFetchReservas);
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
}
