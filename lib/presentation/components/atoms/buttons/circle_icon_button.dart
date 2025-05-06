import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';

class CircleIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final Color? color;
  final Color? iconColor;
  final double? size;

  const CircleIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color = AppColors.buttonColor,
    this.iconColor = AppColors.buttonTextColor,
    this.size = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: icon,
      ),
    );
  }
}
