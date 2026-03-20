import 'package:flutter_starter_kit/core/services/secure_storage_service.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_starter_kit/features/settings/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final AuthRepository _authRepository;
  final SecureStorageService _secureStorageService;

  SessionRepositoryImpl(this._authRepository, this._secureStorageService);

  @override
  Future<void> logout() async {
    await _authRepository.logout();
    await _secureStorageService.clearAll();
  }
}
