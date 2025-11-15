import 'dart:async';
import 'package:flutter/foundation.dart';

/// Custom exceptions for rate limiting
class RateLimitException implements Exception {
  final String message;
  final Duration retryAfter;

  RateLimitException(this.message, this.retryAfter);

  @override
  String toString() =>
      'RateLimitException: $message (Retry after: ${retryAfter.inSeconds} seconds)';
}

class RateLimiterService {
  static final RateLimiterService _instance = RateLimiterService._internal();
  factory RateLimiterService() => _instance;
  RateLimiterService._internal();

  final Map<String, _RateLimiter> _limiters = {};
  bool _isInitialized = false;

  // Initialize service
  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;
  }

  // Create a rate limiter for a specific endpoint
  void createLimiter({
    required String key,
    required int maxRequests,
    required Duration timeWindow,
  }) {
    _limiters[key] = _RateLimiter(
      maxRequests: maxRequests,
      timeWindow: timeWindow,
    );
  }

  // Check if request is allowed
  Future<bool> isAllowed(String key) async {
    if (!_isInitialized) await initialize();

    final limiter = _limiters[key];
    if (limiter == null) {
      debugPrint('Warning: No rate limiter found for key: $key');
      return true;
    }

    return limiter.isAllowed();
  }

  // Get retry after duration
  Duration? getRetryAfter(String key) {
    final limiter = _limiters[key];
    return limiter?.getRetryAfter();
  }

  // Reset rate limiter
  void resetLimiter(String key) {
    _limiters[key]?.reset();
  }

  // Clear all rate limiters
  void clearLimiters() {
    _limiters.clear();
  }

  // Get current request count
  int getCurrentCount(String key) {
    return _limiters[key]?.currentCount ?? 0;
  }

  // Get remaining requests
  int getRemainingRequests(String key) {
    final limiter = _limiters[key];
    if (limiter == null) return 0;
    return limiter.maxRequests - limiter.currentCount;
  }
}

class _RateLimiter {
  final int maxRequests;
  final Duration timeWindow;
  int _currentCount = 0;
  DateTime? _windowStart;
  final List<DateTime> _requestTimestamps = [];

  _RateLimiter({
    required this.maxRequests,
    required this.timeWindow,
  });

  int get currentCount => _currentCount;

  bool isAllowed() {
    final now = DateTime.now();

    // Initialize window if not set
    _windowStart ??= now;

    // Clean up old requests
    _cleanupOldRequests(now);

    // Check if we're within the rate limit
    if (_currentCount < maxRequests) {
      _currentCount++;
      _requestTimestamps.add(now);
      return true;
    }

    return false;
  }

  Duration? getRetryAfter() {
    if (_currentCount < maxRequests) return null;

    final now = DateTime.now();
    if (_windowStart == null) return null;

    final timePassed = now.difference(_windowStart!);
    if (timePassed >= timeWindow) return Duration.zero;

    return timeWindow - timePassed;
  }

  void reset() {
    _currentCount = 0;
    _windowStart = null;
    _requestTimestamps.clear();
  }

  void _cleanupOldRequests(DateTime now) {
    if (_windowStart == null) return;

    // Remove requests outside the time window
    _requestTimestamps.removeWhere((timestamp) {
      return now.difference(timestamp) > timeWindow;
    });

    // Update current count
    _currentCount = _requestTimestamps.length;

    // Update window start if needed
    if (_requestTimestamps.isNotEmpty) {
      _windowStart = _requestTimestamps.first;
    } else {
      _windowStart = null;
    }
  }
}
