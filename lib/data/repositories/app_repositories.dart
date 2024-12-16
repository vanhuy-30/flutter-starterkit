import 'package:flutter_starter_kit/core/services/api_service.dart';
import 'package:flutter_starter_kit/data/models/user/user_model.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({required this.apiService});

  // Future<User> getUserDetails(String userId) async {
  //   final response = await apiService.get('user/$userId');
  //   return User.fromJson(response);
  // }
}
