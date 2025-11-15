import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/utils/badge_utils.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';

class CounterBadge extends StatelessWidget {
  final int value;
  final BadgeVariant variant;
  final bool isZeroVisible;
  final double? width;
  final double? height;
  final double? fontSize;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  const CounterBadge({
    super.key,
    required this.value,
    this.variant = BadgeVariant.error,
    this.isZeroVisible = false,
    this.width,
    this.height,
    this.fontSize,
    this.textColor,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (value == 0 && !isZeroVisible) return const SizedBox.shrink();

    return Container(
      width: width ?? 24,
      height: height ?? 24,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: BadgeUtils.getVariantColor(variant),
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: Center(
        child: AppAutoSizeText(
          '${value > 99 ? '99+' : value}',
          color: textColor ?? Colors.white,
          maxFontSize: fontSize ?? 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
