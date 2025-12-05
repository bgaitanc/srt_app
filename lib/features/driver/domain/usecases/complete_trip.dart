import '../repositories/driver_repository.dart';

class CompleteTrip {
  final DriverRepository repository;

  CompleteTrip(this.repository);

  Future<void> call(String travelId) {
    return repository.completeTrip(travelId);
  }
}
