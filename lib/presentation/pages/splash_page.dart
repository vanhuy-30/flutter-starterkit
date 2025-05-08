import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/assests/assests.dart';
import 'package:flutter_starter_kit/core/services/navigation_service.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';

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
    // mock check auth
    // TODO: replace this with real auth check
    final bool isLoggedIn = false;
    if (mounted) {
      if (isLoggedIn) {
        context.nav.toHome(context);
      } else {
        context.nav.toLogin(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Center(
        child: Image.asset(splashLogo, width: 100, height: 100),
      ),
    );
  }
}