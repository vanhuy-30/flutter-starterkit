import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final double? borderRadius;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isDisabled = false,
    this.color = AppColors.buttonColor,
    this.textColor = AppColors.buttonTextColor,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled ? AppColors.lightBorder : color,
          textStyle: TextStyle(
            color: isDisabled ? AppColors.textSecondaryColor : textColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
          elevation: isDisabled ? 0 : 5,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDisabled ? AppColors.textSecondaryColor : textColor,
          ),
        ),
      ),
    );
  }
}
