import '../entities/validated_ticket_entity.dart';
import '../repositories/driver_repository.dart';

class ValidateTicket {
  final DriverRepository repository;

  ValidateTicket(this.repository);

  Future<ValidatedTicketEntity> call(String reservationId) {
    return repository.validateTicket(reservationId);
  }
}
