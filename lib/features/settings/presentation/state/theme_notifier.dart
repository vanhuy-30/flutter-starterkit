import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';

class ThemeState {
  final bool isDarkMode;
  final bool isLoading;

  const ThemeState({
    required this.isDarkMode,
    this.isLoading = false,
  });

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  ThemeState copyWith({
    bool? isDarkMode,
    bool? isLoading,
  }) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class ThemeNotifier extends StateNotifier<ThemeState> {
  final PreferencesService _preferencesService;

  ThemeNotifier({
    required PreferencesService preferencesService,
  })  : _preferencesService = preferencesService,
        super(ThemeState(
          isDarkMode: preferencesService.getDarkMode(),
        ));

  Future<void> toggleTheme() async {
    state = state.copyWith(isLoading: true);
    final newDarkMode = !state.isDarkMode;
    await _preferencesService.setDarkMode(newDarkMode);
    state = state.copyWith(
      isDarkMode: newDarkMode,
      isLoading: false,
    );
  }

  /// Update theme state from settings flow (already persisted by use case).
  void applyThemeMode(bool isDarkMode) {
    state = state.copyWith(
      isDarkMode: isDarkMode,
      isLoading: false,
    );
  }
}

final themeNotifierProvider =
    StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  final preferencesService = ref.watch(preferencesServiceProvider);

  return ThemeNotifier(
    preferencesService: preferencesService,
  );
});
