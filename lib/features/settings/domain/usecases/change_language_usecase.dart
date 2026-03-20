import 'dart:ui';
import 'package:flutter_starter_kit/features/settings/domain/repositories/settings_repository.dart';

/// Use case for changing language
class ChangeLanguageUseCase {
  final SettingsRepository _settingsRepository;

  ChangeLanguageUseCase(this._settingsRepository);

  /// Change language to the specified locale
  Future<void> call(Locale locale) async {
    await _settingsRepository.setLocale(locale);
  }
}
