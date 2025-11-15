import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // App-specific constants
  static const String appName = 'Flutter Starter Kit';
  static const String appVersion = '1.0.0';
  static const Duration requestTimeout = Duration(seconds: 30);

  // Localization constants
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('vi'),
  ];
  static const String translationsPath = 'assets/translations';
  static const Locale fallbackLocale = Locale('en');

  // Storage keys
  static const String themeKey = 'app_theme_mode';
  static const String localeKey = 'app_locale';
  static const String onboardingKey = 'onboarding_completed';
}
