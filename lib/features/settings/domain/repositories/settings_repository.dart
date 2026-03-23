import 'dart:ui';

abstract class SettingsRepository {
  Future<void> setThemeMode({required bool isDarkMode});
  bool getThemeMode();

  Future<void> setLocale(Locale locale);
  Locale? getLocale();
}
