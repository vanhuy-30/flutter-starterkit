import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/sizes.dart';

class AppTextStyles {
  AppTextStyles._();

  // Default text color - black
  static const Color _defaultTextColor = Colors.black;

  static TextStyle bold({
    double? fontSize,
    Color? color,
    bool italic = false,
    bool underline = false,
    bool strikethrough = false,
  }) =>
      TextStyle(
        fontSize: fontSize ?? AppSizes.bodyLarge,
        fontWeight: FontWeight.bold,
        color: color ?? _defaultTextColor,
        fontStyle: italic ? FontStyle.italic : null,
        decoration: _getDecoration(underline, strikethrough),
      );

  static TextStyle normal({
    double? fontSize,
    Color? color,
    bool italic = false,
    bool underline = false,
    bool strikethrough = false,
  }) =>
      TextStyle(
        fontSize: fontSize ?? AppSizes.bodyMedium,
        fontWeight: FontWeight.normal,
        color: color ?? _defaultTextColor,
        fontStyle: italic ? FontStyle.italic : null,
        decoration: _getDecoration(underline, strikethrough),
      );

  static TextStyle secondary({
    double? fontSize,
    Color? color,
    bool italic = false,
    bool underline = false,
    bool strikethrough = false,
  }) =>
      TextStyle(
        fontSize: fontSize ?? AppSizes.bodySmall,
        fontWeight: FontWeight.normal,
        color: color ?? AppColors.textSecondaryColor,
        fontStyle: italic ? FontStyle.italic : null,
        decoration: _getDecoration(underline, strikethrough),
      );

  /// Large bold text - for main headings
  static TextStyle heading({
    Color? color,
    bool italic = false,
    bool underline = false,
    bool strikethrough = false,
  }) =>
      bold(
        fontSize: AppSizes.headlineMedium,
        color: color,
        italic: italic,
        underline: underline,
        strikethrough: strikethrough,
      );

  /// Extra large bold text - for page titles
  static TextStyle title({
    Color? color,
    bool italic = false,
    bool underline = false,
    bool strikethrough = false,
  }) =>
      bold(
        fontSize: AppSizes.titleMedium,
        color: color,
        italic: italic,
        underline: underline,
        strikethrough: strikethrough,
      );

  /// Small secondary text - for captions and labels
  static TextStyle caption({
    Color? color,
    bool italic = false,
    bool underline = false,
    bool strikethrough = false,
  }) =>
      secondary(
        fontSize: AppSizes.labelMedium,
        color: color,
        italic: italic,
        underline: underline,
        strikethrough: strikethrough,
      );

  /// Utility method to create a custom text style based on existing styles
  static TextStyle customTextStyle({
    required TextStyle baseStyle,
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    bool italic = false,
    bool underline = false,
    bool strikethrough = false,
  }) =>
      baseStyle.copyWith(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontStyle: italic ? FontStyle.italic : null,
        decoration: _getDecoration(underline, strikethrough),
      );

  /// Helper method to handle multiple text decorations
  static TextDecoration? _getDecoration(bool underline, bool strikethrough) {
    if (underline && strikethrough) {
      return TextDecoration.combine(
          [TextDecoration.underline, TextDecoration.lineThrough]);
    }
    if (underline) return TextDecoration.underline;
    if (strikethrough) return TextDecoration.lineThrough;
    return null;
  }
}
