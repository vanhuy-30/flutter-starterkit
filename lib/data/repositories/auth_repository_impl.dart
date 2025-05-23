import 'package:flutter_starter_kit/domain/models/login_request.dart';
import 'package:flutter_starter_kit/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> login(LoginRequest request) async {
    // TODO: Implement login logic
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
  }

  @override
  Future<void> loginWithGoogle() async {
    // TODO: Implement Google login
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> loginWithFacebook() async {
    // TODO: Implement Facebook login
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> loginWithApple() async {
    // TODO: Implement Apple login
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> loginWithPhone() async {
    // TODO: Implement Phone login
    await Future.delayed(const Duration(seconds: 2));
  }
} 