import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/validate_ticket.dart';
import 'ticket_scanner_event.dart';
import 'ticket_scanner_state.dart';

class TicketScannerBloc extends Bloc<TicketScannerEvent, TicketScannerState> {
  final ValidateTicket validateTicket;

  TicketScannerBloc({required this.validateTicket}) : super(TicketScannerInitial()) {
    on<ScanTicketEvent>(_onScanTicket);
    on<ResetScannerEvent>(_onResetScanner);
  }

  Future<void> _onScanTicket(
    ScanTicketEvent event,
    Emitter<TicketScannerState> emit,
  ) async {
    emit(TicketScannerScanning());
    try {
      final result = await validateTicket(event.reservationId);
      emit(TicketValidated(result));
    } catch (e) {
      emit(TicketScannerError('Error al validar ticket: ${e.toString()}'));
    }
  }

  void _onResetScanner(
    ResetScannerEvent event,
    Emitter<TicketScannerState> emit,
  ) {
    emit(TicketScannerInitial());
  }
}
