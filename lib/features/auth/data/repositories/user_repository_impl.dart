import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/features/auth/data/mappers/user_mapper.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final HiveService _hiveService;

  UserRepositoryImpl(this._hiveService);

  @override
  Future<void> addUser(UserEntity user) async {
    await _hiveService.addUser(user.toModel());
  }

  @override
  Future<void> deleteUser(String id) async {
    await _hiveService.deleteUser(id);
  }

  @override
  Future<List<UserEntity>> getAllUsers() async {
    final users = _hiveService.getAllUsers();
    return users.map((user) => user.toEntity()).toList();
  }

  @override
  Future<UserEntity?> getUserById(String id) async {
    final user = await _hiveService.getUserById(id);
    return user?.toEntity();
  }
}
