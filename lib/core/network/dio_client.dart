import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_starter_kit/core/network/interceptors/logging_interceptor.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://api.example.com",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  )..interceptors.addAll([
      AuthInterceptor(_dio), // Xử lý Token
      LoggingInterceptor(), // Ghi log request/response
    ]);

  static Dio get instance => _dio;
}
