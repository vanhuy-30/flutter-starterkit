import 'package:flutter_starter_kit/features/auth/domain/models/login_request.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/register_request.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<AuthResponse> loginWithGoogle();
  Future<AuthResponse> loginWithFacebook();
  Future<AuthResponse> loginWithApple();
  Future<AuthResponse> loginWithPhone();
  Future<AuthResponse> refreshToken(String refreshToken);
  Future<void> logout();
}
