import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';
import 'package:flutter_starter_kit/core/theme/sizes.dart';

class AppTextStyles {
  AppTextStyles._();

  /// Headline style with optional customization
  static TextStyle headlineStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    bool italic = false,
    bool underline = false,
    bool strikethrough = false,
  }) => TextStyle(
    fontSize: fontSize ?? AppSizes.fontSizeLarge,
    fontWeight: fontWeight ?? FontWeight.bold,
    color: color ?? AppColors.textPrimaryColor,
    fontStyle: italic ? FontStyle.italic : null,
    decoration: _getDecoration(underline, strikethrough),
  );

  /// Body style with optional customization
  static TextStyle bodyStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    bool italic = false,
    bool underline = false,
    bool strikethrough = false,
  }) => TextStyle(
    fontSize: fontSize ?? AppSizes.fontSizeMedium,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: color ?? AppColors.textPrimaryColor,
    fontStyle: italic ? FontStyle.italic : null,
    decoration: _getDecoration(underline, strikethrough),
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
  }) => baseStyle.copyWith(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    fontStyle: italic ? FontStyle.italic : null,
    decoration: _getDecoration(underline, strikethrough),
  );

  /// Helper method to handle multiple text decorations
  static TextDecoration? _getDecoration(bool underline, bool strikethrough) {
    if (underline && strikethrough) {
      return TextDecoration.combine([
        TextDecoration.underline,
        TextDecoration.lineThrough
      ]);
    }
    if (underline) return TextDecoration.underline;
    if (strikethrough) return TextDecoration.lineThrough;
    return null;
  }
}