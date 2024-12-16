import 'package:flutter/material.dart';

/// Enum for badge variants
enum BadgeVariant {
  primary,
  secondary,
  success,
  warning,
  error,
  info
}

/// Utility for badge color and icon management
class BadgeUtils {
  /// Get color based on variant
  static Color getVariantColor(BadgeVariant variant) {
    switch (variant) {
      case BadgeVariant.primary:
        return Colors.blue;
      case BadgeVariant.secondary:
        return Colors.grey;
      case BadgeVariant.success:
        return Colors.green;
      case BadgeVariant.warning:
        return Colors.orange;
      case BadgeVariant.error:
        return Colors.red;
      case BadgeVariant.info:
        return Colors.blueAccent;
    }
  }

  /// Get icon based on variant
  static IconData getStatusIcon(BadgeVariant variant) {
    switch (variant) {
      case BadgeVariant.primary:
        return Icons.info_outline;
      case BadgeVariant.secondary:
        return Icons.more_horiz;
      case BadgeVariant.success:
        return Icons.check_circle_outline;
      case BadgeVariant.warning:
        return Icons.warning_amber_outlined;
      case BadgeVariant.error:
        return Icons.error_outline;
      case BadgeVariant.info:
        return Icons.help_outline;
    }
  }
}