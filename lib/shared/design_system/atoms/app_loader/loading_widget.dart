import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/assests/animations.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
  final double size;
  final Color? backgroundColor;
  final String? message;
  final bool showLottie;
  final Color? indicatorColor;

  const LoadingWidget({
    super.key,
    this.size = 100,
    this.backgroundColor,
    this.message,
    this.showLottie = true,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? Colors.black.withAlpha(20),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showLottie)
            Lottie.asset(
              loadingAnimation,
              width: size,
              height: size,
            )
          else
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  indicatorColor ?? AppColors.primaryColor,
                ),
              ),
            ),
          if (message != null) ...[
            const SizedBox(height: 16),
            AppText(
              message!,
              color: AppColors.textSecondaryColor,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
