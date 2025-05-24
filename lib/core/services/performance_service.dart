import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PerformanceService {
  final FirebasePerformance _performance = FirebasePerformance.instance;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  // Network request tracking
  Future<Trace> startNetworkRequest(String url, String method) async {
    try {
      final trace = _performance.newTrace('network_request');
      await trace.start();
      trace.putAttribute('url', url);
      trace.putAttribute('method', method);
      return trace;
    } catch (e) {
      debugPrint('Failed to start network request trace: $e');
      rethrow;
    }
  }

  // Screen rendering tracking
  Future<Trace> startScreenRender(String screenName) async {
    try {
      final trace = _performance.newTrace('screen_render');
      await trace.start();
      trace.putAttribute('screen_name', screenName);
      return trace;
    } catch (e) {
      debugPrint('Failed to start screen render trace: $e');
      rethrow;
    }
  }

  // Custom trace tracking
  Future<Trace> startCustomTrace(String name) async {
    try {
      final trace = _performance.newTrace(name);
      await trace.start();
      return trace;
    } catch (e) {
      debugPrint('Failed to start custom trace: $e');
      rethrow;
    }
  }

  // Device performance metrics
  Future<Map<String, Object>> getDeviceMetrics() async {
    try {
      final deviceInfo = await _deviceInfo.deviceInfo;
      final packageInfo = await PackageInfo.fromPlatform();
      
      return {
        'device_info': deviceInfo.data,
        'app_version': packageInfo.version,
        'build_number': packageInfo.buildNumber,
        'timestamp': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      debugPrint('Failed to get device metrics: $e');
      rethrow;
    }
  }

  // Memory usage tracking
  Future<void> trackMemoryUsage() async {
    final trace = await startCustomTrace('memory_usage');
    try {
      // Implement memory usage tracking logic here
      // This is platform specific and might require native code
      trace.putAttribute('timestamp', DateTime.now().toIso8601String());
    } catch (e) {
      debugPrint('Failed to track memory usage: $e');
    } finally {
      await trace.stop();
    }
  }

  // Battery usage tracking
  Future<void> trackBatteryUsage() async {
    final trace = await startCustomTrace('battery_usage');
    try {
      // Implement battery usage tracking logic here
      // This is platform specific and might require native code
      trace.putAttribute('timestamp', DateTime.now().toIso8601String());
    } catch (e) {
      debugPrint('Failed to track battery usage: $e');
    } finally {
      await trace.stop();
    }
  }

  // App startup time tracking
  Future<void> trackAppStartup() async {
    final trace = await startCustomTrace('app_startup');
    try {
      // Implement app startup tracking logic here
      trace.putAttribute('timestamp', DateTime.now().toIso8601String());
    } catch (e) {
      debugPrint('Failed to track app startup: $e');
    } finally {
      await trace.stop();
    }
  }

  // Network performance tracking
  Future<void> trackNetworkPerformance(String url, String method) async {
    final trace = await startNetworkRequest(url, method);
    try {
      // Implement network performance tracking logic here
      trace.putAttribute('timestamp', DateTime.now().toIso8601String());
    } catch (e) {
      debugPrint('Failed to track network performance: $e');
    } finally {
      await trace.stop();
    }
  }

  // Database operation tracking
  Future<Trace> startDatabaseOperation(String operation) async {
    try {
      final trace = _performance.newTrace('database_operation');
      await trace.start();
      trace.putAttribute('operation', operation);
      trace.putAttribute('timestamp', DateTime.now().toIso8601String());
      return trace;
    } catch (e) {
      debugPrint('Failed to start database operation trace: $e');
      rethrow;
    }
  }

  // Image loading tracking
  Future<Trace> startImageLoading(String imageUrl) async {
    try {
      final trace = _performance.newTrace('image_loading');
      await trace.start();
      trace.putAttribute('image_url', imageUrl);
      trace.putAttribute('timestamp', DateTime.now().toIso8601String());
      return trace;
    } catch (e) {
      debugPrint('Failed to start image loading trace: $e');
      rethrow;
    }
  }

  // API call tracking
  Future<Trace> startApiCall(String endpoint) async {
    try {
      final trace = _performance.newTrace('api_call');
      await trace.start();
      trace.putAttribute('endpoint', endpoint);
      trace.putAttribute('timestamp', DateTime.now().toIso8601String());
      return trace;
    } catch (e) {
      debugPrint('Failed to start API call trace: $e');
      rethrow;
    }
  }
} 