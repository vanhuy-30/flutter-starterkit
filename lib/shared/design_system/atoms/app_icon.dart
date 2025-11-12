import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

class AppIcons {
  // Navigation Icons
  static const IconData home = Icons.home;
  static const IconData homeOutlined = Icons.home_outlined;
  static const IconData profile = Icons.person;
  static const IconData profileOutlined = Icons.person_outline;
  static const IconData settings = Icons.settings;
  static const IconData settingsOutlined = Icons.settings_outlined;
  static const IconData notifications = Icons.notifications;
  static const IconData notificationsOutlined = Icons.notifications_outlined;
  static const IconData search = Icons.search;
  static const IconData searchOutlined = Icons.search_outlined;

  // Action Icons
  static const IconData add = Icons.add;
  static const IconData addCircle = Icons.add_circle;
  static const IconData edit = Icons.edit;
  static const IconData editOutlined = Icons.edit_outlined;
  static const IconData delete = Icons.delete;
  static const IconData deleteOutlined = Icons.delete_outline;
  static const IconData close = Icons.close;
  static const IconData back = Icons.arrow_back;
  static const IconData forward = Icons.arrow_forward;
  static const IconData forwardIos = Icons.arrow_forward_ios;
  static const IconData check = Icons.check;
  static const IconData checkCircle = Icons.check_circle;
  static const IconData checkCircleOutlined = Icons.check_circle_outline;
  static const IconData cancel = Icons.cancel;
  static const IconData clear = Icons.clear;

  // Status Icons
  static const IconData info = Icons.info;
  static const IconData infoOutlined = Icons.info_outline;
  static const IconData warning = Icons.warning;
  static const IconData warningOutlined = Icons.warning_amber_outlined;
  static const IconData error = Icons.error;
  static const IconData errorOutlined = Icons.error_outline;
  static const IconData success = Icons.check_circle;
  static const IconData successOutlined = Icons.check_circle_outline;

  // Communication Icons
  static const IconData email = Icons.email;
  static const IconData emailOutlined = Icons.email_outlined;
  static const IconData phone = Icons.phone;
  static const IconData phoneOutlined = Icons.phone_outlined;
  static const IconData message = Icons.message;
  static const IconData messageOutlined = Icons.message_outlined;

  // UI Icons
  static const IconData menu = Icons.menu;
  static const IconData moreVert = Icons.more_vert;
  static const IconData moreHoriz = Icons.more_horiz;
  static const IconData filter = Icons.filter_list;
  static const IconData tune = Icons.tune;
  static const IconData refresh = Icons.refresh;
  static const IconData refreshOutlined = Icons.refresh_outlined;
  static const IconData visibility = Icons.visibility;
  static const IconData visibilityOff = Icons.visibility_off;
  static const IconData lock = Icons.lock;
  static const IconData lockOutlined = Icons.lock_outline;
  static const IconData lockOpen = Icons.lock_open;
  static const IconData lockOpenOutlined = Icons.lock_open_outlined;

  // Media Icons
  static const IconData play = Icons.play_arrow;
  static const IconData pause = Icons.pause;
  static const IconData stop = Icons.stop;
  static const IconData volumeUp = Icons.volume_up;
  static const IconData volumeOff = Icons.volume_off;
  static const IconData image = Icons.image;
  static const IconData imageOutlined = Icons.image_outlined;
  static const IconData camera = Icons.camera_alt;
  static const IconData cameraOutlined = Icons.camera_alt_outlined;

  // Time Icons
  static const IconData time = Icons.access_time;
  static const IconData timeOutlined = Icons.access_time_outlined;
  static const IconData date = Icons.calendar_today;
  static const IconData dateOutlined = Icons.calendar_today_outlined;
  static const IconData history = Icons.history;

  // Other Icons
  static const IconData star = Icons.star;
  static const IconData starOutlined = Icons.star_outline;
  static const IconData starHalf = Icons.star_half;
  static const IconData favorite = Icons.favorite;
  static const IconData favoriteOutlined = Icons.favorite_outline;
  static const IconData favoriteBorder = Icons.favorite_border;
  static const IconData share = Icons.share;
  static const IconData shareOutlined = Icons.share_outlined;
  static const IconData download = Icons.download;
  static const IconData downloadOutlined = Icons.download_outlined;
  static const IconData upload = Icons.upload;
  static const IconData uploadOutlined = Icons.upload_outlined;

