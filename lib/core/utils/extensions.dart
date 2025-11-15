import 'dart:math';
import 'package:flutter/material.dart';

/// String utilities
extension StringExtension on String {
  /// Check if string is empty or whitespace only
  bool get isNullOrEmpty => trim().isEmpty;

  /// Capitalize first letter
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}

/// Nullable string utilities
extension NullableStringExtension on String? {
  /// Check if string is null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Check if string is not null and not empty
  bool get isNotNullOrEmpty => this != null && this!.isNotEmpty;

  /// Return empty string if null
  String orEmpty() => this ?? '';
}

/// BuildContext utilities for UI operations
extension BuildContextExtension on BuildContext {
  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Check if mobile device (< 600px)
  bool get isMobile => screenWidth < 600;

  /// Check if tablet device (600px - 1200px)
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;

  /// Check if desktop device (>= 1200px)
  bool get isDesktop => screenWidth >= 1200;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  bool get isLightMode => Theme.of(this).brightness == Brightness.light;

  /// Show snackbar with message
  void showSnackBar(String message, {Duration? duration}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration ?? const Duration(seconds: 3),
      ),
    );
  }

  /// Hide current keyboard
  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }

  /// Get responsive width based on screen size
  double responsiveWidth(double baseWidth) {
    final screenWidth = this.screenWidth;
    if (screenWidth < 360) {
      return baseWidth * 0.85; // Small phones
    } else if (screenWidth < 414) {
      return baseWidth * 0.95; // Medium phones
    } else if (screenWidth < 768) {
      return baseWidth; // Large phones
    } else if (screenWidth < 1024) {
      return baseWidth * 1.2; // Tablets
    } else {
      return baseWidth * 1.5; // Desktop
    }
  }

  /// Get responsive height based on screen size
  double responsiveHeight(double baseHeight) {
    final screenHeight = this.screenHeight;
    if (screenHeight < 667) {
      return baseHeight * 0.9; // Small screens
    } else if (screenHeight < 812) {
      return baseHeight; // Medium screens
    } else if (screenHeight < 1024) {
      return baseHeight * 1.1; // Large screens
    } else {
      return baseHeight * 1.3; // Very large screens
    }
  }

  /// Get responsive font size based on screen size
  double responsiveFontSize(double baseFontSize) {
    final screenWidth = this.screenWidth;
    if (screenWidth < 360) {
      return baseFontSize * 0.9; // Small phones
    } else if (screenWidth < 414) {
      return baseFontSize * 0.95; // Medium phones
    } else if (screenWidth < 768) {
      return baseFontSize; // Large phones
    } else if (screenWidth < 1024) {
      return baseFontSize * 1.1; // Tablets
    } else {
      return baseFontSize * 1.2; // Desktop
    }
  }

  /// Get responsive padding based on screen size
  EdgeInsets responsivePadding(EdgeInsets basePadding) {
    final screenWidth = this.screenWidth;
    double multiplier = 1;

    if (screenWidth < 360) {
      multiplier = 0.8; // Small phones
    } else if (screenWidth < 414) {
      multiplier = 0.9; // Medium phones
    } else if (screenWidth < 768) {
      multiplier = 1.0; // Large phones
    } else if (screenWidth < 1024) {
      multiplier = 1.2; // Tablets
    } else {
      multiplier = 1.5; // Desktop
    }

    return EdgeInsets.only(
      left: basePadding.left * multiplier,
      top: basePadding.top * multiplier,
      right: basePadding.right * multiplier,
      bottom: basePadding.bottom * multiplier,
    );
  }

  /// Get responsive spacing based on screen size
  double responsiveSpacing(double baseSpacing) {
    final screenWidth = this.screenWidth;
    if (screenWidth < 360) {
      return baseSpacing * 0.8; // Small phones
    } else if (screenWidth < 414) {
      return baseSpacing * 0.9; // Medium phones
    } else if (screenWidth < 768) {
      return baseSpacing; // Large phones
    } else if (screenWidth < 1024) {
      return baseSpacing * 1.2; // Tablets
    } else {
      return baseSpacing * 1.5; // Desktop
    }
  }
}

/// DateTime utilities
extension DateTimeExtension on DateTime {
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Calculate age from birth date
  int get age {
    final now = DateTime.now();
    int age = now.year - year;
    if (now.month < month || (now.month == month && now.day < day)) {
      age--;
    }
    return age;
  }
}

/// Integer utilities
extension IntExtension on int {
  /// Format number with commas (e.g., 1000 -> 1,000)
  String get withCommas {
    return toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
}

/// Double utilities
extension DoubleExtension on double {
  /// Round to specified decimal places
  double roundTo(int places) {
    final mod = pow(10.0, places);
    return (this * mod).round() / mod;
  }
}

/// List utilities
extension ListExtension<T> on List<T> {
  T? get firstOrNull => isEmpty ? null : first;

  T? get lastOrNull => isEmpty ? null : last;

  T? elementAtOrNull(int index) {
    if (index < 0 || index >= length) return null;
    return this[index];
  }

  /// Remove duplicate elements
  List<T> get unique => toSet().toList();
}

/// Map utilities
extension MapExtension<K, V> on Map<K, V> {
  /// Get value or null
  V? getOrNull(K key) => containsKey(key) ? this[key] : null;

  /// Get value or default
  V getOrDefault(K key, V defaultValue) =>
      containsKey(key) ? this[key]! : defaultValue;
}

/// Widget utilities for common styling
extension WidgetExtension on Widget {
  Widget padding(EdgeInsets padding) => Padding(padding: padding, child: this);

  Widget margin(EdgeInsets margin) => Container(margin: margin, child: this);

  Widget backgroundColor(Color color) => Container(color: color, child: this);

  Widget cornerRadius(double radius) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: this);
  }

  /// Dismiss keyboard on tap
  Widget get dismissKeyboard => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: this,
      );
}
