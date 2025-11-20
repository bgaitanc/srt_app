import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_viajes.dart';
import 'viajes_event.dart';
import 'viajes_state.dart';

class ViajesBloc extends Bloc<ViajesEvent, ViajesState> {
  final GetViajes getViajes;

  ViajesBloc(this.getViajes) : super(ViajesInitial()) {
    on<FetchViajes>(_onFetchViajes);
  }

  Future<void> _onFetchViajes(
    FetchViajes event,
    Emitter<ViajesState> emit,
  ) async {
    emit(ViajesLoading());
    
    final result = await getViajes(NoParams());
    
    result.fold(
      (failure) => emit(ViajesError(failure)),
      (viajes) => emit(ViajesLoaded(viajes)),
    );
  }
}
