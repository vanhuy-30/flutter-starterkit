import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/data/repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository authRepository;

  AuthViewModel({required this.authRepository});

  String? token;

  Future<void> login(String email, String password) async {
    token = await authRepository.login(email, password);
    notifyListeners();
  }
}
