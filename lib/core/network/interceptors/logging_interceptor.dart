import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("--> ${options.method} ${options.uri}");
    log("Headers: ${options.headers}");
    if (options.data != null) {
      log("Body: ${options.data}");
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("<-- ${response.statusCode} ${response.requestOptions.uri}");
    log("Response: ${response.data}");
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}");
    handler.next(err);
  }
}
