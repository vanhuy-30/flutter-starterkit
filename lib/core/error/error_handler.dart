import 'dart:io';
import 'package:dio/dio.dart';
import 'exceptions.dart';
import 'failures.dart';

/// Utility class to handle errors and convert exceptions to failures
class ErrorHandler {
  /// Convert any exception to appropriate failure
  static Failure handleError(dynamic error) {
    if (error is AppException) {
      return _convertAppExceptionToFailure(error);
    } else if (error is DioException) {
      return _convertDioExceptionToFailure(error);
    } else if (error is SocketException) {
      return const NoInternetFailure();
    } else if (error is FormatException) {
      return ParsingFailure(
        message: 'Lỗi định dạng dữ liệu: ${error.message}',
        code: 'FORMAT_ERROR',
        jsonString: error.source?.toString(),
      );
    } else if (error is TypeError) {
      return ParsingFailure(
        message: 'Lỗi kiểu dữ liệu: ${error.toString()}',
        code: 'TYPE_ERROR',
      );
    } else {
      return UnknownFailure(
        message: 'Lỗi không xác định: ${error.toString()}',
        code: 'UNKNOWN_ERROR',
        data: error,
      );
    }
  }

  /// Convert AppException to corresponding Failure
  static Failure _convertAppExceptionToFailure(AppException exception) {
    switch (exception.runtimeType) {
      case ServerException _:
        final serverEx = exception as ServerException;
        return ServerFailure(
          message: serverEx.message,
          code: serverEx.code,
          statusCode: serverEx.statusCode,
          endpoint: serverEx.endpoint,
          data: serverEx.data,
        );
      case NetworkException _:
        final networkEx = exception as NetworkException;
        return NetworkFailure(
          message: networkEx.message,
          code: networkEx.code,
          endpoint: networkEx.endpoint,
          timeout: networkEx.timeout,
          data: networkEx.data,
        );
      case CacheException _:
        final cacheEx = exception as CacheException;
        return CacheFailure(
          message: cacheEx.message,
          code: cacheEx.code,
          key: cacheEx.key,
          operation: cacheEx.operation,
          data: cacheEx.data,
        );
      case ValidationException _:
        final validationEx = exception as ValidationException;
        return ValidationFailure(
          message: validationEx.message,
          code: validationEx.code,
          fieldErrors: validationEx.fieldErrors,
          data: validationEx.data,
        );
      case AuthenticationException _:
        final authEx = exception as AuthenticationException;
        return AuthenticationFailure(
          message: authEx.message,
          code: authEx.code,
          token: authEx.token,
          refreshToken: authEx.refreshToken,
          data: authEx.data,
        );
      case AuthorizationException _:
        final authzEx = exception as AuthorizationException;
        return AuthorizationFailure(
          message: authzEx.message,
          code: authzEx.code,
          requiredPermission: authzEx.requiredPermission,
          userRole: authzEx.userRole,
          data: authzEx.data,
        );
      case TimeoutException _:
        final timeoutEx = exception as TimeoutException;
        return TimeoutFailure(
          message: timeoutEx.message,
          code: timeoutEx.code,
          timeout: timeoutEx.timeout,
          endpoint: timeoutEx.endpoint,
          data: timeoutEx.data,
        );
      case NotFoundException _:
        final notFoundEx = exception as NotFoundException;
        return NotFoundFailure(
          message: notFoundEx.message,
          code: notFoundEx.code,
          resource: notFoundEx.resource,
          identifier: notFoundEx.identifier,
          data: notFoundEx.data,
        );
      case NoInternetException _:
        return const NoInternetFailure();
      case ParsingException _:
        final parsingEx = exception as ParsingException;
        return ParsingFailure(
          message: parsingEx.message,
          code: parsingEx.code,
          jsonString: parsingEx.jsonString,
          targetType: parsingEx.targetType,
          data: parsingEx.data,
        );
      default:
        return UnknownFailure(
          message: exception.message,
          code: exception.code,
          data: exception.data,
        );
    }
  }

