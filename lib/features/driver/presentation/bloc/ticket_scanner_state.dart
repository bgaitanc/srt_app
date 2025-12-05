import '../../domain/entities/validated_ticket_entity.dart';

abstract class TicketScannerState {}

class TicketScannerInitial extends TicketScannerState {}

class TicketScannerScanning extends TicketScannerState {}

class TicketValidated extends TicketScannerState {
  final ValidatedTicketEntity ticket;

  TicketValidated(this.ticket);
}

class TicketScannerError extends TicketScannerState {
  final String message;

  TicketScannerError(this.message);
}
