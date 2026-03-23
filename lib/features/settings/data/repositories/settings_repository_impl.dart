import 'dart:ui';

import 'package:flutter_starter_kit/core/services/preferences_service.dart';
import 'package:flutter_starter_kit/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final PreferencesService _preferencesService;

  SettingsRepositoryImpl(this._preferencesService);

  @override
  bool getThemeMode() {
    return _preferencesService.getDarkMode();
  }

  @override
  Locale? getLocale() {
    return _preferencesService.getLocale();
  }

  @override
  Future<void> setLocale(Locale locale) {
    return _preferencesService.setLocale(locale);
  }

  @override
  Future<void> setThemeMode({required bool isDarkMode}) {
    return _preferencesService.setDarkMode(isDarkMode);
  }
}
