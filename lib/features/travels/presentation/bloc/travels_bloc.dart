import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_travels.dart';
import 'travels_event.dart';
import 'travels_state.dart';

class TravelsBloc extends Bloc<TravelsEvent, TravelsState> {
  final GetTravels getTravels;

  TravelsBloc(this.getTravels) : super(TravelsInitial()) {
    on<FetchTravels>(_onFetchViajes);
  }

  Future<void> _onFetchViajes(
    FetchTravels event,
    Emitter<TravelsState> emit,
  ) async {
    emit(TravelsLoading());
    
    final result = await getTravels(NoParams());
    
    result.fold(
      (failure) => emit(TravelsError(failure)),
      (travels) => emit(TravelsLoaded(travels)),
    );
  }
}
