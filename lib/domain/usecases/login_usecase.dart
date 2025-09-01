import 'package:flutter_starter_kit/domain/entities/login_request.dart';
import 'package:flutter_starter_kit/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<void> execute(LoginRequest request) async {
    await _authRepository.login(request);
  }

  Future<void> loginWithGoogle() async {
    await _authRepository.loginWithGoogle();
  }

  Future<void> loginWithFacebook() async {
    await _authRepository.loginWithFacebook();
  }

  Future<void> loginWithApple() async {
    await _authRepository.loginWithApple();
  }

  Future<void> loginWithPhone() async {
    await _authRepository.loginWithPhone();
  }
}
