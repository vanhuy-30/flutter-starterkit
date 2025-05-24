import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'dart:async';

class ErrorHandlingService {
  static final ErrorHandlingService _instance =
      ErrorHandlingService._internal();
  factory ErrorHandlingService() => _instance;
  ErrorHandlingService._internal();

  final Logger _logger = Logger();
  final _errorController = StreamController<ErrorEvent>.broadcast();
  final Map<String, int> _errorCounts = {};
  final Map<String, DateTime> _lastErrorTimes = {};
  final Duration _errorResetDuration = const Duration(hours: 1);
  final int _maxErrorsPerHour = 10;

  // Error types
  static const String networkError = 'network_error';
  static const String apiError = 'api_error';
  static const String validationError = 'validation_error';
  static const String authError = 'auth_error';
  static const String databaseError = 'database_error';
  static const String unknownError = 'unknown_error';

  // Stream để lắng nghe lỗi
  Stream<ErrorEvent> get errorStream => _errorController.stream;

  // Xử lý lỗi
  Future<void> handleError(
    dynamic error,
    StackTrace stackTrace, {
    String type = unknownError,
    Map<String, dynamic>? context,
    bool showToUser = true,
  }) async {
    final errorEvent = ErrorEvent(
      error: error,
      stackTrace: stackTrace,
      type: type,
      context: context,
      timestamp: DateTime.now(),
    );

    // Log lỗi
    _logError(errorEvent);

    // Kiểm tra rate limiting
    if (_shouldThrottleError(type)) {
      _logger.w('Error throttled: $type');
      return;
    }

    // Cập nhật error counts
    _updateErrorCounts(type);

    // Thêm vào stream
    _errorController.add(errorEvent);

    // Xử lý lỗi dựa trên type
    await _handleErrorByType(errorEvent);

    // Hiển thị thông báo cho user nếu cần
    if (showToUser) {
      _showErrorToUser(errorEvent);
    }
  }

  // Log lỗi
  void _logError(ErrorEvent event) {
    _logger.e(
      'Error: ${event.error}',
      error: event.error,
      stackTrace: event.stackTrace,
    );
    if (event.context != null) {
      _logger.d('Error context: ${event.context}');
    }
  }

  // Kiểm tra rate limiting
  bool _shouldThrottleError(String type) {
    final now = DateTime.now();
    final lastErrorTime = _lastErrorTimes[type];
    final errorCount = _errorCounts[type] ?? 0;

    if (lastErrorTime != null) {
      if (now.difference(lastErrorTime) > _errorResetDuration) {
        _errorCounts[type] = 0;
        return false;
      }
    }

    return errorCount >= _maxErrorsPerHour;
  }

  // Cập nhật error counts
  void _updateErrorCounts(String type) {
    _errorCounts[type] = (_errorCounts[type] ?? 0) + 1;
    _lastErrorTimes[type] = DateTime.now();
  }

  // Xử lý lỗi theo type
  Future<void> _handleErrorByType(ErrorEvent event) async {
    switch (event.type) {
      case networkError:
        await _handleNetworkError(event);
        break;
      case apiError:
        await _handleApiError(event);
        break;
      case validationError:
        await _handleValidationError(event);
        break;
      case authError:
        await _handleAuthError(event);
        break;
      case databaseError:
        await _handleDatabaseError(event);
        break;
      default:
        await _handleUnknownError(event);
    }
  }

  // Xử lý lỗi mạng
  Future<void> _handleNetworkError(ErrorEvent event) async {
    // Implement network error handling
    debugPrint('Handling network error: ${event.error}');
  }

  // Xử lý lỗi API
  Future<void> _handleApiError(ErrorEvent event) async {
    // Implement API error handling
    debugPrint('Handling API error: ${event.error}');
  }

  // Xử lý lỗi validation
  Future<void> _handleValidationError(ErrorEvent event) async {
    // Implement validation error handling
    debugPrint('Handling validation error: ${event.error}');
  }

  // Xử lý lỗi authentication
  Future<void> _handleAuthError(ErrorEvent event) async {
    // Implement auth error handling
    debugPrint('Handling auth error: ${event.error}');
  }

  // Xử lý lỗi database
  Future<void> _handleDatabaseError(ErrorEvent event) async {
    // Implement database error handling
    debugPrint('Handling database error: ${event.error}');
  }

  // Xử lý lỗi không xác định
  Future<void> _handleUnknownError(ErrorEvent event) async {
    // Implement unknown error handling
    debugPrint('Handling unknown error: ${event.error}');
  }

  // Hiển thị lỗi cho user
  void _showErrorToUser(ErrorEvent event) {
    // Implement user notification
    debugPrint('Showing error to user: ${event.error}');
  }

  // Lấy thống kê lỗi
  Map<String, dynamic> getErrorStats() {
    return {
      'errorCounts': Map<String, int>.from(_errorCounts),
      'lastErrorTimes': Map<String, DateTime>.from(_lastErrorTimes),
    };
  }

  // Reset error counts
  void resetErrorCounts() {
    _errorCounts.clear();
    _lastErrorTimes.clear();
  }

  // Dispose
  void dispose() {
    _errorController.close();
  }
}

class ErrorEvent {
  final dynamic error;
  final StackTrace stackTrace;
  final String type;
  final Map<String, dynamic>? context;
  final DateTime timestamp;

  ErrorEvent({
    required this.error,
    required this.stackTrace,
    required this.type,
    this.context,
    required this.timestamp,
  });
}
