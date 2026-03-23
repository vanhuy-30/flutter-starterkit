import 'package:flutter_starter_kit/features/settings/domain/repositories/session_repository.dart';

/// Use case for logout functionality
class LogoutUseCase {
  final SessionRepository _sessionRepository;

  LogoutUseCase(this._sessionRepository);

  /// Logout and clear all storage
  Future<void> call() async {
    await _sessionRepository.logout();
  }
}
