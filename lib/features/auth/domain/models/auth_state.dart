import 'package:flutter_starter_kit/features/auth/data/models/user_model.dart';

/// Global authentication state
/// Manages user authentication status, user data, and tokens
class AuthState {
  final bool isAuthenticated;
  final UserModel? user;
  final String? accessToken;
  final String? refreshToken;
  final bool isLoading;
  final String? error;
  final bool isInitialized;

  const AuthState({
    this.isAuthenticated = false,
    this.user,
    this.accessToken,
    this.refreshToken,
    this.isLoading = false,
    this.error,
    this.isInitialized = false,
  });

  /// Create a copy of this state with updated values
  AuthState copyWith({
    bool? isAuthenticated,
    UserModel? user,
    String? accessToken,
    String? refreshToken,
    bool? isLoading,
    String? error,
    bool? isInitialized,
    bool clearError = false,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  /// Check if user has valid session
  bool get hasValidSession =>
      isAuthenticated && user != null && accessToken != null;

  /// Check if tokens are expired (basic check)
  bool get isTokenExpired {
    if (accessToken == null) return true;
    // TODO: Implement actual token expiration check
    return false;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.isAuthenticated == isAuthenticated &&
        other.user == user &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.isInitialized == isInitialized;
  }

  @override
  int get hashCode =>
      isAuthenticated.hashCode ^
      user.hashCode ^
      accessToken.hashCode ^
      refreshToken.hashCode ^
      isLoading.hashCode ^
      error.hashCode ^
      isInitialized.hashCode;

  @override
  String toString() {
    return 'AuthState(isAuthenticated: $isAuthenticated, user: $user, isLoading: $isLoading, error: $error)';
  }
}
