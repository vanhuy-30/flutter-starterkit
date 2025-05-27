import 'package:dio/dio.dart';

class RetryPolicy {
  final int maxRetries;
  final Duration retryDelay;
  final List<int> retryStatusCodes;
  final bool Function(DioException)? shouldRetry;

  const RetryPolicy({
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.retryStatusCodes = const [408, 429, 500, 502, 503, 504],
    this.shouldRetry,
  });

  RetryPolicy copyWith({
    int? maxRetries,
    Duration? retryDelay,
    List<int>? retryStatusCodes,
    bool Function(DioException)? shouldRetry,
  }) {
    return RetryPolicy(
      maxRetries: maxRetries ?? this.maxRetries,
      retryDelay: retryDelay ?? this.retryDelay,
      retryStatusCodes: retryStatusCodes ?? this.retryStatusCodes,
      shouldRetry: shouldRetry ?? this.shouldRetry,
    );
  }
}

class RetryService {
  static final RetryService _instance = RetryService._internal();
  factory RetryService() => _instance;
  RetryService._internal();

  final Map<String, RetryPolicy> _policies = {};
  bool _isInitialized = false;

  // Initialize service
  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;
  }

  // Add retry policy for endpoint
  void addPolicy({
    required String endpoint,
    required RetryPolicy policy,
  }) {
    _policies[endpoint] = policy;
  }

  // Get retry policy for endpoint
  RetryPolicy? getPolicy(String endpoint) {
    // Find matching policy
    for (final entry in _policies.entries) {
      if (endpoint.contains(entry.key)) {
        return entry.value;
      }
    }
    return null;
  }

  // Remove retry policy
  void removePolicy(String endpoint) {
    _policies.remove(endpoint);
  }

  // Clear all policies
  void clearPolicies() {
    _policies.clear();
  }

  // Get all policies
  Map<String, RetryPolicy> getAllPolicies() {
    return Map.unmodifiable(_policies);
  }

  // Check if endpoint has policy
  bool hasPolicy(String endpoint) {
    return getPolicy(endpoint) != null;
  }

  // Get default policy
  RetryPolicy getDefaultPolicy() {
    return const RetryPolicy();
  }

  // Create custom policy
  RetryPolicy createPolicy({
    int? maxRetries,
    Duration? retryDelay,
    List<int>? retryStatusCodes,
    bool Function(DioException)? shouldRetry,
  }) {
    return RetryPolicy(
      maxRetries: maxRetries ?? 3,
      retryDelay: retryDelay ?? const Duration(seconds: 1),
      retryStatusCodes: retryStatusCodes ?? const [408, 429, 500, 502, 503, 504],
      shouldRetry: shouldRetry,
    );
  }
} 