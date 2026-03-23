import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/core/error/error_handler.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_starter_kit/features/auth/domain/repositories/user_repository.dart';

class UserState {
  final List<UserEntity> users;
  final bool isLoading;
  final String? error;

  const UserState({
    this.users = const [],
    this.isLoading = false,
    this.error,
  });

  UserState copyWith({
    List<UserEntity>? users,
    bool? isLoading,
    String? error,
  }) {
    return UserState(
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class UserNotifier extends StateNotifier<UserState> {
  final UserRepository _userRepository;

  UserNotifier(this._userRepository) : super(const UserState());

  String _mapErrorMessage(dynamic error) {
    return ErrorHandler.getMessageFromError(error);
  }

  Future<void> addUser(UserEntity user) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _userRepository.addUser(user);
      final updatedUsers = List<UserEntity>.from(state.users)..add(user);
      state = state.copyWith(
        users: updatedUsers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: _mapErrorMessage(e),
        isLoading: false,
      );
    }
  }

  Future<UserEntity?> getUser(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _userRepository.getUserById(id);
      state = state.copyWith(isLoading: false);
      return user;
    } catch (e) {
      state = state.copyWith(
        error: _mapErrorMessage(e),
        isLoading: false,
      );
      return null;
    }
  }

  Future<void> deleteUser(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _userRepository.deleteUser(id);
      final updatedUsers = state.users.where((user) => user.id != id).toList();
      state = state.copyWith(
        users: updatedUsers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: _mapErrorMessage(e),
        isLoading: false,
      );
    }
  }

  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final users = await _userRepository.getAllUsers();
      state = state.copyWith(
        users: users,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: _mapErrorMessage(e),
        isLoading: false,
      );
    }
  }
}
