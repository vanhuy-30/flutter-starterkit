import 'package:flutter_starter_kit/domain/models/login_request.dart';

abstract class AuthRepository {
  Future<void> login(LoginRequest request);
  Future<void> loginWithGoogle();
  Future<void> loginWithFacebook();
  Future<void> loginWithApple();
  Future<void> loginWithPhone();
}
