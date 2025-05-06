import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/data/models/user/user_model.dart';
import '../../core/network/api_service.dart';

class UserRepository {
  final ApiService _apiService;
  final HiveService _hiveService;

  UserRepository(this._apiService, this._hiveService);

  Future<List<UserModel>> fetchUsers() async {
    try {
      List<UserModel> users = await _apiService.getUsers();
      for (var user in users) {
        await _hiveService.addUser(user);
      }
      return users;
    } catch (e) {
      return _hiveService.getAllUsers();
    }
  }

  Future<UserModel?> getUserById(int id) async {
    return _hiveService.getUserById(id);
  }

  Future<void> deleteUser(int id) async {
    await _hiveService.deleteUser(id);
  }

  Future<void> clearAllUsers() async {
    await _hiveService.clearAll();
  }
}
