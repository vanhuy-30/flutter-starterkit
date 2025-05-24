import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Screen tracking
  Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass,
      );
    } catch (e) {
      debugPrint('Failed to log screen view: $e');
    }
  }

  // User properties
  Future<void> setUserProperties({
    required String userId,
    String? userRole,
    String? userType,
  }) async {
    try {
      await _analytics.setUserId(id: userId);
      if (userRole != null) {
        await _analytics.setUserProperty(name: 'user_role', value: userRole);
      }
      if (userType != null) {
        await _analytics.setUserProperty(name: 'user_type', value: userType);
      }
    } catch (e) {
      debugPrint('Failed to set user properties: $e');
    }
  }

  // Custom events
  Future<void> logEvent({
    required String name,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: name,
        parameters: parameters,
      );
    } catch (e) {
      debugPrint('Failed to log event: $e');
    }
  }

  // Error tracking
  Future<void> logError({
    required String error,
    StackTrace? stackTrace,
    String? errorCode,
    String? errorType,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'app_error',
        parameters: {
          'error': error,
          'stack_trace': stackTrace?.toString() ?? '',
          'error_code': errorCode ?? '',
          'error_type': errorType ?? '',
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      debugPrint('Failed to log error: $e');
    }
  }

  // Performance tracking
  Future<void> logPerformance({
    required String name,
    required int duration,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'performance_metric',
        parameters: {
          'name': name,
          'duration': duration,
          'timestamp': DateTime.now().toIso8601String(),
          ...?parameters,
        },
      );
    } catch (e) {
      debugPrint('Failed to log performance: $e');
    }
  }

  // User engagement
  Future<void> logUserEngagement({
    required String engagementType,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'user_engagement',
        parameters: {
          'engagement_type': engagementType,
          'timestamp': DateTime.now().toIso8601String(),
          ...?parameters,
        },
      );
    } catch (e) {
      debugPrint('Failed to log user engagement: $e');
    }
  }

  // Feature usage
  Future<void> logFeatureUsage({
    required String featureName,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'feature_usage',
        parameters: {
          'feature_name': featureName,
          'timestamp': DateTime.now().toIso8601String(),
          ...?parameters,
        },
      );
    } catch (e) {
      debugPrint('Failed to log feature usage: $e');
    }
  }

  // App lifecycle events
  Future<void> logAppLifecycleEvent(String state) async {
    try {
      await _analytics.logEvent(
        name: 'app_lifecycle',
        parameters: {
          'state': state,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      debugPrint('Failed to log app lifecycle: $e');
    }
  }

  // Network events
  Future<void> logNetworkEvent({
    required String url,
    required String method,
    required int statusCode,
    required int duration,
  }) async {
    try {
      await _analytics.logEvent(
        name: 'network_request',
        parameters: {
          'url': url,
          'method': method,
          'status_code': statusCode,
          'duration': duration,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );
    } catch (e) {
      debugPrint('Failed to log network event: $e');
    }
  }
} 