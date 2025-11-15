/// Custom exceptions for authentication operations
class AuthException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  const AuthException({
    required this.message,
    this.code,
    this.originalError,
  });

  @override
  String toString() => 'AuthException: $message';
}

/// Network-related authentication errors
class AuthNetworkException extends AuthException {
  const AuthNetworkException({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Validation-related authentication errors
class AuthValidationException extends AuthException {
  const AuthValidationException({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Server-related authentication errors
class AuthServerException extends AuthException {
  const AuthServerException({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Token-related authentication errors
class AuthTokenException extends AuthException {
  const AuthTokenException({
    required super.message,
    super.code,
    super.originalError,
  });
}

/// Social login related errors
class AuthSocialException extends AuthException {
  const AuthSocialException({
    required super.message,
    super.code,
    super.originalError,
  });
}
