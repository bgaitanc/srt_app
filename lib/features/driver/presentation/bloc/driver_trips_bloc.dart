import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_assigned_trips.dart';
import '../../domain/usecases/complete_trip.dart';
import 'driver_trips_event.dart';
import 'driver_trips_state.dart';

class DriverTripsBloc extends Bloc<DriverTripsEvent, DriverTripsState> {
  final GetAssignedTrips getAssignedTrips;
  final CompleteTrip completeTrip;

  DriverTripsBloc({
    required this.getAssignedTrips,
    required this.completeTrip,
  }) : super(DriverTripsInitial()) {
    on<LoadAssignedTripsEvent>(_onLoadAssignedTrips);
    on<CompleteTripEvent>(_onCompleteTrip);
    on<RefreshTripsEvent>(_onRefreshTrips);
  }

  Future<void> _onLoadAssignedTrips(
    LoadAssignedTripsEvent event,
    Emitter<DriverTripsState> emit,
  ) async {
    emit(DriverTripsLoading());
    try {
      final trips = await getAssignedTrips();
      emit(DriverTripsLoaded(trips));
    } catch (e) {
      emit(DriverTripsError('Error al cargar viajes: ${e.toString()}'));
    }
  }

  Future<void> _onCompleteTrip(
    CompleteTripEvent event,
    Emitter<DriverTripsState> emit,
  ) async {
    try {
      await completeTrip(event.travelId);
      emit(TripCompletedSuccess(event.travelId));
      // Reload trips after completing
      add(LoadAssignedTripsEvent());
    } catch (e) {
      emit(DriverTripsError('Error al completar viaje: ${e.toString()}'));
    }
  }

  Future<void> _onRefreshTrips(
    RefreshTripsEvent event,
    Emitter<DriverTripsState> emit,
  ) async {
    try {
      final trips = await getAssignedTrips();
      emit(DriverTripsLoaded(trips));
    } catch (e) {
      emit(DriverTripsError('Error al refrescar viajes: ${e.toString()}'));
    }
  }
}
