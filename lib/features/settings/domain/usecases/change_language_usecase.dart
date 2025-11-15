import 'dart:ui';
import 'package:flutter_starter_kit/features/settings/presentation/providers/settings_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Use case for changing language
class ChangeLanguageUseCase {
  final Ref _ref;

  ChangeLanguageUseCase(this._ref);

  /// Change language to the specified locale
  Future<void> call(Locale locale) async {
    final languageNotifier = _ref.read(languageProvider.notifier);
    await languageNotifier.changeLanguage(locale);
  }
}

/// Provider for ChangeLanguageUseCase
final changeLanguageUseCaseProvider = Provider<ChangeLanguageUseCase>((ref) {
  return ChangeLanguageUseCase(ref);
});
