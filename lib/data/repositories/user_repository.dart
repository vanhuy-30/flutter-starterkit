import 'package:flutter_starter_kit/core/network/api_client.dart';
import 'package:flutter_starter_kit/data/models/user/user.dart';

class UserRepository {
  final ApiClient apiClient;

  UserRepository(this.apiClient);

  Future<List<User>> getUsers() async {
    return await apiClient.getUsers();
  }

  Future<User> getUserById(int id) async {
    return await apiClient.getUserById(id);
  }
}
