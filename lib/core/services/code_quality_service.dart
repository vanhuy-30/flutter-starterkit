import 'package:easy_localization/easy_localization.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


class CodeQualityService {
  static final CodeQualityService _instance = CodeQualityService._internal();
  factory CodeQualityService() => _instance;
  CodeQualityService._internal();

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart
    ),
  );

  final List<Map<String, dynamic>> _logBuffer = [];
  final int _maxBufferSize = 1000;
  bool _isExporting = false;

  // Logging levels
  void logInfo(String message, [dynamic error, StackTrace? stackTrace]) {
    _addToBuffer('INFO', message, error, stackTrace);
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  void logWarning(String message, [dynamic error, StackTrace? stackTrace]) {
    _addToBuffer('WARNING', message, error, stackTrace);
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  void logError(String message, [dynamic error, StackTrace? stackTrace]) {
    _addToBuffer('ERROR', message, error, stackTrace);
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  void logDebug(String message, [dynamic error, StackTrace? stackTrace]) {
    _addToBuffer('DEBUG', message, error, stackTrace);
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  void logVerbose(String message, [dynamic error, StackTrace? stackTrace]) {
    _addToBuffer('VERBOSE', message, error, stackTrace);
    _logger.t(message, error: error, stackTrace: stackTrace);
  }

  void _addToBuffer(String level, String message, [dynamic error, StackTrace? stackTrace]) {
    _logBuffer.add({
      'timestamp': DateTime.now().toIso8601String(),
      'level': level,
      'message': message,
      'error': error?.toString(),
      'stackTrace': stackTrace?.toString(),
    });

    if (_logBuffer.length > _maxBufferSize) {
      _logBuffer.removeAt(0);
    }
  }

  // Performance monitoring
  void logPerformance(String operation, Duration duration) {
    final message = 'Performance: $operation took ${duration.inMilliseconds}ms';
    logInfo(message);
  }

  // Memory usage
  void logMemoryUsage(int bytes) {
    final mb = bytes / (1024 * 1024);
    final message = 'Memory usage: ${mb.toStringAsFixed(2)}MB';
    logInfo(message);
  }

  // Network requests
  void logNetworkRequest(String url, String method, int statusCode, Duration duration) {
    final message = 'Network: $method $url - $statusCode (${duration.inMilliseconds}ms)';
    logInfo(message);
  }

  // Database operations
  void logDatabaseOperation(String operation, Duration duration) {
    final message = 'Database: $operation took ${duration.inMilliseconds}ms';
    logInfo(message);
  }

  // UI rendering
  void logUIRender(String screen, Duration duration) {
    final message = 'UI: $screen rendered in ${duration.inMilliseconds}ms';
    logInfo(message);
  }

  // Error tracking
  void logErrorWithContext(
    String message,
    dynamic error,
    StackTrace stackTrace, {
    Map<String, dynamic>? context,
  }) {
    logError(message, error, stackTrace);
    if (context != null) {
      logDebug('Error context: $context');
    }
  }

  // App lifecycle
  void logAppLifecycle(String state) {
    final message = 'App lifecycle: $state';
    logInfo(message);
  }

  // Feature usage
  void logFeatureUsage(String feature, Map<String, dynamic>? parameters) {
    final message = 'Feature used: $feature';
    logInfo(message, parameters);
  }

  // User actions
  void logUserAction(String action, Map<String, dynamic>? parameters) {
    final message = 'User action: $action';
    logInfo(message, parameters);
  }

  // Cache operations
  void logCacheOperation(String operation, String key, {int? size}) {
    final message = 'Cache: $operation $key${size != null ? ' (${size}bytes)' : ''}';
    logInfo(message);
  }

  // Background tasks
  void logBackgroundTask(String task, Duration duration) {
    final message = 'Background task: $task completed in ${duration.inMilliseconds}ms';
    logInfo(message);
  }

  // API responses
  void logApiResponse(String endpoint, int statusCode, Duration duration) {
    final message = 'API: $endpoint - $statusCode (${duration.inMilliseconds}ms)';
    logInfo(message);
  }

  // File operations
  void logFileOperation(String operation, String path, {int? size}) {
    final message = 'File: $operation $path${size != null ? ' (${size}bytes)' : ''}';
    logInfo(message);
  }

  // Device info
  void logDeviceInfo(Map<String, dynamic> info) {
    final message = 'Device info: $info';
    logInfo(message);
  }

  // App state
  void logAppState(String state, Map<String, dynamic>? data) {
    final message = 'App state: $state';
    logInfo(message, data);
  }

  // Export logs
  Future<String> exportLogs() async {
    if (_isExporting) {
      throw Exception('Log export is already in progress');
    }

    try {
      _isExporting = true;
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final file = File('${directory.path}/logs_$timestamp.txt');

      final buffer = StringBuffer();
      for (final log in _logBuffer) {
        buffer.writeln('${log['timestamp']} [${log['level']}] ${log['message']}');
        if (log['error'] != null) {
          buffer.writeln('Error: ${log['error']}');
        }
        if (log['stackTrace'] != null) {
          buffer.writeln('Stack trace: ${log['stackTrace']}');
        }
        buffer.writeln();
      }

      await file.writeAsString(buffer.toString());
      return file.path;
    } finally {
      _isExporting = false;
    }
  }

  // Clear logs
  void clearLogs() {
    _logBuffer.clear();
  }

  // Get log statistics
  Map<String, int> getLogStatistics() {
    final stats = <String, int>{};
    for (final log in _logBuffer) {
      final level = log['level'] as String;
      stats[level] = (stats[level] ?? 0) + 1;
    }
    return stats;
  }

  // Get recent logs
  List<Map<String, dynamic>> getRecentLogs({int count = 100}) {
    final start = _logBuffer.length - count;
    final end = _logBuffer.length;
    return _logBuffer.sublist(start < 0 ? 0 : start, end);
  }
} 