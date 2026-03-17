import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/core/configs/app_config.dart';
import 'package:flutter_starter_kit/core/configs/constants.dart';
import 'package:flutter_starter_kit/core/network/api_service.dart';
import 'package:flutter_starter_kit/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_starter_kit/core/network/interceptors/logging_interceptor.dart';
import 'package:flutter_starter_kit/core/services/secure_storage_service.dart';

/// Dependency Injection providers
/// Core network and infrastructure providers

// Network providers
final dioClientProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: appConfig.baseUrl,
      connectTimeout: AppConstants.requestTimeout,
      receiveTimeout: AppConstants.requestTimeout,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  dio.interceptors.addAll([
    AuthInterceptor(dio),
    LoggingInterceptor(),
  ]);

  return dio;
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioClientProvider);
  return ApiService(dio, baseUrl: appConfig.baseUrl);
});

// Secure storage provider
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});
