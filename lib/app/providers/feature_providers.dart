import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/providers/core_providers.dart';
import 'package:flutter_starter_kit/core/di/di_providers.dart';
import 'package:flutter_starter_kit/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_starter_kit/features/auth/data/repositories/user_repository_impl.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/auth_state.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/user_repository.dart';
import 'package:flutter_starter_kit/features/auth/domain/usecases/login_usecase.dart';
import 'package:flutter_starter_kit/features/auth/presentation/state/auth_notifier.dart';
import 'package:flutter_starter_kit/features/auth/presentation/state/user_notifier.dart';
import 'package:flutter_starter_kit/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/models/onboarding_state.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/get_onboarding_status_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/domain/usecases/save_interests_usecase.dart';
import 'package:flutter_starter_kit/features/onboarding/presentation/state/onboarding_notifier.dart';
import 'package:flutter_starter_kit/features/settings/data/repositories/session_repository_impl.dart';
import 'package:flutter_starter_kit/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:flutter_starter_kit/features/settings/domain/models/settings_state.dart';
import 'package:flutter_starter_kit/features/settings/domain/repositories/session_repository.dart';
import 'package:flutter_starter_kit/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/change_language_usecase.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/logout_usecase.dart';
import 'package:flutter_starter_kit/features/settings/domain/usecases/toggle_theme_usecase.dart';
import 'package:flutter_starter_kit/features/settings/presentation/state/language_provider.dart';
import 'package:flutter_starter_kit/features/settings/presentation/state/settings_notifier.dart';
import 'package:flutter_starter_kit/features/settings/presentation/state/theme_notifier.dart';

/// Auth feature providers
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRepositoryImpl(apiService);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return LoginUseCase(authRepository);
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return AuthNotifier(authRepository, secureStorage);
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isAuthenticated;
});

final currentUserProvider = Provider<UserEntity?>((ref) {
  return ref.watch(authNotifierProvider).user;
});

final authLoadingProvider = Provider<bool>((ref) {
  return ref.watch(authNotifierProvider).isLoading;
});

final authErrorProvider = Provider<String?>((ref) {
  return ref.watch(authNotifierProvider).error;
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final hiveService = ref.watch(hiveServiceProvider);
  return UserRepositoryImpl(hiveService);
});

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserNotifier(userRepository);
});

/// Onboarding feature providers
final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  final preferencesService = ref.watch(preferencesServiceProvider);
  return OnboardingRepositoryImpl(preferencesService);
});

final getOnboardingStatusUseCaseProvider =
    Provider<GetOnboardingStatusUseCase>((ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return GetOnboardingStatusUseCase(repository);
});

final completeOnboardingUseCaseProvider =
    Provider<CompleteOnboardingUseCase>((ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return CompleteOnboardingUseCase(repository);
});

final saveInterestsUseCaseProvider = Provider<SaveInterestsUseCase>((ref) {
  final repository = ref.watch(onboardingRepositoryProvider);
  return SaveInterestsUseCase(repository);
});

final onboardingNotifierProvider =
    StateNotifierProvider<OnboardingNotifier, OnboardingState>((ref) {
  final getStatusUseCase = ref.watch(getOnboardingStatusUseCaseProvider);
  final completeUseCase = ref.watch(completeOnboardingUseCaseProvider);
  final saveInterestsUseCase = ref.watch(saveInterestsUseCaseProvider);
  return OnboardingNotifier(
    getStatusUseCase,
    completeUseCase,
    saveInterestsUseCase,
  );
});

/// Settings feature providers
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

final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier(
    logoutUseCase: ref.watch(logoutUseCaseProvider),
    changeLanguageUseCase: ref.watch(changeLanguageUseCaseProvider),
    toggleThemeUseCase: ref.watch(toggleThemeUseCaseProvider),
    clearAuthState: () async {
      await ref.read(authNotifierProvider.notifier).clearAuthenticationState();
    },
    getIsDarkMode: () {
      return ref.read(themeNotifierProvider).isDarkMode;
    },
    applyThemeMode: (isDarkMode) {
      ref.read(themeNotifierProvider.notifier).applyThemeMode(isDarkMode);
    },
    applyLocale: (locale) {
      ref.read(languageProvider.notifier).applyLocale(locale);
    },
  );
});
