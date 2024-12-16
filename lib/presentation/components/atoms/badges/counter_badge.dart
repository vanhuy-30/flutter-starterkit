import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/utils/badge_utils.dart';

class CounterBadge extends StatelessWidget {
  final int value;
  final BadgeVariant variant;
  final bool isZeroVisible;

  const CounterBadge({
    super.key,
    required this.value,
    this.variant = BadgeVariant.error,
    this.isZeroVisible = false,
  });

  @override
  Widget build(BuildContext context) {
    if (value == 0 && !isZeroVisible) return const SizedBox.shrink();

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: BadgeUtils.getVariantColor(variant),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}