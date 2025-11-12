import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/configs/app_config.dart';
import 'package:flutter_starter_kit/core/configs/constants.dart';
import 'package:flutter_starter_kit/core/network/interceptors/auth_interceptor.dart';
import 'package:flutter_starter_kit/core/network/interceptors/logging_interceptor.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
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
  }
}
