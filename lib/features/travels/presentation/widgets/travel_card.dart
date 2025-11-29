import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/travel_entity.dart';
import '../../domain/repositories/travels_repository.dart';
import '../../../../core/presentation/widgets/buttons/primary_button.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/infrastructure/storage/session_manager.dart';
import '../../../reservations/presentation/bloc/reservation_bloc.dart';
import '../../../reservations/presentation/bloc/reservations_event.dart';
import 'seat_selection_modal.dart';

class TravelCard extends StatelessWidget {
  final TravelEntity travel;

  const TravelCard({
    super.key,
    required this.travel,
  });

  String _formatDateTime(String dateTimeStr) {
    try {
      final dateTime = DateTime.parse(dateTimeStr);
      return DateFormat('dd MMM yyyy, HH:mm', 'es').format(dateTime);
    } catch (e) {
      return dateTimeStr;
    }
  }

  String _formatCurrency(double amount) {
    return 'C\$${amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0288D1), Color(0xFF03A9F4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        travel.originDestination,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.arrow_downward, color: Colors.white70, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '${travel.distanceInKm} km',
                      style: GoogleFonts.montserrat(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.flag, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        travel.finalDestination,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(Icons.access_time, 'Salida', _formatDateTime(travel.departureDate)),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.schedule, 'Llegada', _formatDateTime(travel.arrivalDate)),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.directions_bus, 'Vehículo', '${travel.model} (${travel.registrationPlate})'),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.event_seat, 'Capacidad', '${travel.capacity} asientos'),
                const SizedBox(height: 8),
                _buildInfoRow(Icons.person, 'Conductor', '${travel.driverName} ${travel.driverSurname}'),
                const SizedBox(height: 12),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _getStatusColor(travel.status),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        travel.status,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      _formatCurrency(travel.price),
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0288D1),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                PrimaryButton(
                  label: 'Reservar',
                  icon: Icons.bookmark,
                  isFullWidth: true,
                  onPressed: () => _handleReservation(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade600),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: 14,
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
        return Colors.blue;
      case 'en curso':
        return Colors.orange;
      case 'completado':
        return Colors.green;
      case 'cancelado':
        return Colors.red;
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

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error al cargar los asientos: ${failure.message}'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        (reservationDetail) async {
          // Show seat selection modal
          if (context.mounted) {
            // Get ReservasBloc from context (it should be available from HomeScaffold)
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
}
