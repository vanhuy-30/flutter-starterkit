import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/assests/assests.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  final Color? backgroundColor;

  const LoadingWidget({super.key, this.size = 100, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.black.withAlpha(20),
      alignment: Alignment.center,
      child: Lottie.asset(
        loadingAnimation,
        width: size,
        height: size,
      ),
    );
  }
}
