import 'package:dio/dio.dart';
import '../services/rate_limiter_service.dart';

class RateLimitInterceptor extends Interceptor {
  final RateLimiterService _rateLimiter;
  final Map<String, String> _endpointKeys;

  RateLimitInterceptor({
    required RateLimiterService rateLimiter,
    Map<String, String>? endpointKeys,
  })  : _rateLimiter = rateLimiter,
        _endpointKeys = endpointKeys ?? {};

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final key = _getEndpointKey(options.path);
    if (key == null) {
      handler.next(options);
      return;
    }

    final isAllowed = await _rateLimiter.isAllowed(key);
    if (!isAllowed) {
      final retryAfter = _rateLimiter.getRetryAfter(key);
      if (retryAfter != null) {
        handler.reject(
          DioException(
            requestOptions: options,
            error: RateLimitException(
              'Rate limit exceeded for endpoint: ${options.path}',
              retryAfter,
            ),
          ),
        );
        return;
      }
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 429) {
      // Handle 429 Too Many Requests
      final retryAfter = err.response?.headers.value('Retry-After');
      if (retryAfter != null) {
        final seconds = int.tryParse(retryAfter) ?? 60;
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            error: RateLimitException(
              'Rate limit exceeded. Server requires retry after $seconds seconds',
              Duration(seconds: seconds),
            ),
          ),
        );
        return;
      }
    }

    handler.next(err);
  }

  String? _getEndpointKey(String path) {
    // Check if path matches any endpoint key
    for (final entry in _endpointKeys.entries) {
      if (path.contains(entry.key)) {
        return entry.value;
      }
    }
    return null;
  }
} 