  /// Convert DioException to appropriate Failure
  static Failure _convertDioExceptionToFailure(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutFailure(
          message: 'Yêu cầu hết thời gian chờ',
          code: 'TIMEOUT',
          timeout: dioException.requestOptions.sendTimeout,
          endpoint: dioException.requestOptions.path,
        );
      case DioExceptionType.connectionError:
        return const NoInternetFailure();
      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException);
      case DioExceptionType.cancel:
        return const NetworkFailure(
          message: 'Yêu cầu đã bị hủy',
          code: 'CANCELLED',
        );
      case DioExceptionType.unknown:
      default:
        return NetworkFailure(
          message: 'Lỗi mạng: ${dioException.message}',
          code: 'NETWORK_ERROR',
          endpoint: dioException.requestOptions.path,
        );
    }
  }

  /// Handle bad response from server
  static Failure _handleBadResponse(DioException dioException) {
    final response = dioException.response;
    final statusCode = response?.statusCode ?? 0;
    final data = response?.data;
    final endpoint = dioException.requestOptions.path;

    // Extract error message from response
    String message = 'Lỗi server';
    String? code;
    Map<String, dynamic>? errorData;

    if (data is Map<String, dynamic>) {
      message = data['message'] ?? data['error'] ?? message;
      code = data['code']?.toString();
      errorData = data;
    } else if (data is String) {
      message = data;
    }

    // Handle specific status codes
    switch (statusCode) {
      case 400:
        return ValidationFailure(
          message: message,
          code: code ?? 'VALIDATION_ERROR',
          data: errorData,
        );
      case 401:
        return AuthenticationFailure(
          message: message,
          code: code ?? 'UNAUTHORIZED',
          data: errorData,
        );
      case 403:
        return AuthorizationFailure(
          message: message,
          code: code ?? 'FORBIDDEN',
          data: errorData,
        );
      case 404:
        return NotFoundFailure(
          message: message,
          code: code ?? 'NOT_FOUND',
          resource: endpoint,
          data: errorData,
        );
      case 408:
        return TimeoutFailure(
          message: message,
          code: code ?? 'REQUEST_TIMEOUT',
          endpoint: endpoint,
          data: errorData,
        );
      case 429:
        return RateLimitFailure(
          message: message,
          code: code ?? 'RATE_LIMIT',
          retryAfter: _extractRetryAfter(data),
          data: errorData,
        );
      case 500:
        return ServerFailure(
          message: 'Lỗi server nội bộ',
          code: 'INTERNAL_SERVER_ERROR',
          statusCode: statusCode,
          endpoint: endpoint,
          data: errorData,
        );
      case 502:
      case 503:
      case 504:
        return ServerFailure(
          message: 'Server tạm thời không khả dụng',
          code: 'SERVICE_UNAVAILABLE',
          statusCode: statusCode,
          endpoint: endpoint,
          data: errorData,
        );
      default:
        return ServerFailure(
          message: message,
          code: code ?? 'SERVER_ERROR',
          statusCode: statusCode,
          endpoint: endpoint,
          data: errorData,
        );
    }
  }

  /// Extract retry after value from rate limit response
  static int? _extractRetryAfter(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data['retry_after'] as int?;
    }
    return null;
  }

  /// Get user-friendly error message
  static String getErrorMessage(Failure failure) {
    switch (failure.runtimeType) {
      case NoInternetFailure _:
        return 'Vui lòng kiểm tra kết nối internet của bạn';
      case TimeoutFailure _:
        return 'Yêu cầu hết thời gian chờ. Vui lòng thử lại';
      case ServerFailure _:
        return 'Có lỗi xảy ra từ server. Vui lòng thử lại sau';
      case ValidationFailure _:
        return failure.message;
      case AuthenticationFailure _:
        return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại';
      case AuthorizationFailure _:
        return 'Bạn không có quyền thực hiện hành động này';
      case NotFoundFailure _:
        return 'Không tìm thấy dữ liệu yêu cầu';
      case RateLimitFailure _:
        return 'Bạn đã gửi quá nhiều yêu cầu. Vui lòng chờ một chút';
      default:
        return failure.message;
    }
  }

  /// Check if error is retryable
  static bool isRetryable(Failure failure) {
    switch (failure.runtimeType) {
      case NetworkFailure _:
      case TimeoutFailure _:
      case ServerFailure _:
        return true;
      case NoInternetFailure _:
        return true;
      default:
        return false;
    }
  }
}
