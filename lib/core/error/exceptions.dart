/// Base exception class for all custom exceptions
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic data;

  const AppException({
    required this.message,
    this.code,
    this.data,
  });

  @override
  String toString() => 'AppException: $message';
}

/// Exception thrown when server returns an error
class ServerException extends AppException {
  final int? statusCode;
  final String? endpoint;

  const ServerException({
    required super.message,
    super.code,
    this.statusCode,
    this.endpoint,
    super.data,
  });

  @override
  String toString() =>
      'ServerException: $message (Status: $statusCode, Endpoint: $endpoint)';
}

/// Exception thrown when network request fails
class NetworkException extends AppException {
  final String? endpoint;
  final Duration? timeout;

  const NetworkException({
    required super.message,
    super.code,
    this.endpoint,
    this.timeout,
    super.data,
  });

  @override
  String toString() => 'NetworkException: $message (Endpoint: $endpoint)';
}

/// Exception thrown when cache operations fail
class CacheException extends AppException {
  final String? key;
  final String? operation;

  const CacheException({
    required super.message,
    super.code,
    this.key,
    this.operation,
    super.data,
  });

  @override
  String toString() =>
      'CacheException: $message (Key: $key, Operation: $operation)';
}

/// Exception thrown when data validation fails
class ValidationException extends AppException {
  final Map<String, List<String>>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code,
    this.fieldErrors,
    super.data,
  });

  @override
  String toString() =>
      'ValidationException: $message (Field Errors: $fieldErrors)';
}

/// Exception thrown when authentication fails
class AuthenticationException extends AppException {
  final String? token;
  final String? refreshToken;

  const AuthenticationException({
    required super.message,
    super.code,
    this.token,
    this.refreshToken,
    super.data,
  });

  @override
  String toString() => 'AuthenticationException: $message';
}

/// Exception thrown when authorization fails
class AuthorizationException extends AppException {
  final String? requiredPermission;
  final String? userRole;

  const AuthorizationException({
    required super.message,
    super.code,
    this.requiredPermission,
    this.userRole,
    super.data,
  });

  @override
  String toString() =>
      'AuthorizationException: $message (Required: $requiredPermission, User Role: $userRole)';
}

/// Exception thrown when request times out
class TimeoutException extends AppException {
  final Duration? timeout;
  final String? endpoint;

  const TimeoutException({
    required super.message,
    super.code,
    this.timeout,
    this.endpoint,
    super.data,
  });

  @override
  String toString() =>
      'TimeoutException: $message (Timeout: $timeout, Endpoint: $endpoint)';
}

/// Exception thrown when resource is not found
class NotFoundException extends AppException {
  final String? resource;
  final String? identifier;

  const NotFoundException({
    required super.message,
    super.code,
    this.resource,
    this.identifier,
    super.data,
  });

  @override
  String toString() =>
      'NotFoundException: $message (Resource: $resource, ID: $identifier)';
}

/// Exception thrown when there's no internet connection
class NoInternetException extends AppException {
  const NoInternetException({
    super.message = 'No internet connection',
    super.code,
    super.data,
  });

  @override
  String toString() => 'NoInternetException: $message';
}

/// Exception thrown when parsing JSON fails
class ParsingException extends AppException {
  final String? jsonString;
  final String? targetType;

  const ParsingException({
    required super.message,
    super.code,
    this.jsonString,
    this.targetType,
    super.data,
  });

  @override
  String toString() => 'ParsingException: $message (Target Type: $targetType)';
}
