import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/features/settings/domain/models/settings_state.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/logout_usecase.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/change_language_usecase.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/toggle_theme_usecase.dart';

/// Settings Notifier - manages settings feature state
class SettingsNotifier extends StateNotifier<SettingsState> {
  final LogoutUseCase _logoutUseCase;
  final ChangeLanguageUseCase _changeLanguageUseCase;
  final ToggleThemeUseCase _toggleThemeUseCase;

  SettingsNotifier({
    required LogoutUseCase logoutUseCase,
    required ChangeLanguageUseCase changeLanguageUseCase,
    required ToggleThemeUseCase toggleThemeUseCase,
  })  : _logoutUseCase = logoutUseCase,
        _changeLanguageUseCase = changeLanguageUseCase,
        _toggleThemeUseCase = toggleThemeUseCase,
        super(const SettingsState(isInitialized: true));

  /// Logout user and clear all storage
  Future<void> logout() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _logoutUseCase();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to logout: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Change language
  Future<void> changeLanguage(Locale locale) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _changeLanguageUseCase(locale);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to change language: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Toggle theme between light and dark
  Future<void> toggleTheme() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _toggleThemeUseCase();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to toggle theme: ${e.toString()}',
      );
      rethrow;
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

/// Provider for SettingsNotifier
final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier(
    logoutUseCase: ref.watch(logoutUseCaseProvider),
    changeLanguageUseCase: ref.watch(changeLanguageUseCaseProvider),
    toggleThemeUseCase: ref.watch(toggleThemeUseCaseProvider),
  );
});
