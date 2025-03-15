import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';

class ThemeViewModel extends ChangeNotifier {
  final PreferencesService _preferencesService;
  late bool _isDarkMode;

  ThemeViewModel({
    required PreferencesService preferencesService,
  }) : _preferencesService = preferencesService {
    _loadInitialTheme();
  }

  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void _loadInitialTheme() {
    _isDarkMode = _preferencesService.getDarkMode();
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _preferencesService.setDarkMode(_isDarkMode);
    notifyListeners();
  }
}