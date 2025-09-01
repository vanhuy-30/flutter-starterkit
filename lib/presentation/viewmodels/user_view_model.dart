import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/data/models/user/user_model.dart';

class UserViewModel extends ChangeNotifier {
  final HiveService hiveService;

  UserViewModel({required this.hiveService});

  Future<void> addUser(UserModel user) async {
    await hiveService.addUser(user);
    notifyListeners();
  }

  Future<UserModel?> getUser(int id) async {
    return await hiveService.getUserById(id);
  }

  Future<void> deleteUser(int id) async {
    await hiveService.deleteUser(id);
    notifyListeners();
  }
}
