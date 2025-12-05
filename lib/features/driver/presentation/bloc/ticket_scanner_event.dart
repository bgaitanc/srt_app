import '../../domain/entities/validated_ticket_entity.dart';

abstract class TicketScannerEvent {}

class ScanTicketEvent extends TicketScannerEvent {
  final String reservationId;

  ScanTicketEvent(this.reservationId);
}

class ResetScannerEvent extends TicketScannerEvent {}
