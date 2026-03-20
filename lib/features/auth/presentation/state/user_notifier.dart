import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/providers/app_providers.dart';
import 'package:flutter_starter_kit/core/services/hive_service.dart';
import 'package:flutter_starter_kit/features/auth/data/models/user_model.dart';

class UserState {
  final List<UserModel> users;
  final bool isLoading;
  final String? error;

  const UserState({
    this.users = const [],
    this.isLoading = false,
    this.error,
  });

  UserState copyWith({
    List<UserModel>? users,
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
  final HiveService _hiveService;

  UserNotifier(this._hiveService) : super(const UserState());

  Future<void> addUser(UserModel user) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _hiveService.addUser(user);
      final updatedUsers = List<UserModel>.from(state.users)..add(user);
      state = state.copyWith(
        users: updatedUsers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<UserModel?> getUser(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _hiveService.getUserById(id);
      state = state.copyWith(isLoading: false);
      return user;
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
      return null;
    }
  }

  Future<void> deleteUser(String id) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _hiveService.deleteUser(id);
      final updatedUsers = state.users.where((user) => user.id != id).toList();
      state = state.copyWith(
        users: updatedUsers,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> loadUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(
        error: e.toString(),
        isLoading: false,
      );
    }
  }
}

final userNotifierProvider =
    StateNotifierProvider<UserNotifier, UserState>((ref) {
  final hiveService = ref.watch(hiveServiceProvider);
  return UserNotifier(hiveService);
});