  // Additional Icons
  static const IconData logout = Icons.logout;
  static const IconData help = Icons.help;
  static const IconData privacy = Icons.privacy_tip;
  static const IconData security = Icons.security;

  // Social icons
  static const IconData google = Icons.g_mobiledata;
  static const IconData facebook = Icons.facebook;
  static const IconData apple = Icons.apple;

  // Navigation icons
  static const IconData arrowForwardIos = Icons.arrow_forward_ios;
}

/// App Icon Widget
class AppIcon extends StatelessWidget {
  final dynamic icon;
  final double? size;
  final Color? color;
  final VoidCallback? onTap;
  final BoxFit? fit;
  final String? semanticLabel;
  final bool showBackground;
  final Color? backgroundColor;
  final double? backgroundRadius;
  final EdgeInsetsGeometry? padding;

  const AppIcon({
    super.key,
    required this.icon,
    this.size,
    this.color,
    this.onTap,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.showBackground = false,
    this.backgroundColor,
    this.backgroundRadius,
    this.padding,
  });

  /// Create an icon with primary color
  const AppIcon.primary({
    super.key,
    required this.icon,
    this.size,
    this.onTap,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.showBackground = false,
    this.backgroundRadius,
    this.padding,
  })  : color = AppColors.primaryColor,
        backgroundColor = null;

  /// Create an icon with secondary color
  const AppIcon.secondary({
    super.key,
    required this.icon,
    this.size,
    this.onTap,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.showBackground = false,
    this.backgroundRadius,
    this.padding,
  })  : color = AppColors.textSecondaryColor,
        backgroundColor = null;

  /// Create an icon with success color
  const AppIcon.success({
    super.key,
    required this.icon,
    this.size,
    this.onTap,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.showBackground = false,
    this.backgroundRadius,
    this.padding,
  })  : color = AppColors.successColor,
        backgroundColor = null;

  /// Create an icon with error color
  const AppIcon.error({
    super.key,
    required this.icon,
    this.size,
    this.onTap,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.showBackground = false,
    this.backgroundRadius,
    this.padding,
  })  : color = AppColors.errorColor,
        backgroundColor = null;

  /// Create an icon with warning color
  const AppIcon.warning({
    super.key,
    required this.icon,
    this.size,
    this.onTap,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.showBackground = false,
    this.backgroundRadius,
    this.padding,
  })  : color = AppColors.warningColor,
        backgroundColor = null;

  /// Create an icon with background
  const AppIcon.withBackground({
    super.key,
    required this.icon,
    this.size,
    this.color,
    this.onTap,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.backgroundColor,
    this.backgroundRadius,
    this.padding,
  }) : showBackground = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultSize = size ?? 24;
    final defaultColor = color ??
        (isDark ? AppColors.darkThemeTextColor : AppColors.lightThemeTextColor);

    Widget iconWidget;

    if (icon is IconData) {
      // MaterialIcons
      iconWidget = Icon(
        icon,
        size: defaultSize,
        color: defaultColor,
        semanticLabel: semanticLabel,
      );
    } else if (icon is String) {
      // image asset icon
      iconWidget = Image.asset(
        icon,
        width: defaultSize,
        height: defaultSize,
        color: color,
        fit: fit,
        semanticLabel: semanticLabel,
      );
    } else {
      // Fallback
      iconWidget = const SizedBox.shrink();
    }

    // Add background if needed
    if (showBackground) {
      iconWidget = Container(
        padding: padding ?? const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor ??
              (isDark ? AppColors.darkSurface : AppColors.backgroundColor),
          borderRadius: BorderRadius.circular(backgroundRadius ?? 8),
        ),
        child: iconWidget,
      );
    }

    // Add tap functionality
    return onTap != null
        ? GestureDetector(
            onTap: onTap,
            child: iconWidget,
          )
        : iconWidget;
  }
}
