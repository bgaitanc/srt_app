import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/presentation/widgets/buttons/primary_button.dart';
import '../../domain/entities/reservation_info_entity.dart';
import 'reservation_info_row.dart';

class TicketModal extends StatelessWidget {
  final ReservationInfoEntity reservation;

  const TicketModal({
    super.key,
    required this.reservation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppConstants.modalPadding,
        right: AppConstants.modalPadding,
        top: AppConstants.modalTopPadding,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppConstants.modalTopPadding,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Detalles del ticket',
                style: AppTextStyles.titleLarge(context),
              ),
            ),
            const SizedBox(height: AppConstants.spacingXLarge),
            _buildQRCodeSection(),
            const SizedBox(height: AppConstants.spacingXLarge),
            ..._buildDetailRows(),
            const SizedBox(height: AppConstants.spacingXLarge),
            _buildTotalSection(context),
            const SizedBox(height: AppConstants.spacingXLarge),
            _buildDownloadButton(),
            const SizedBox(height: AppConstants.spacingXLarge),
            _buildBottomIndicator(),
            const SizedBox(height: AppConstants.spacingXLarge),
            _buildCloseButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildQRCodeSection() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppConstants.spacingLarge),
        child: Column(
          children: [
            Container(
              width: AppConstants.qrCodeSize,
              height: AppConstants.qrCodeSize,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
              ),
              child: const Icon(
                Icons.qr_code,
                size: AppConstants.iconSizeLarge,
                color: AppConstants.primaryColor,
              ),
            ),
            const SizedBox(height: AppConstants.spacingMedium),
            Text(
              'Reserva #${reservation.reservationId}',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildDetailRows() {
    return [
      ReservaInfoRow(
        label: 'Asientos',
        value: reservation.seats.join(', '),
        icon: Icons.event_seat,
      ),
      const SizedBox(height: AppConstants.spacingSmall),
      ReservaInfoRow(
        label: 'Origen',
        value: reservation.originDestination,
        icon: Icons.location_on,
      ),
      const SizedBox(height: AppConstants.spacingSmall),
      ReservaInfoRow(
        label: 'Destino',
        value: reservation.finalDestination,
        icon: Icons.flag,
      ),
      const SizedBox(height: AppConstants.spacingSmall),
      ReservaInfoRow(
        label: 'Salida',
        value: reservation.departureDate,
        icon: Icons.calendar_today,
      ),
      const SizedBox(height: AppConstants.spacingSmall),
      ReservaInfoRow(
        label: 'Llegada',
        value: reservation.arrivalDate,
        icon: Icons.calendar_today,
      ),
      const SizedBox(height: AppConstants.spacingSmall),
      ReservaInfoRow(
        label: 'Transporte',
        value: reservation.vehicleType,
        icon: Icons.directions_bus,
      ),
      const SizedBox(height: AppConstants.spacingSmall),
      ReservaInfoRow(
        label: 'Vehículo',
        value: reservation.vehicle,
        icon: Icons.directions_car,
      ),
      const SizedBox(height: AppConstants.spacingSmall),
      ReservaInfoRow(
        label: 'Modelo',
        value: reservation.model,
        icon: Icons.car_repair,
      ),
      const SizedBox(height: AppConstants.spacingSmall),
      ReservaInfoRow(
        label: 'Marca',
        value: reservation.brand,
        icon: Icons.branding_watermark,
      ),
    ];
  }

  Widget _buildTotalSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Pagado',
          style: AppTextStyles.bodyLarge(context).copyWith(
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          reservation.total.toStringAsFixed(2),
          style: AppTextStyles.priceLarge(context),
        ),
      ],
    );
  }

  Widget _buildDownloadButton() {
    return PrimaryButton(
      label: 'Descargar ticket',
      icon: Icons.download,
      isFullWidth: true,
      onPressed: () {},
    );
  }

  Widget _buildBottomIndicator() {
    return Center(
      child: Container(
        width: AppConstants.modalBottomIndicatorWidth,
        height: AppConstants.modalBottomIndicatorHeight,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Center(
      child: PrimaryButton(
        label: 'Cerrar',
        icon: Icons.close,
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
