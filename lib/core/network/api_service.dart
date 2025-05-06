import 'package:dio/dio.dart';
import 'package:flutter_starter_kit/core/constants.dart';
import 'package:flutter_starter_kit/data/models/user/user_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: AppConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/users")
  Future<List<UserModel>> getUsers();
}
