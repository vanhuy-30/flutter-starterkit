import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/core/services/secure_storage_service.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/auth_state.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/login_request.dart';
import 'package:flutter_starter_kit/features/auth/domain/models/register_request.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/auth_repository.dart';

/// Global authentication notifier
/// Manages authentication state across the entire app
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final SecureStorageService _secureStorage;

  AuthNotifier(this._authRepository, this._secureStorage)
      : super(const AuthState()) {
    _initializeAuth();
  }

  /// Initialize authentication state on app start
  Future<void> _initializeAuth() async {
    state = state.copyWith(isLoading: true);

    try {
      // Check if user is already logged in
      final accessToken = await _secureStorage.getAccessToken();
      final refreshToken = await _secureStorage.getRefreshToken();
      final userData = await _secureStorage.getUserData();

      if (accessToken != null && userData != null) {
        // User is already logged in, restore state
        state = state.copyWith(
          isAuthenticated: true,
          accessToken: accessToken,
          refreshToken: refreshToken,
          user: userData,
          isLoading: false,
          isInitialized: true,
        );
      } else {
        // User is not logged in
        state = state.copyWith(
          isAuthenticated: false,
          isLoading: false,
          isInitialized: true,
        );
      }
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to initialize authentication: ${e.toString()}',
        isLoading: false,
        isInitialized: true,
      );
    }
  }

  /// Login with email and password
  Future<void> login(LoginRequest request) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _authRepository.login(request);

      // Save tokens and user data securely
      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);
      await _secureStorage.saveUserData(response.user);

      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Register new user
  Future<void> register(RegisterRequest request) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _authRepository.register(request);

      // Save tokens and user data securely
      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);
      await _secureStorage.saveUserData(response.user);

      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Login with Google
  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _authRepository.loginWithGoogle();

      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);
      await _secureStorage.saveUserData(response.user);

      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Login with Apple
  Future<void> loginWithApple() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _authRepository.loginWithApple();

      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);
      await _secureStorage.saveUserData(response.user);

      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Login with Facebook
  Future<void> loginWithFacebook() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _authRepository.loginWithFacebook();

      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);
      await _secureStorage.saveUserData(response.user);

      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Login with phone number
  Future<void> loginWithPhone() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _authRepository.loginWithPhone();

      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);
      await _secureStorage.saveUserData(response.user);

      state = state.copyWith(
        isAuthenticated: true,
        user: response.user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  /// Logout user
  Future<void> logout() async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // Clear secure storage
      await _secureStorage.clearAll();

      // Reset state
      state = const AuthState(
        isAuthenticated: false,
        isLoading: false,
        isInitialized: true,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to logout: ${e.toString()}',
        isLoading: false,
      );
    }
  }

  /// Refresh access token
  Future<void> refreshToken() async {
    if (state.refreshToken == null) {
      await logout();
      return;
    }

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _authRepository.refreshToken(state.refreshToken!);

      await _secureStorage.saveAccessToken(response.accessToken);
      await _secureStorage.saveRefreshToken(response.refreshToken);

      state = state.copyWith(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        isLoading: false,
      );
    } catch (e) {
      // If refresh fails, logout user
      await logout();
    }
  }

  /// Clear authentication state and secure storage
  /// Useful for debugging or when user wants to start fresh
  Future<void> clearAuthenticationState() async {
    try {
      // Clear secure storage
      await _secureStorage.clearAll();

      // Reset state to initial
      state = const AuthState(
        isAuthenticated: false,
        isLoading: false,
        isInitialized: true,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to clear authentication state: ${e.toString()}',
      );
    }
  }

  /// Clear error message
  void clearError() {
    state = state.copyWith(clearError: true);
  }

  /// Check if user is authenticated
  bool get isAuthenticated => state.isAuthenticated;

  /// Get current user
  UserEntity? get currentUser => state.user;

  /// Get access token
  String? get accessToken => state.accessToken;
}
