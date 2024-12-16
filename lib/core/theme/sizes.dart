import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  // Standard sizes
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
  static const double huge = 64.0;

  // Border radius sizes
  static const BorderRadius borderRadiusSmall = BorderRadius.all(Radius.circular(8.0));
  static const BorderRadius borderRadiusMedium = BorderRadius.all(Radius.circular(16.0));
  static const BorderRadius borderRadiusLarge = BorderRadius.all(Radius.circular(24.0));

  // Icon sizes
  static const double iconSizeSmall = 16.0;
  static const double iconSizeMedium = 24.0;
  static const double iconSizeLarge = 32.0;

  // Padding/Margin sizes
  static const EdgeInsets paddingSmall = EdgeInsets.all(8.0);
  static const EdgeInsets paddingMedium = EdgeInsets.all(16.0);
  static const EdgeInsets paddingLarge = EdgeInsets.all(24.0);

  // Gap sizes
  static const SizedBox gapSmall = SizedBox(height: 8.0);
  static const SizedBox gapMedium = SizedBox(height: 16.0);
  static const SizedBox gapLarge = SizedBox(height: 24.0);
  static const SizedBox gapExtraLarge = SizedBox(height: 32.0);

  // Font sizes
  static const double fontSizeSmall = 12.0;
  static const double fontSizeMedium = 16.0;
  static const double fontSizeLarge = 20.0;
  static const double fontSizeExtraLarge = 24.0;
}
