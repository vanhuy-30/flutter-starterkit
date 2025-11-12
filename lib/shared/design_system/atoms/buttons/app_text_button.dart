import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/text_styles.dart';

class AppTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;
  final TextAlign? textAlign;

  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.shape,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding ?? EdgeInsets.zero,
        shape: shape,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: AppTextStyles.normal(color: textColor ?? AppColors.primaryColor),
        textAlign: textAlign ?? TextAlign.start,
      ),
    );
  }
}
