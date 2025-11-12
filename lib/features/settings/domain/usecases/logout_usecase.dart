import 'package:flutter_starter_kit/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Use case for logout functionality
class LogoutUseCase {
  final Ref _ref;

  LogoutUseCase(this._ref);

  /// Logout and clear all storage
  Future<void> call() async {
    final authNotifier = _ref.read(authNotifierProvider.notifier);
    await authNotifier.logout();
  }
}

/// Provider for LogoutUseCase
final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  return LogoutUseCase(ref);
});
