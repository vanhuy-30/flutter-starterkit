import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Use case for toggling theme
class ToggleThemeUseCase {
  final Ref _ref;

  ToggleThemeUseCase(this._ref);

  /// Toggle between light and dark theme
  Future<void> call() async {
    final themeNotifier = _ref.read(themeNotifierProvider.notifier);
    await themeNotifier.toggleTheme();
  }
}

/// Provider for ToggleThemeUseCase
final toggleThemeUseCaseProvider = Provider<ToggleThemeUseCase>((ref) {
  return ToggleThemeUseCase(ref);
});
