import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/services/navigation_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    // fake check auth
    // TODO: replace this with real auth check
    final bool isLoggedIn = true;
    if (mounted) {
      if (isLoggedIn) {
        context.nav.toForgotPassword(context);
      } else {
        context.nav.toLogin(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}