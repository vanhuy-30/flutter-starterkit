import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/data/models/user/user.dart';

class UserViewModel extends ChangeNotifier {
  final HiveService hiveService;

  UserViewModel({required this.hiveService});

  Future<void> addUser(User user) async {
    await hiveService.addUser(user);
    notifyListeners();
  }

  Future<User?> getUser(int id) async {
    return await hiveService.getUserById(id);
  }

  Future<void> deleteUser(int id) async {
    await hiveService.deleteUser(id);
    notifyListeners();
  }
}
