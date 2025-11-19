import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_constants.dart';

/// Estilos de texto globales compartidos entre todos los features
class AppTextStyles {
  AppTextStyles._();

  // Títulos
  static TextStyle titleLarge(BuildContext context) => GoogleFonts.montserrat(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      );

  static TextStyle titleMedium(BuildContext context) => GoogleFonts.montserrat(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  static TextStyle titleSmall(BuildContext context) => GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      );

  // Texto normal
  static TextStyle bodyLarge(BuildContext context) => GoogleFonts.montserrat(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      );

  static TextStyle bodyMedium(BuildContext context) => GoogleFonts.montserrat(
        fontSize: 15,
      );

  static TextStyle bodySmall(BuildContext context) => GoogleFonts.montserrat(
        fontSize: 13,
      );

  // Texto con color primario
  static TextStyle primaryText(BuildContext context, {double? fontSize}) =>
      GoogleFonts.montserrat(
        fontSize: fontSize ?? 15,
        color: AppConstants.primaryColor,
        fontWeight: FontWeight.w600,
      );

  // Texto secundario/gris
  static TextStyle secondaryText(BuildContext context, {double? fontSize}) =>
      GoogleFonts.montserrat(
        fontSize: fontSize ?? 15,
        color: Colors.grey[600],
      );

  // Texto blanco
  static TextStyle whiteText(
    BuildContext context, {
    double? fontSize,
    FontWeight? fontWeight,
  }) =>
      GoogleFonts.montserrat(
        fontSize: fontSize ?? 14,
        color: Colors.white,
        fontWeight: fontWeight ?? FontWeight.normal,
      );

  // Precio/Total
  static TextStyle priceLarge(BuildContext context) => GoogleFonts.montserrat(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppConstants.primaryColor,
      );

  static TextStyle priceMedium(BuildContext context) => GoogleFonts.montserrat(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: AppConstants.primaryColor,
      );
}

