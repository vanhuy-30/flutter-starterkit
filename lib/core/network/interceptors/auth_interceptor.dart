import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  late final Dio _refreshDio;

  AuthInterceptor(this.dio) {
    // Create a separate Dio instance for refresh token requests
    _refreshDio = Dio(BaseOptions(
      baseUrl: dio.options.baseUrl,
      connectTimeout: dio.options.connectTimeout,
      receiveTimeout: dio.options.receiveTimeout,
    ));
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final String token = 'get_token_from_storage'.tr();
    options.headers['Authorization'] = 'Bearer $token';
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final String refreshToken = 'get_refresh_token_from_storage'.tr();
        final Response response = await _refreshDio
            .post('/refresh', data: {'refresh_token': refreshToken});
        final String newToken = response.data['access_token'];
        err.requestOptions.headers['Authorization'] = 'Bearer $newToken';
        handler.resolve(await dio.fetch(err.requestOptions));
      } catch (refreshError) {
        // If refresh fails, proceed with the original error
        handler.next(err);
      }
    } else {
      handler.next(err);
    }
  }
}
