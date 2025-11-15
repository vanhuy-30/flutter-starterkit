import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

class CircularLoader extends StatelessWidget {
  final Color? color;
  final double? strokeWidth;
  final double? size;

  const CircularLoader({
    super.key,
    this.color,
    this.strokeWidth,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size ?? 40.0,
      height: size ?? 40.0,
      child: CircularProgressIndicator(
        valueColor:
            AlwaysStoppedAnimation<Color>(color ?? AppColors.primaryColor),
        strokeWidth: strokeWidth ?? 4.0,
      ),
    );
  }
}
