import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';
import 'package:flutter_starter_kit/core/theme/text_styles.dart';

class AppTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final OutlinedBorder? shape;

  const AppTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.padding,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: padding,
        shape: shape,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: AppTextStyles.headlineStyle(color: textColor ?? AppColors.primaryColor),
      ),
    );
  }
}