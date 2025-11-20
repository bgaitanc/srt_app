import 'package:flutter/material.dart';

class Spacing {
  Spacing._(); 

  // Base spacing values
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // Common edge insets
  static const edgeInsetsXS = EdgeInsets.all(xs);
  static const edgeInsetsSM = EdgeInsets.all(sm);
  static const edgeInsetsMD = EdgeInsets.all(md);
  static const edgeInsetsLG = EdgeInsets.all(lg);
  static const edgeInsetsXL = EdgeInsets.all(xl);

  // Horizontal padding
  static const horizontalSM = EdgeInsets.symmetric(horizontal: sm);
  static const horizontalMD = EdgeInsets.symmetric(horizontal: md);
  static const horizontalLG = EdgeInsets.symmetric(horizontal: lg);

  // Vertical padding
  static const verticalSM = EdgeInsets.symmetric(vertical: sm);
  static const verticalMD = EdgeInsets.symmetric(vertical: md);
  static const verticalLG = EdgeInsets.symmetric(vertical: lg);
}
