import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../domain/entities/driver_trip_entity.dart';
import '../bloc/ticket_scanner_bloc.dart';
import '../bloc/ticket_scanner_event.dart';
import '../bloc/ticket_scanner_state.dart';

class QRScannerPage extends StatefulWidget {
  final DriverTripEntity trip;

  const QRScannerPage({super.key, required this.trip});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  MobileScannerController cameraController = MobileScannerController();
  bool _hasScanned = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        setState(() => _hasScanned = true);
        context.read<TicketScannerBloc>().add(ScanTicketEvent(barcode.rawValue!));
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Escanear Ticket',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF0288D1),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.flash_on),
            onPressed: () => cameraController.toggleTorch(),
          ),
        ],
      ),
      body: BlocListener<TicketScannerBloc, TicketScannerState>(
        listener: (context, state) {
          if (state is TicketValidated) {
            _showValidationResult(context, state);
          } else if (state is TicketScannerError) {
            _showErrorDialog(context, state.message);
          }
        },
        child: Stack(
          children: [
            MobileScanner(
              controller: cameraController,
              onDetect: _onDetect,
            ),
            _buildOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlay() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      child: Column(
        children: [
          Expanded(flex: 1, child: Container()),
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.qr_code_scanner, size: 48, color: Colors.white),
                SizedBox(height: 16),
                Text(
                  'Coloca el código QR dentro del marco',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showValidationResult(BuildContext context, TicketValidated state) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (modalContext) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              state.ticket.isValid ? Icons.check_circle : Icons.cancel,
              size: 64,
              color: state.ticket.isValid ? Color(0xFF10B981) : Color(0xFFEF4444),
            ),
            SizedBox(height: 16),
            Text(
              state.ticket.isValid ? '¡Ticket Válido!' : 'Ticket Inválido',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: state.ticket.isValid ? Color(0xFF10B981) : Color(0xFFEF4444),
              ),
            ),
            SizedBox(height: 24),
            if (state.ticket.isValid) ...[
              _buildInfoRow('Pasajero', '${state.ticket.passengerName} ${state.ticket.passengerSurname}'),
              _buildInfoRow('Asientos', state.ticket.seatNumbers!.join(', ')),
              _buildInfoRow('Origen', state.ticket.origin!),
              _buildInfoRow('Destino', state.ticket.destination!),
            ] else ...[
              Text(
                state.ticket.errorMessage ?? 'Error desconocido',
                style: GoogleFonts.inter(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(modalContext);
                      Navigator.pop(context);
                    },
                    child: Text('Cerrar'),
                  ),
                ),
                if (state.ticket.isValid) ...[
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(modalContext);
                        setState(() => _hasScanned = false);
                        context.read<TicketScannerBloc>().add(ResetScannerEvent());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0288D1),
                      ),
                      child: Text('Escanear Otro', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              setState(() => _hasScanned = false);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
