import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/utils/badge_utils.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeVariant variant;
  final bool showIcon;

  const StatusBadge({
    super.key,
    required this.label,
    this.variant = BadgeVariant.info,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: BadgeUtils.getVariantColor(variant).withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon)
            Icon(
              BadgeUtils.getStatusIcon(variant),
              size: 12,
              color: BadgeUtils.getVariantColor(variant),
            ),
          if (showIcon) const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: BadgeUtils.getVariantColor(variant),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}