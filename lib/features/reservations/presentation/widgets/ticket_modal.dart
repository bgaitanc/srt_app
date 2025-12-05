import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/reservation_info_entity.dart';

class TicketModal extends StatelessWidget {
  final ReservationInfoEntity reservation;

  const TicketModal({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 60,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildQRSection(),
                SizedBox(height: 24),
                _buildInfoGrid(),
                SizedBox(height: 24),
                _buildTotalSection(),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 16,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.close, size: 28),
              style: IconButton.styleFrom(
                backgroundColor: Colors.grey.shade100,
                shape: CircleBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQRSection() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200, width: 2),
            ),
            child: QrImageView(
              data: reservation.reservationId,
              version: QrVersions.auto,
              size: 180,
              backgroundColor: Colors.white,
              errorCorrectionLevel: QrErrorCorrectLevel.M,
            ),
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'ID: ${reservation.reservationId.substring(0, 8).toUpperCase()}...',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoGrid() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detalles del Viaje',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow(
          Icons.location_on,
          'Origen',
          reservation.originDestination,
          Color(0xFF7C3AED),
        ),
        SizedBox(height: 12),
        _buildInfoRow(
          Icons.flag,
          'Destino',
          reservation.finalDestination,
          Color(0xFF14B8A6),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildCompactInfo(
                Icons.flight_takeoff,
                'Salida',
                DateFormatter.formatDateTimeString(reservation.departureDate),
                Color(0xFF7C3AED),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildCompactInfo(
                Icons.flight_land,
                'Llegada',
                DateFormatter.formatDateTimeString(reservation.arrivalDate),
                Color(0xFF14B8A6),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Divider(height: 1),
        SizedBox(height: 16),
        Text(
          'Información del Servicio',
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 16),
        _buildInfoRow(
          Icons.event_seat,
          'Asientos',
          reservation.seats.join(', '),
          Color(0xFF6366F1),
        ),
        SizedBox(height: 12),
        _buildInfoRow(
          Icons.directions_bus,
          'Vehículo',
          '${reservation.model} (${reservation.registrationPlate})',
          Color(0xFF6366F1),
        ),
        SizedBox(height: 12),
        _buildInfoRow(
          Icons.person,
          'Conductor',
          '${reservation.driverName} ${reservation.driverSurname}',
          Color(0xFF6366F1),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: color),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompactInfo(IconData icon, String label, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF7C3AED).withOpacity(0.1), Color(0xFF6366F1).withOpacity(0.1)],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFF7C3AED).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Pagado',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'C\$${reservation.total.toStringAsFixed(2)}',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C3AED),
                ),
              ),
            ],
          ),
          Icon(
            Icons.check_circle,
            size: 48,
            color: Color(0xFF10B981),
          ),
        ],
      ),
    );
  }
}
