import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';
import 'package:flutter_starter_kit/core/theme/sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    cardColor: AppColors.cardColor,
    dividerColor: AppColors.dividerColor,
    hoverColor: AppColors.accentColor,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: AppColors.primaryColor),
      titleLarge: TextStyle(color: AppColors.textPrimaryColor),
      titleSmall: TextStyle(color: AppColors.secondaryColor),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      titleTextStyle: TextStyle(color: AppColors.textPrimaryColor, fontSize: AppSizes.fontSizeLarge),
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.buttonColor,
      textTheme: ButtonTextTheme.primary,
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColors.whiteColor),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    cardColor: AppColors.darkSurface,
    dividerColor: AppColors.dividerColor,
    hoverColor: AppColors.darkAccent,
    fontFamily: GoogleFonts.inter().fontFamily,
    textTheme: const TextTheme(
      labelLarge: TextStyle(color: AppColors.primaryColor),
      titleLarge: TextStyle(color: AppColors.textPrimaryColor),
      titleSmall: TextStyle(color: AppColors.secondaryColor),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkPrimary,
      titleTextStyle: TextStyle(color: AppColors.darkThemeTextColor, fontSize: AppSizes.fontSizeLarge),
      iconTheme: IconThemeData(color: AppColors.primaryColor),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.buttonColor,
      textTheme: ButtonTextTheme.primary,
    ),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: AppColors.whiteColor),
  );
}
