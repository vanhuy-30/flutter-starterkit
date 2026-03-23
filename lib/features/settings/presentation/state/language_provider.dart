import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_starter_kit/core/services/preferences_service.dart';
import 'package:flutter_starter_kit/core/utils/extensions.dart';
import 'package:flutter_starter_kit/shared/assets/icons.dart';

/// Language model
class LanguageModel {
  final Locale locale;
  final String name;
  final String flagPath;

  const LanguageModel({
    required this.locale,
    required this.name,
    required this.flagPath,
  });
}

/// Language state
class LanguageState {
  final Locale currentLocale;
  final bool isLoading;

  const LanguageState({
    required this.currentLocale,
    this.isLoading = false,
  });

  LanguageState copyWith({
    Locale? currentLocale,
    bool? isLoading,
  }) {
    return LanguageState(
      currentLocale: currentLocale ?? this.currentLocale,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Language notifier
class LanguageNotifier extends StateNotifier<LanguageState> {
  final PreferencesService _preferencesService;

  LanguageNotifier(this._preferencesService)
      : super(
          LanguageState(
            currentLocale:
                _preferencesService.getLocale() ?? const Locale('en'),
          ),
        );

  // Available languages
  static const List<LanguageModel> availableLanguages = [
    LanguageModel(
      locale: Locale('en'),
      name: 'English',
      flagPath: englandFlag,
    ),
    LanguageModel(
      locale: Locale('vi'),
      name: 'Vietnamese',
      flagPath: vietnamFlag,
    ),
  ];

  /// Get current language model
  LanguageModel getCurrentLanguage() {
    return availableLanguages.firstWhere(
      (lang) => lang.locale.languageCode == state.currentLocale.languageCode,
      orElse: () => availableLanguages.first,
    );
  }

  /// Change language
  Future<void> changeLanguage(Locale newLocale) async {
    if (state.currentLocale.languageCode == newLocale.languageCode) return;

    state = state.copyWith(isLoading: true);

    try {
      // Save to preferences
      await _preferencesService.setLocale(newLocale);

      // Update state
      state = state.copyWith(
        currentLocale: newLocale,
        isLoading: false,
      );
    } catch (e) {
      // Handle error
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }

  /// Update locale state from settings flow (already persisted by use case).
  void applyLocale(Locale locale) {
    state = state.copyWith(currentLocale: locale, isLoading: false);
  }

  /// Initialize with device locale
  Future<void> initialize() async {
    final savedLocale = _preferencesService.getLocale();
    if (savedLocale != null) {
      state = state.copyWith(currentLocale: savedLocale);
    } else {
      // Use device locale if supported
      final deviceLocale = PlatformDispatcher.instance.locale;
      final supportedLocale = availableLanguages
          .where(
              (lang) => lang.locale.languageCode == deviceLocale.languageCode)
          .toList()
          .firstOrNull;

      if (supportedLocale != null) {
        await changeLanguage(supportedLocale.locale);
      }
    }
  }
}

/// Language provider
final languageProvider =
    StateNotifierProvider<LanguageNotifier, LanguageState>((ref) {
  final preferencesService = ref.watch(preferencesServiceProvider);
  return LanguageNotifier(preferencesService);
});

/// Current language model provider
final currentLanguageProvider = Provider<LanguageModel>((ref) {
  final languageNotifier = ref.watch(languageProvider.notifier);
  return languageNotifier.getCurrentLanguage();
});

/// Available languages provider
final availableLanguagesProvider = Provider<List<LanguageModel>>((ref) {
  return LanguageNotifier.availableLanguages;
});
