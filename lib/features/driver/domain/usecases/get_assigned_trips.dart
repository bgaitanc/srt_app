import '../entities/driver_trip_entity.dart';
import '../repositories/driver_repository.dart';

class GetAssignedTrips {
  final DriverRepository repository;

  GetAssignedTrips(this.repository);

  Future<List<DriverTripEntity>> call() {
    return repository.getAssignedTrips();
  }
}
