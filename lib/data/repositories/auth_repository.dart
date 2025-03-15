import 'package:flutter_starter_kit/core/network/api_client.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<String> login(String email, String password) async {
    return await apiClient.login({"email": email, "password": password});
  }
}
