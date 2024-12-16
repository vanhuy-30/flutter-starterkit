import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/utils/badge_utils.dart';

class NotificationBadge extends StatelessWidget {
  final int count;
  final BadgeVariant variant;
  final int maxCount;
  final TextStyle? textStyle;

  const NotificationBadge({
    super.key,
    required this.count,
    this.variant = BadgeVariant.error,
    this.maxCount = 99,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return const SizedBox.shrink();

    final displayCount = count > maxCount ? '$maxCount+' : '$count';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: BadgeUtils.getVariantColor(variant),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        displayCount,
        style: textStyle ?? const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}