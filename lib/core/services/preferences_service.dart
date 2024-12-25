// lib/services/preferences_service.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static final PreferencesService _instance = PreferencesService._internal();

  factory PreferencesService() {
    return _instance;
  }

  PreferencesService._internal();

  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Dark Mode management
  Future<void> setDarkMode(bool isDarkMode) async {
    await _preferences?.setBool('darkMode', isDarkMode);
  }

  bool getDarkMode() {
    return _preferences?.getBool('darkMode') ?? false;
  }

  // Locale management
  Future<void> setLocale(Locale locale) async {
    await _preferences?.setString('locale', locale.languageCode);
  }

  Locale? getLocale() {
    String? languageCode = _preferences?.getString('locale');
    if (languageCode != null) {
      return Locale(languageCode);
    }
    return null;
  }
}
