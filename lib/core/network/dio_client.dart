import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/constants.dart';
import 'package:flutter_starter_kit/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_starter_kit/core/network/interceptors/logging_interceptor.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.apiBaseUrl,
      connectTimeout: AppConstants.requestTimeout,
      receiveTimeout: AppConstants.requestTimeout,
      headers: {
        "Content-Type": "application/json",
      },
    ),
  )..interceptors.addAll([
      AuthInterceptor(_dio),
      LoggingInterceptor(),
    ]);

  static Dio get instance => _dio;
}
