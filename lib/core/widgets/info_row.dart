import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

/// Widget reutilizable para mostrar información con icono
/// Puede ser usado en cualquier feature de la aplicación
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color? iconColor;
  final double? fontSize;
  final double? iconSize;

  const InfoRow({
    super.key,
    required this.icon,
    required this.value,
    this.iconColor,
    this.fontSize,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor ?? AppConstants.primaryColor,
          size: iconSize ?? AppConstants.iconSizeMedium,
        ),
        const SizedBox(width: AppConstants.spacingMedium),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: fontSize ?? 16,
            ),
          ),
        ),
      ],
    );
  }
}

