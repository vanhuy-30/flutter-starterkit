import 'package:flutter_starter_kit/features/settings/domain/repositories/settings_repository.dart';

/// Use case for toggling theme
class ToggleThemeUseCase {
  final SettingsRepository _settingsRepository;

  ToggleThemeUseCase(this._settingsRepository);

  /// Toggle between light and dark theme
  Future<void> call() async {
    final isDarkMode = _settingsRepository.getThemeMode();
    await _settingsRepository.setThemeMode(isDarkMode: !isDarkMode);
  }
}
