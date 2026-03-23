import 'package:flutter_starter_kit/features/auth/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> addUser(UserEntity user);
  Future<void> deleteUser(String id);
  Future<UserEntity?> getUserById(String id);
  Future<List<UserEntity>> getAllUsers();
}
