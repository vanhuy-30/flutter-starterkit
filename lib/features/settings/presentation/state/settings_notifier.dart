import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_starter_kit/features/settings/data/repositories/session_repository_impl.dart';
import 'package:flutter_starter_kit/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:flutter_starter_kit/features/settings/domain/models/settings_state.dart';
import 'package:flutter_starter_kit/features/settings/domain/repositories/session_repository.dart';
import 'package:flutter_starter_kit/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/change_language_usecase.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/logout_usecase.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/toggle_theme_usecase.dart';
import 'package:flutter_starter_kit/features/settings/presentation/state/language_provider.dart';

/// Settings Notifier - manages settings feature state
class SettingsNotifier extends StateNotifier<SettingsState> {
  final Ref _ref;
  final LogoutUseCase _logoutUseCase;
  final ChangeLanguageUseCase _changeLanguageUseCase;
  final ToggleThemeUseCase _toggleThemeUseCase;

  SettingsNotifier({
    required Ref ref,
    required LogoutUseCase logoutUseCase,
    required ChangeLanguageUseCase changeLanguageUseCase,
    required ToggleThemeUseCase toggleThemeUseCase,
  })  : _ref = ref,
        _logoutUseCase = logoutUseCase,
        _changeLanguageUseCase = changeLanguageUseCase,
        _toggleThemeUseCase = toggleThemeUseCase,
        super(const SettingsState(isInitialized: true));

  /// Logout user and clear all storage
  Future<void> logout() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _logoutUseCase();
      await _ref.read(authNotifierProvider.notifier).clearAuthenticationState();
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
      _ref.read(languageProvider.notifier).applyLocale(locale);
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
      final isDarkMode = _ref.read(themeNotifierProvider).isDarkMode;
      _ref.read(themeNotifierProvider.notifier).applyThemeMode(!isDarkMode);
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

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final preferencesService = ref.watch(preferencesServiceProvider);
  return SettingsRepositoryImpl(preferencesService);
});

final changeLanguageUseCaseProvider = Provider<ChangeLanguageUseCase>((ref) {
  final settingsRepository = ref.watch(settingsRepositoryProvider);
  return ChangeLanguageUseCase(settingsRepository);
});

final toggleThemeUseCaseProvider = Provider<ToggleThemeUseCase>((ref) {
  final settingsRepository = ref.watch(settingsRepositoryProvider);
  return ToggleThemeUseCase(settingsRepository);
});

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final secureStorageService = ref.watch(secureStorageServiceProvider);
  return SessionRepositoryImpl(authRepository, secureStorageService);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final sessionRepository = ref.watch(sessionRepositoryProvider);
  return LogoutUseCase(sessionRepository);
});

/// Provider for SettingsNotifier
final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier(
    ref: ref,
    logoutUseCase: ref.watch(logoutUseCaseProvider),
    changeLanguageUseCase: ref.watch(changeLanguageUseCaseProvider),
    toggleThemeUseCase: ref.watch(toggleThemeUseCaseProvider),
  );
});
