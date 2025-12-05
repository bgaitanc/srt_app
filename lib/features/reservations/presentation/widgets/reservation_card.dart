import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/reservation_info_entity.dart';
import '../../../../core/utils/date_formatter.dart';
import 'ticket_modal.dart';

class ReservationCard extends StatelessWidget {
  final String state;
  final ReservationInfoEntity reservation;

  const ReservationCard({
    super.key,
    required this.state,
    required this.reservation,
  });

  void _showTicketModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TicketModal(reservation: reservation),
    );
  }

  Color get _stateColor {
    return state == 'Completado'
        ? Color(0xFF10B981)
        : Color(0xFFF59E0B);
  }

  String _formatCurrency(double amount) {
    return 'C\$${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final r = reservation;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _showTicketModal(context),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF7C3AED), Color(0xFF6366F1)],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.confirmation_number, color: Colors.white, size: 16),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          r.originDestination,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          children: [
                            Icon(Icons.arrow_forward, size: 10, color: Colors.grey.shade600),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                r.finalDestination,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatCurrency(r.total),
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _stateColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          state,
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            color: _stateColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              
              SizedBox(height: 10),
              
              Row(
                children: [
                  Expanded(
                    child: _buildCompactInfo(
                      icon: Icons.flight_takeoff,
                      text: DateFormatter.formatDateTimeString(r.departureDate),
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.arrow_forward, size: 14, color: Colors.grey.shade400),
                  ),
                  Expanded(
                    child: _buildCompactInfo(
                      icon: Icons.flight_land,
                      text: DateFormatter.formatDateTimeString(r.arrivalDate),
                      color: Color(0xFF14B8A6),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 8),
              
              Wrap(
                spacing: 12,
                runSpacing: 4,
                children: [
                  _buildCompactDetail(Icons.event_seat, '${r.seats.join(", ")}'),
                  _buildCompactDetail(Icons.directions_bus, '${r.model}'),
                  _buildCompactDetail(Icons.person, '${r.driverName}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompactInfo({
    required IconData icon,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactDetail(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 12, color: Color(0xFF6366F1)),
        SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
