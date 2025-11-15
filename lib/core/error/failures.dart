import 'package:equatable/equatable.dart';

/// Base failure class for all custom failures
abstract class Failure extends Equatable {
  final String message;
  final String? code;
  final dynamic data;

  const Failure({
    required this.message,
    this.code,
    this.data,
  });

  @override
  List<Object?> get props => [message, code, data];

  @override
  String toString() => 'Failure: $message';
}

/// Failure when server returns an error
class ServerFailure extends Failure {
  final int? statusCode;
  final String? endpoint;

  const ServerFailure({
    required super.message,
    super.code,
    this.statusCode,
    this.endpoint,
    super.data,
  });

  @override
  List<Object?> get props => [message, code, data, statusCode, endpoint];

  @override
  String toString() =>
      'ServerFailure: $message (Status: $statusCode, Endpoint: $endpoint)';
}

/// Failure when network request fails
class NetworkFailure extends Failure {
  final String? endpoint;
  final Duration? timeout;

  const NetworkFailure({
    required super.message,
    super.code,
    this.endpoint,
    this.timeout,
    super.data,
  });

  @override
  List<Object?> get props => [message, code, data, endpoint, timeout];

  @override
  String toString() => 'NetworkFailure: $message (Endpoint: $endpoint)';
}

/// Failure when cache operations fail
class CacheFailure extends Failure {
  final String? key;
  final String? operation;

  const CacheFailure({
    required super.message,
    super.code,
    this.key,
    this.operation,
    super.data,
  });

  @override
  List<Object?> get props => [message, code, data, key, operation];

  @override
  String toString() =>
      'CacheFailure: $message (Key: $key, Operation: $operation)';
}

/// Failure when data validation fails
class ValidationFailure extends Failure {
  final Map<String, List<String>>? fieldErrors;

  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
    super.data,
  });

  @override
  List<Object?> get props => [message, code, data, fieldErrors];

  @override
  String toString() =>
      'ValidationFailure: $message (Field Errors: $fieldErrors)';
}

/// Failure when authentication fails
class AuthenticationFailure extends Failure {
  final String? token;
  final String? refreshToken;

  const AuthenticationFailure({
    required super.message,
    super.code,
    this.token,
    this.refreshToken,
    super.data,
  });

  @override
  List<Object?> get props => [message, code, data, token, refreshToken];

  @override
  String toString() => 'AuthenticationFailure: $message';
}

/// Failure when authorization fails
class AuthorizationFailure extends Failure {
  final String? requiredPermission;
  final String? userRole;

  const AuthorizationFailure({
    required super.message,
    super.code,
    this.requiredPermission,
    this.userRole,
    super.data,
  });

  @override
  List<Object?> get props =>
      [message, code, data, requiredPermission, userRole];

  @override
  String toString() =>
      'AuthorizationFailure: $message (Required: $requiredPermission, User Role: $userRole)';
}

/// Failure when request times out
class TimeoutFailure extends Failure {
  final Duration? timeout;
  final String? endpoint;

  const TimeoutFailure({
    required super.message,
    super.code,
    this.timeout,
    this.endpoint,
    super.data,
  });

  @override
  List<Object?> get props => [message, code, data, timeout, endpoint];

  @override
  String toString() =>
      'TimeoutFailure: $message (Timeout: $timeout, Endpoint: $endpoint)';
}

/// Failure when resource is not found
class NotFoundFailure extends Failure {
  final String? resource;
  final String? identifier;

  const NotFoundFailure({
    required super.message,
    super.code,
    this.resource,
    this.identifier,
    super.data,
  });

  @override
  List<Object?> get props => [message, code, data, resource, identifier];

  @override
  String toString() =>
      'NotFoundFailure: $message (Resource: $resource, ID: $identifier)';
}

/// Failure when there's no internet connection
class NoInternetFailure extends Failure {
  const NoInternetFailure({
    super.message = 'Không có kết nối internet',
    super.code,
    dynamic data,
  });

  @override
  String toString() => 'NoInternetFailure: $message';
}

/// Failure when parsing JSON fails
class ParsingFailure extends Failure {
  final String? jsonString;
  final String? targetType;

  const ParsingFailure({
    required super.message,
    super.code,
    this.jsonString,
    this.targetType,
    super.data,
  });

  @override
  List<Object?> get props => [message, code, data, jsonString, targetType];

  @override
  String toString() => 'ParsingFailure: $message (Target Type: $targetType)';
}

/// Failure for unknown errors
class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Lỗi không xác định',
    super.code,
    super.data,
  });

  @override
  String toString() => 'UnknownFailure: $message';
}

/// Failure for business logic errors
class BusinessLogicFailure extends Failure {
  final String? businessRule;
  final String? context;

  const BusinessLogicFailure({
    required super.message,
    super.code,
    this.businessRule,
    this.context,
    super.data,
  });

  @override
  List<Object?> get props => [message, code, data, businessRule, context];

  @override
  String toString() =>
      'BusinessLogicFailure: $message (Rule: $businessRule, Context: $context)';
}

/// Failure for rate limiting
class RateLimitFailure extends Failure {
  final int? retryAfter;
  final int? limit;
  final int? remaining;

  const RateLimitFailure({
    required super.message,
    super.code,
    this.retryAfter,
    this.limit,
    this.remaining,
    super.data,
  });

  @override
  List<Object?> get props =>
      [message, code, data, retryAfter, limit, remaining];

  @override
  String toString() =>
      'RateLimitFailure: $message (Retry After: $retryAfter, Limit: $limit, Remaining: $remaining)';
}
