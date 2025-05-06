import 'package:flutter_starter_kit/data/models/user/user_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();

  factory HiveService() {
    return _instance;
  }

  HiveService._internal();

  static const String userBoxName = 'users';

  /// initial Hive
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());

    if (!Hive.isBoxOpen(userBoxName)) {
      await Hive.openBox<UserModel>(userBoxName);
    }
  }

  // Box getters
  Box<UserModel> get userBox => Hive.box<UserModel>(userBoxName);

  // User operations
  Future<void> addUser(UserModel user) async {
    await userBox.put(user.id, user);
  }

  Future<void> deleteUser(int id) async {
    await userBox.delete(id);
  }

  Future<UserModel?> getUserById(int id) async {
    return userBox.get(id);
  }

  List<UserModel> getAllUsers() {
    return userBox.values.toList();
  }

  // clear all hive data
  Future<void> clearAll() async {
    await userBox.clear();
  }

  // close Hive
  Future<void> closeAllBoxes() async {
    await Hive.close();
  }
}
