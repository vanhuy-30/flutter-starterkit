import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/domain/models/login_request.dart';
import 'package:flutter_starter_kit/domain/usecases/login_usecase.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  LoginViewModel(this._loginUseCase);

  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> login() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      return;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final request = LoginRequest(
        username: usernameController.text,
        password: passwordController.text,
      );
      await _loginUseCase.execute(request);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginWithGoogle() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _loginUseCase.loginWithGoogle();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginWithFacebook() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _loginUseCase.loginWithFacebook();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginWithApple() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _loginUseCase.loginWithApple();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loginWithPhone() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _loginUseCase.loginWithPhone();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
} 