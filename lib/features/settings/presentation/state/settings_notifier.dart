import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/core/error/error_handler.dart';
import 'package:flutter_starter_kit/features/settings/domain/models/settings_state.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/change_language_usecase.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/toggle_theme_usecase.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/logout_usecase.dart';

/// Settings Notifier - manages settings feature state
class SettingsNotifier extends StateNotifier<SettingsState> {
  final LogoutUseCase _logoutUseCase;
  final ChangeLanguageUseCase _changeLanguageUseCase;
  final ToggleThemeUseCase _toggleThemeUseCase;
  final Future<void> Function() _clearAuthState;
  final bool Function() _getIsDarkMode;
  final void Function(bool isDarkMode) _applyThemeMode;
  final void Function(Locale locale) _applyLocale;

  SettingsNotifier({
    required LogoutUseCase logoutUseCase,
    required ChangeLanguageUseCase changeLanguageUseCase,
    required ToggleThemeUseCase toggleThemeUseCase,
    required Future<void> Function() clearAuthState,
    required bool Function() getIsDarkMode,
    required void Function(bool isDarkMode) applyThemeMode,
    required void Function(Locale locale) applyLocale,
  })  : _logoutUseCase = logoutUseCase,
        _changeLanguageUseCase = changeLanguageUseCase,
        _toggleThemeUseCase = toggleThemeUseCase,
        _clearAuthState = clearAuthState,
        _getIsDarkMode = getIsDarkMode,
        _applyThemeMode = applyThemeMode,
        _applyLocale = applyLocale,
        super(const SettingsState(isInitialized: true));

  String _mapErrorMessage(dynamic error) {
    return ErrorHandler.getMessageFromError(error);
  }

  /// Logout user and clear all storage
  Future<void> logout() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _logoutUseCase();
      await _clearAuthState();
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _mapErrorMessage(e),
      );
      rethrow;
    }
  }

  /// Change language
  Future<void> changeLanguage(Locale locale) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _changeLanguageUseCase(locale);
      _applyLocale(locale);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _mapErrorMessage(e),
      );
      rethrow;
    }
  }

  /// Toggle theme between light and dark
  Future<void> toggleTheme() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _toggleThemeUseCase();
      final isDarkMode = _getIsDarkMode();
      _applyThemeMode(!isDarkMode);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: _mapErrorMessage(e),
      );
      rethrow;
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(clearError: true);
  }
}
