import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/data/models/user/user.dart';

class UserRepository {
  final HiveService _hiveService = HiveService();

  Future<void> addUser(User user) {
    return _hiveService.addUser(user);
  }

  Future<void> deleteUser(String id) {
    return _hiveService.deleteUser(id);
  }

  Future<void> updateUser(User user) {
    return _hiveService.updateUser(user);
  }

  List<User> getAllUsers() {
    return _hiveService.getAllUsers();
  }
}
