import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = "LẤY TOKEN TỪ LOCAL STORAGE";
    options.headers["Authorization"] = "Bearer $token";
      handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String? refreshToken = "LẤY REFRESH TOKEN TỪ LOCAL STORAGE";
      Response response = await dio.post("/refresh", data: {"refresh_token": refreshToken});
      String newToken = response.data["access_token"];
      err.requestOptions.headers["Authorization"] = "Bearer $newToken";
      handler.resolve(await dio.fetch(err.requestOptions)); // Gửi lại request với token mới
    } else {
      handler.next(err);
    }
  }
}
