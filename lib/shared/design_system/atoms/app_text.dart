import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

/// A standard text widget for consistent usage across the app.
/// Uses Flutter's Text widget with convenient parameters.
class AppText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final TextDecoration? decoration;

  const AppText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines = 2,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: style ??
          TextStyle(
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ?? Colors.black,
            letterSpacing: letterSpacing,
            decoration: decoration,
          ),
    );
  }
}

/// A customizable auto-sizing text widget for flexible layouts.
/// Automatically adjusts the font size based on available space.
class AppAutoSizeText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final double minFontSize;
  final double maxFontSize;
  final TextOverflow overflow;
  final FontWeight? fontWeight;
  final Color? color;
  final double? letterSpacing;
  final TextDecoration? decoration;

  const AppAutoSizeText(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines = 2,
    this.minFontSize = 12,
    this.maxFontSize = 24,
    this.overflow = TextOverflow.ellipsis,
    this.fontWeight,
    this.color,
    this.letterSpacing,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      overflow: overflow,
      style: style ??
          TextStyle(
            fontWeight: fontWeight ?? FontWeight.normal,
            color: color ?? Colors.black,
            letterSpacing: letterSpacing,
            decoration: decoration,
          ),
    );
  }
}
