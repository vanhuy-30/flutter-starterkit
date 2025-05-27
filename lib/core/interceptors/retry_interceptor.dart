import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../services/retry_service.dart';

class RetryInterceptor extends Interceptor {
  final RetryService _retryService;
  final RetryPolicy _defaultPolicy;

  RetryInterceptor({
    RetryService? retryService,
    RetryPolicy? defaultPolicy,
  })  : _retryService = retryService ?? RetryService(),
        _defaultPolicy = defaultPolicy ?? const RetryPolicy();

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final policy = _getPolicy(err.requestOptions.path);
    if (_shouldRetry(err, policy)) {
      final retryCount = err.requestOptions.extra['retryCount'] ?? 0;
      
      if (retryCount < policy.maxRetries) {
        // Calculate delay with exponential backoff
        final delay = policy.retryDelay * (1 << retryCount);
        
        debugPrint(
          'Retrying request to ${err.requestOptions.path} '
          'after ${delay.inSeconds} seconds. '
          'Retry count: ${retryCount + 1}/${policy.maxRetries}',
        );

        // Wait for delay
        await Future.delayed(delay);

        // Update retry count
        err.requestOptions.extra['retryCount'] = retryCount + 1;

        // Retry request
        try {
          final response = await _retryRequest(err.requestOptions);
          handler.resolve(response);
          return;
        } on DioException catch (e) {
          handler.next(e);
          return;
        }
      }
    }

    handler.next(err);
  }

  RetryPolicy _getPolicy(String path) {
    return _retryService.getPolicy(path) ?? _defaultPolicy;
  }

  bool _shouldRetry(DioException err, RetryPolicy policy) {
    // Check custom retry condition
    if (policy.shouldRetry != null) {
      return policy.shouldRetry!(err);
    }

    // Check status code
    if (err.response?.statusCode != null) {
      return policy.retryStatusCodes.contains(err.response!.statusCode);
    }

    // Check error type
    return err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError;
  }

  Future<Response<dynamic>> _retryRequest(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
      extra: requestOptions.extra,
      validateStatus: requestOptions.validateStatus,
      receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
      followRedirects: requestOptions.followRedirects,
      maxRedirects: requestOptions.maxRedirects,
      responseType: requestOptions.responseType,
      contentType: requestOptions.contentType,
      receiveTimeout: requestOptions.receiveTimeout,
      sendTimeout: requestOptions.sendTimeout,
    );

    return await Dio().request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
} 