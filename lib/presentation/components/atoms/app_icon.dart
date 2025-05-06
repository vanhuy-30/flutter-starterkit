import 'package:flutter/material.dart';

class AppIcons {
  // Material Icons
  static const IconData home = Icons.home;
  static const IconData profile = Icons.person;
  static const IconData settings = Icons.settings;
  static const IconData notifications = Icons.notifications;
  static const IconData search = Icons.search;
  static const IconData close = Icons.close;
  static const IconData back = Icons.arrow_back;
  static const IconData add = Icons.add;
  static const IconData edit = Icons.edit;
  static const IconData delete = Icons.delete;

}

class AppIcon extends StatelessWidget {
  final dynamic icon;
  final double? size;
  final Color? color;
  final VoidCallback? onTap;
  final BoxFit? fit;

  const AppIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
    this.onTap,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    final defaultSize = size ?? 24;
    final defaultColor = color ?? Theme.of(context).iconTheme.color;

    Widget iconWidget;

    if (icon is IconData) {
      // MaterialIcons
      iconWidget = Icon(
        icon, 
        size: defaultSize, 
        color: defaultColor
      );
    } else if (icon is String) {
      // image asset icon
      iconWidget = Image.asset(
        icon,
        width: defaultSize,
        height: defaultSize,
        color: color,
        fit: fit,
      );
    } else {
      // Fallback
      iconWidget = const SizedBox.shrink();
    }

    return onTap != null 
      ? GestureDetector(
          onTap: onTap,
          child: iconWidget,
        )
      : iconWidget;
  }
}