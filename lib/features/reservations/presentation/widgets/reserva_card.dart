import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../domain/entities/reserva_info_entity.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/presentation/widgets/buttons/primary_button.dart';
import 'reserva_info_row.dart';
import 'ticket_modal.dart';

class ReservaCard extends StatefulWidget {
  final String estado;
  final ReservaInfoEntity reserva;

  const ReservaCard({
    super.key,
    required this.estado,
    required this.reserva,
  });

  @override
  State<ReservaCard> createState() => _ReservaCardState();
}

class _ReservaCardState extends State<ReservaCard> {
  bool _expanded = false;

  void _showTicketModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConstants.borderRadiusXLarge),
        ),
      ),
      builder: (context) => TicketModal(reserva: widget.reserva),
    );
  }

  Color get _estadoColor {
    return widget.estado == 'Completado'
        ? AppConstants.successColor
        : AppConstants.warningColor;
  }

  @override
  Widget build(BuildContext context) {
    final r = widget.reserva;

    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: AppConstants.cardMarginVertical,
        horizontal: AppConstants.cardMarginHorizontal,
      ),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusLarge),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.cardPaddingHorizontal,
          vertical: AppConstants.cardPaddingVertical,
        ),
        child: Column(
          children: [
            _buildHeader(r),
            const SizedBox(height: AppConstants.spacingMedium),
            _buildMainInfo(r),
            if (_expanded) _buildExpandedInfo(r),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ReservaInfoEntity r) {
    return Row(
      children: [
        _buildEstadoBadge(),
        const SizedBox(width: 14),
        Flexible(
          child: Text(
            'ID: ${r.reservaId}',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          icon: Icon(
            _expanded ? Icons.expand_less : Icons.expand_more,
            color: AppConstants.primaryColor,
          ),
          onPressed: () => setState(() => _expanded = !_expanded),
        ),
      ],
    );
  }

  Widget _buildEstadoBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.spacingMedium,
        vertical: AppConstants.spacingSmall,
      ),
      decoration: BoxDecoration(
        color: _estadoColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(AppConstants.borderRadiusSmall),
      ),
      child: Text(
        widget.estado,
        style: GoogleFonts.montserrat(
          color: _estadoColor,
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildMainInfo(ReservaInfoEntity r) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${r.origen} → ${r.destino}',
          style: AppTextStyles.bodyLarge(context),
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        ReservaInfoRow(
          label: 'Salida',
          value: r.fechaSalida,
          icon: Icons.calendar_today,
          fontSize: 13,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ReservaInfoRow(
                label: 'Asientos',
                value: r.asientos.join(', '),
                icon: Icons.event_seat,
                fontSize: 13,
              ),
            ),
            const SizedBox(width: AppConstants.spacingXLarge),
            Expanded(
              child: ReservaInfoRow(
                label: 'Precio',
                value: r.total.toStringAsFixed(2),
                icon: Icons.attach_money,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandedInfo(ReservaInfoEntity r) {
    return Padding(
      padding: const EdgeInsets.only(top: AppConstants.spacingLarge),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: ReservaInfoRow(
                  label: 'Salida',
                  value: r.fechaSalida,
                  icon: Icons.calendar_today,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: AppConstants.spacingXLarge),
              Expanded(
                child: ReservaInfoRow(
                  label: 'Llegada',
                  value: r.fechaLlegada,
                  icon: Icons.calendar_today,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.spacingMedium),
          ReservaInfoRow(
            label: 'Transporte',
            value: r.tipoTransporte,
            icon: Icons.directions_bus,
            fontSize: 14,
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          ReservaInfoRow(
            label: 'Vehículo',
            value: r.vehiculo,
            icon: Icons.directions_car,
            fontSize: 14,
          ),
          const SizedBox(height: AppConstants.spacingSmall),
          ReservaInfoRow(
            label: 'Modelo, Marca',
            value: '${r.modelo}, ${r.marca}',
            icon: Icons.info_outline,
            fontSize: 14,
          ),
          const SizedBox(height: AppConstants.spacingLarge),
          Align(
            alignment: Alignment.centerRight,
            child: PrimaryButton(
              label: 'Ver ticket',
              icon: Icons.receipt_long,
              onPressed: _showTicketModal,
            ),
          ),
        ],
      ),
    );
  }
}
