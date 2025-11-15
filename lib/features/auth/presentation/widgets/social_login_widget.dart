import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/assets/icons.dart';

/// Simple social login widget with Google, Apple, and Facebook buttons
class SocialLoginWidget extends StatelessWidget {
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onAppleSignIn;
  final VoidCallback? onFacebookSignIn;
  final bool isLoading;

  const SocialLoginWidget({
    super.key,
    this.onGoogleSignIn,
    this.onAppleSignIn,
    this.onFacebookSignIn,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Divider with text
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.borderColor)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: AppAutoSizeText(
                'or_continue_with'.tr(),
                color: AppColors.textSecondaryColor,
                maxFontSize: 14,
              ),
            ),
            const Expanded(child: Divider(color: AppColors.borderColor)),
          ],
        ),
        const SizedBox(height: 16),

        // Social buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialButton(
              icon: googleIcon,
              backgroundColor: Colors.white,
              onTap: onGoogleSignIn,
              border: Border.all(color: AppColors.borderColor),
            ),
            const SizedBox(width: 10),
            SocialButton(
              icon: appleIcon,
              iconColor: Colors.white,
              backgroundColor: Colors.black,
              onTap: onAppleSignIn,
            ),
            const SizedBox(width: 10),
            SocialButton(
              icon: facebookIcon,
              iconColor: Colors.white,
              backgroundColor: Colors.blue,
              onTap: onFacebookSignIn,
            ),
          ],
        ),
      ],
    );
  }
}

class SocialButton extends StatelessWidget {
  final String icon;
  final Color backgroundColor;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool isLoading;
  final double? width;
  final double? height;
  final double? iconSize;
  final BoxBorder? border;

  const SocialButton({
    super.key,
    required this.icon,
    required this.backgroundColor,
    this.iconColor,
    this.onTap,
    this.isLoading = false,
    this.width,
    this.height,
    this.iconSize,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? 36,
        height: height ?? 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
          border: border,
        ),
        child: Center(
          child: Image.asset(
            icon,
            width: iconSize ?? 14,
            height: iconSize ?? 14,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
