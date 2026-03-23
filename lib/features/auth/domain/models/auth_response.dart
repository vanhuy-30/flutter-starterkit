import 'package:flutter_starter_kit/features/auth/domain/entities/user_entity.dart';

/// Response model for authentication operations
class AuthResponse {
  final UserEntity user;
  final String accessToken;
  final String refreshToken;
  final int expiresIn; // Token expiration time in seconds

  const AuthResponse({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  /// Create from JSON response
  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: json['expires_in'] ?? 3600, // Default 1 hour
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'user': user.toJson(),
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'expires_in': expiresIn,
    };
  }

  @override
  String toString() {
    return 'AuthResponse(user: ${user.name}, accessToken: ${accessToken.substring(0, 10)}..., expiresIn: $expiresIn)';
  }
}
