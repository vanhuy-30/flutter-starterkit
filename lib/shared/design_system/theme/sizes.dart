import 'package:flutter/material.dart';

class AppSizes {
  AppSizes._();

  // Base spacing
  static const double xs = 4; // extra small
  static const double sm = 8; // small
  static const double md = 16; // medium
  static const double lg = 24; // large
  static const double xl = 32; // extra large
  static const double xxl = 48; // 2x large
  static const double xxxl = 64; // 3x large

  // Border radius
  static const BorderRadius radiusXs = BorderRadius.all(Radius.circular(4));
  static const BorderRadius radiusSm = BorderRadius.all(Radius.circular(8));
  static const BorderRadius radiusMd = BorderRadius.all(Radius.circular(12));
  static const BorderRadius radiusLg = BorderRadius.all(Radius.circular(16));
  static const BorderRadius radiusXl = BorderRadius.all(Radius.circular(24));
  static const BorderRadius radiusXxl = BorderRadius.all(Radius.circular(32));

  // Icon sizes
  static const double iconXs = 12;
  static const double iconSm = 16;
  static const double iconMd = 20;
  static const double iconLg = 24;
  static const double iconXl = 32;
  static const double iconXxl = 48;

  // Button heights
  static const double buttonSm = 32;
  static const double buttonMd = 40;
  static const double buttonLg = 48;
  static const double buttonXl = 56;

  // Input heights
  static const double inputSm = 40;
  static const double inputMd = 48;
  static const double inputLg = 56;

  // Padding (all sides)
  static const EdgeInsets paddingXs = EdgeInsets.all(4);
  static const EdgeInsets paddingSm = EdgeInsets.all(8);
  static const EdgeInsets paddingMd = EdgeInsets.all(16);
  static const EdgeInsets paddingLg = EdgeInsets.all(24);
  static const EdgeInsets paddingXl = EdgeInsets.all(32);

  // Horizontal padding
  static const EdgeInsets paddingXSm = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets paddingXMd = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets paddingXLg = EdgeInsets.symmetric(horizontal: 24);

  // Vertical padding
  static const EdgeInsets paddingYSm = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets paddingYMd = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets paddingYLg = EdgeInsets.symmetric(vertical: 24);

  // gaps
  static const SizedBox gapXs = SizedBox(height: 4);
  static const SizedBox gapSm = SizedBox(height: 8);
  static const SizedBox gapMd = SizedBox(height: 16);
  static const SizedBox gapLg = SizedBox(height: 24);
  static const SizedBox gapXl = SizedBox(height: 32);
  static const SizedBox gapXxl = SizedBox(height: 48);

  // Material Design 3 typography
  static const double displayLarge = 57;
  static const double displayMedium = 45;
  static const double displaySmall = 36;
  static const double headlineLarge = 32;
  static const double headlineMedium = 28;
  static const double headlineSmall = 24;
  static const double titleLarge = 22;
  static const double titleMedium = 16;
  static const double titleSmall = 14;
  static const double bodyLarge = 16;
  static const double bodyMedium = 14;
  static const double bodySmall = 12;
  static const double labelLarge = 14;
  static const double labelMedium = 12;
  static const double labelSmall = 11;

  // Elevation
  static const double elevationNone = 0;
  static const double elevationLow = 1;
  static const double elevationMedium = 3;
  static const double elevationHigh = 6;
  static const double elevationMax = 8;

  // Breakpoints
  static const double mobile = 480;
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double wide = 1440;

  // Component heights
  static const double appBarHeight = 56;
  static const double bottomNavHeight = 60;
  static const double tabBarHeight = 48;

  // Dividers
  static const double divider = 1;
  static const double dividerThick = 2;
}
