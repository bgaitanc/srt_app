import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';

class ViajeCard extends StatelessWidget {
  final String imagenUrl;
  final String origen;
  final String destino;
  final String fecha;
  final String tipoTransporte;
  final String precio;
  final VoidCallback? onReservar;

  const ViajeCard({
    super.key,
    required this.imagenUrl,
    required this.origen,
    required this.destino,
    required this.fecha,
    required this.tipoTransporte,
    required this.precio,
    this.onReservar,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onReservar,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: AppConstants.spacingLarge,
          vertical: AppConstants.spacingMedium,
        ),
        height: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusXLarge),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.borderRadiusXLarge),
              child: Image.network(
                imagenUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  child: Icon(Icons.image, size: 60, color: Colors.grey[500]),
                ),
              ),
            ),
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.borderRadiusXLarge),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withValues(alpha: 0.55),
                    Colors.black.withValues(alpha: 0.15),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              left: 18,
              right: 18,
              bottom: 18,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$origen → $destino',
                    style: AppTextStyles.whiteText(
                      context,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppConstants.spacingSmall),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.white70,
                        size: AppConstants.iconSizeSmall,
                      ),
                      const SizedBox(width: AppConstants.spacingSmall),
                      Text(
                        fecha,
                        style: AppTextStyles.whiteText(context, fontSize: 14),
                      ),
                      const SizedBox(width: AppConstants.spacingLarge),
                      Icon(
                        Icons.directions_bus,
                        color: Colors.white70,
                        size: AppConstants.iconSizeSmall,
                      ),
                      const SizedBox(width: AppConstants.spacingSmall),
                      Text(
                        tipoTransporte,
                        style: AppTextStyles.whiteText(context, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(
                            AppConstants.borderRadiusSmall,
                          ),
                        ),
                        child: Text(
                          'Precio: $precio',
                          style: AppTextStyles.priceMedium(context),
                        ),
                      ),
                      const Spacer(),
                      PrimaryButton(
                        label: 'Reservar',
                        onPressed: onReservar ??
                            () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Reserva iniciada (demo)'),
                                ),
                              );
                            },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
