import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/network/dio_client.dart';
import 'package:flutter_starter_kit/data/models/user/user.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://api.example.com")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/login")
  Future<String> login(@Body() Map<String, dynamic> body);

  @GET("/users")
  Future<List<User>> getUsers();

  @GET("/users/{id}")
  Future<User> getUserById(@Path("id") int id);
}

final apiClient = ApiClient(DioClient.instance);
