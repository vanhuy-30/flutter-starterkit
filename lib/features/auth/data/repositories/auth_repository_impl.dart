import 'package:flutter_starter_kit/core/network/api_service.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/auth_exception.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/auth_response.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/login_request.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/register_request.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // ignore: unused_field
  final ApiService _apiService; // Will be used when implementing real API calls

  AuthRepositoryImpl(this._apiService);

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      return AuthResponse(
        user: UserEntity(
          id: '1',
          name: 'John Doe',
          email: request.username,
          avatarUrl: '',
        ),
        accessToken:
            'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken:
            'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresIn: 3600,
      );
    } catch (e) {
      throw AuthServerException(
        message: 'Login failed. Please check your credentials and try again.',
        code: 'LOGIN_FAILED',
        originalError: e,
      );
    }
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      return AuthResponse(
        user: UserEntity(
          id: 'new_user_${DateTime.now().millisecondsSinceEpoch}',
          name: request.name,
          email: request.email,
          avatarUrl: '',
        ),
        accessToken:
            'mock_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken:
            'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresIn: 3600,
      );
    } catch (e) {
      throw AuthServerException(
        message: 'Registration failed. Please try again.',
        code: 'REGISTER_FAILED',
        originalError: e,
      );
    }
  }

  @override
  Future<AuthResponse> loginWithGoogle() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return AuthResponse(
        user: const UserEntity(
          id: 'google_1',
          name: 'Google User',
          email: 'user@gmail.com',
          avatarUrl: '',
        ),
        accessToken:
            'google_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken:
            'google_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresIn: 3600,
      );
    } catch (e) {
      throw AuthSocialException(
        message: 'Google login failed. Please try again.',
        code: 'GOOGLE_LOGIN_FAILED',
        originalError: e,
      );
    }
  }

  @override
  Future<AuthResponse> loginWithFacebook() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return AuthResponse(
        user: const UserEntity(
          id: 'facebook_1',
          name: 'Facebook User',
          email: 'user@facebook.com',
          avatarUrl: '',
        ),
        accessToken:
            'facebook_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken:
            'facebook_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresIn: 3600,
      );
    } catch (e) {
      throw AuthSocialException(
        message: 'Facebook login failed. Please try again.',
        code: 'FACEBOOK_LOGIN_FAILED',
        originalError: e,
      );
    }
  }

  @override
  Future<AuthResponse> loginWithApple() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return AuthResponse(
        user: const UserEntity(
          id: 'apple_1',
          name: 'Apple User',
          email: 'user@icloud.com',
          avatarUrl: '',
        ),
        accessToken:
            'apple_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken:
            'apple_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresIn: 3600,
      );
    } catch (e) {
      throw AuthSocialException(
        message: 'Apple login failed. Please try again.',
        code: 'APPLE_LOGIN_FAILED',
        originalError: e,
      );
    }
  }

  @override
  Future<AuthResponse> loginWithPhone() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      return AuthResponse(
        user: const UserEntity(
          id: 'phone_1',
          name: 'Phone User',
          email: 'user@phone.com',
          avatarUrl: '',
        ),
        accessToken:
            'phone_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken:
            'phone_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresIn: 3600,
      );
    } catch (e) {
      throw AuthServerException(
        message: 'Phone login failed. Please try again.',
        code: 'PHONE_LOGIN_FAILED',
        originalError: e,
      );
    }
  }

  @override
  Future<AuthResponse> refreshToken(String refreshToken) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return AuthResponse(
        user: const UserEntity(
          id: '1',
          name: 'Refreshed User',
          email: 'user@example.com',
          avatarUrl: '',
        ),
        accessToken:
            'refreshed_access_token_${DateTime.now().millisecondsSinceEpoch}',
        refreshToken:
            'refreshed_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        expiresIn: 3600,
      );
    } catch (e) {
      throw AuthTokenException(
        message: 'Token refresh failed. Please login again.',
        code: 'TOKEN_REFRESH_FAILED',
        originalError: e,
      );
    }
  }

  @override
  Future<void> logout() async {
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      throw AuthServerException(
        message: 'Logout failed. Please try again.',
        code: 'LOGOUT_FAILED',
        originalError: e,
      );
    }
  }
}
