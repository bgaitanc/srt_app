import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/reservation_detail_entity.dart';
import '../../domain/entities/travel_entity.dart';
import '../../../../core/presentation/widgets/buttons/primary_button.dart';
import '../../../../core/infrastructure/storage/session_manager.dart';
import '../../../reservations/domain/entities/create_reservation_request_entity.dart';
import '../../../reservations/presentation/bloc/reservation_bloc.dart';
import '../../../reservations/presentation/bloc/reservations_event.dart';
import '../../../reservations/presentation/bloc/reservations_state.dart';
import '../../../payments/presentation/pages/card_payment_page.dart';
import '../../../payments/presentation/bloc/payment_bloc.dart';
import '../../../../core/di/injection.dart';

class SeatSelectionModal extends StatefulWidget {
  final ReservationDetailEntity reservationDetail;
  final TravelEntity travel;
  final ReservationsBloc reservationsBloc;

  const SeatSelectionModal({
    super.key,
    required this.reservationDetail,
    required this.travel,
    required this.reservationsBloc,
  });

  @override
  State<SeatSelectionModal> createState() => _SeatSelectionModalState();
}

class _SeatSelectionModalState extends State<SeatSelectionModal> {
  final Set<int> _selectedSeats = {};
  bool _isCreating = false;

  bool _isSeatReserved(int seatNumber) {
    return widget.reservationDetail.reservedSeats.contains(seatNumber);
  }

  bool _isSeatSelected(int seatNumber) {
    return _selectedSeats.contains(seatNumber);
  }

  void _toggleSeat(int seatNumber) {
    if (_isSeatReserved(seatNumber) || _isCreating) return;

    setState(() {
      if (_selectedSeats.contains(seatNumber)) {
        _selectedSeats.remove(seatNumber);
      } else {
        _selectedSeats.add(seatNumber);
      }
    });
  }

  double _calculateTotal() {
    return _selectedSeats.length * widget.travel.price;
  }

  Future<void> _confirmReservation() async {
    if (_selectedSeats.isEmpty || _isCreating) return;

    setState(() {
      _isCreating = true;
    });

    final userId = await SessionManager.getUserId();
    if (userId == null) {
      if (mounted) {
        setState(() {
          _isCreating = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Usuario no autenticado'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    final request = CreateReservationRequestEntity(
      travelId: widget.travel.travelId,
      seats: _selectedSeats.toList()..sort(),
      userId: userId,
    );

    widget.reservationsBloc.add(CreateReservationEvent(request));

    // Listen for the result
    await for (final state in widget.reservationsBloc.stream) {
      if (state is ReservationCreated) {
        if (mounted) {
          final totalAmountMinor = (_calculateTotal() * 100).round();
          final paid = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (_) => sl<PaymentBloc>(),
                child: CardPaymentPage(
                  amountMinorUnits: totalAmountMinor,
                  currency: 'usd',
                  description: 'Reserva viaje ${widget.travel.travelId}',
                  autoPayTest: true,
                ),
              ),
            ),
          );

          if (paid == true) {
            Navigator.of(context).pop(true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  '¡Reserva y pago completados! Asientos: ${request.seats.join(", ")}',
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 3),
              ),
            );
          } else {
            setState(() {
              _isCreating = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Pago cancelado o fallido'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
        break;
      } else if (state is ReservationCreateError) {
        if (mounted) {
          setState(() {
            _isCreating = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al crear reserva: ${state.failure.message}'),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
        }
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTravelInfo(),
                  const SizedBox(height: 24),
                  _buildLegend(),
                  const SizedBox(height: 16),
                  _buildSeatGrid(),
                  const SizedBox(height: 24),
                  _buildSummary(),
                  const SizedBox(height: 16),
                  _buildConfirmButton(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0288D1), Color(0xFF03A9F4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Seleccionar Asientos',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: _isCreating ? null : () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Widget _buildTravelInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Color(0xFF0288D1)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.travel.originDestination,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.flag, size: 16, color: Color(0xFF0288D1)),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.travel.finalDestination,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildLegendItem(Colors.grey.shade300, 'Disponible'),
        _buildLegendItem(Colors.red.shade300, 'Reservado'),
        _buildLegendItem(const Color(0xFF0288D1), 'Seleccionado'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.montserrat(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSeatGrid() {
    final seatsPerRow = 4;
    final rows = (widget.reservationDetail.capacity / seatsPerRow).ceil();

    return Column(
      children: List.generate(rows, (rowIndex) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(seatsPerRow, (colIndex) {
              final seatNumber = rowIndex * seatsPerRow + colIndex + 1;
              if (seatNumber > widget.reservationDetail.capacity) {
                return const SizedBox(width: 60, height: 60);
              }
              return _buildSeat(seatNumber);
            }),
          ),
        );
      }),
    );
  }

  Widget _buildSeat(int seatNumber) {
    final isReserved = _isSeatReserved(seatNumber);
    final isSelected = _isSeatSelected(seatNumber);

    Color backgroundColor;
    if (isReserved) {
      backgroundColor = Colors.red.shade300;
    } else if (isSelected) {
      backgroundColor = const Color(0xFF0288D1);
    } else {
      backgroundColor = Colors.grey.shade300;
    }

    return GestureDetector(
      onTap: () => _toggleSeat(seatNumber),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_seat,
              color: isReserved || isSelected ? Colors.white : Colors.grey.shade700,
              size: 24,
            ),
            const SizedBox(height: 2),
            Text(
              '$seatNumber',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isReserved || isSelected ? Colors.white : Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Asientos seleccionados:',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${_selectedSeats.length}',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0288D1),
                ),
              ),
            ],
          ),
          if (_selectedSeats.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              (_selectedSeats.toList()..sort()).join(', '),
              style: GoogleFonts.montserrat(
                fontSize: 12,
                color: Colors.grey.shade700,
              ),
            ),
          ],
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'C\$${_calculateTotal().toStringAsFixed(2)}',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0288D1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    if (_isCreating) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return PrimaryButton(
      label: 'Confirmar Reserva',
      icon: Icons.check_circle,
      isFullWidth: true,
      onPressed: _selectedSeats.isEmpty ? null : _confirmReservation,
    );
  }
}
