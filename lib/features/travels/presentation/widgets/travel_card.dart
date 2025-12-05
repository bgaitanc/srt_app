import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/travel_entity.dart';
import '../../domain/entities/reservation_detail_entity.dart';
import '../../domain/repositories/travels_repository.dart';
import '../../../../core/presentation/widgets/buttons/primary_button.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/infrastructure/storage/session_manager.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../reservations/presentation/bloc/reservation_bloc.dart';
import '../../../reservations/presentation/bloc/reservations_event.dart';
import 'seat_selection_modal.dart';

class TravelCard extends StatelessWidget {
  final TravelEntity travel;

  const TravelCard({
    super.key,
    required this.travel,
  });

  String _formatCurrency(double amount) {
    return 'C\$${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 1,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _handleReservation(context),
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
                    child: Icon(Icons.route, color: Colors.white, size: 16),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          travel.originDestination,
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
                                travel.finalDestination,
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
                        _formatCurrency(travel.price),
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF7C3AED),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getStatusColor(travel.status).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          travel.status,
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            color: _getStatusColor(travel.status),
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
                    child: _buildCompactTimeInfo(
                      icon: Icons.flight_takeoff,
                      time: DateFormatter.formatDateTimeString(travel.departureDate),
                      color: Color(0xFF7C3AED),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 6),
                    child: Icon(Icons.arrow_forward, size: 14, color: Colors.grey.shade400),
                  ),
                  Expanded(
                    child: _buildCompactTimeInfo(
                      icon: Icons.flight_land,
                      time: DateFormatter.formatDateTimeString(travel.arrivalDate),
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
                  _buildCompactDetail(Icons.directions_bus, '${travel.model}'),
                  _buildCompactDetail(Icons.person, '${travel.driverName}'),
                  _buildCompactDetail(Icons.event_seat, '${travel.capacity} asientos'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildCompactTimeInfo({
    required IconData icon,
    required String time,
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
              time,
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

  Widget _buildTimeInfo({
    required IconData icon,
    required String label,
    required String time,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              SizedBox(width: 6),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          SizedBox(height: 6),
          Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Color(0xFF6366F1)),
        SizedBox(width: 10),
        Text(
          '$label: ',
          style: GoogleFonts.inter(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'programado':
        return Color(0xFF6366F1);
      case 'en curso':
        return Color(0xFFF59E0B);
      case 'completado':
        return Color(0xFF10B981);
      case 'cancelado':
        return Color(0xFFEF4444);
      default:
        return Colors.grey;
    }
  }

  Future<void> _handleReservation(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      final repository = sl<TravelsRepository>();
      final result = await repository.getReservationDetail(travel.travelId);

      if (context.mounted) {
        Navigator.of(context).pop();
      }

      result.fold(
        (failure) {
          // if 404, use travel data directly
          if (context.mounted) {
            _showSeatSelection(context, ReservationDetailEntity(
              travelId: travel.travelId,
              capacity: travel.capacity,
              reservedSeats: const [],
            ));
          }
        },
        (reservationDetail) async {
          if (context.mounted) {
            _showSeatSelection(context, reservationDetail);
          }
        },
      );
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error inesperado: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _showSeatSelection(BuildContext context, ReservationDetailEntity reservationDetail) async {
    final reservationsBloc = sl<ReservationsBloc>();
    
    final success = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      builder: (context) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: SeatSelectionModal(
          reservationDetail: reservationDetail,
          travel: travel,
          reservationsBloc: reservationsBloc,
        ),
      ),
    );

    if (success == true && context.mounted) {
      final userId = await SessionManager.getUserId();
      if (userId != null) {
        reservationsBloc.add(FetchReservations(userId));
      }
    }
  }
}
