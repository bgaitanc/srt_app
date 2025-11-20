import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_constants.dart';

class ReservaInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final double? fontSize;

  const ReservaInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            size: fontSize ?? AppConstants.iconSizeMedium,
            color: Colors.black38,
          ),
          const SizedBox(width: AppConstants.spacingSmall),
        ],
        Flexible(
          child: Text(
            '$label:',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: fontSize ?? 15,
            ),
          ),
        ),
        const SizedBox(width: AppConstants.spacingSmall),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.montserrat(
              fontSize: fontSize ?? 15,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

