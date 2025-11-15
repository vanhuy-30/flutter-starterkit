import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// App List Tile
/// Customizable list tile with various configurations
class AppListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? backgroundColor;
  final Color? selectedColor;
  final bool selected;
  final bool enabled;
  final EdgeInsetsGeometry? contentPadding;
  final double? minVerticalPadding;
  final bool dense;
  final bool isThreeLine;
  final bool autofocus;
  final FocusNode? focusNode;
  final AppListTileVariant variant;

  const AppListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.selectedColor,
    this.selected = false,
    this.enabled = true,
    this.contentPadding,
    this.minVerticalPadding,
    this.dense = false,
    this.isThreeLine = false,
    this.autofocus = false,
    this.focusNode,
    this.variant = AppListTileVariant.defaultTile,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: backgroundColor ??
          (selected
              ? (selectedColor ?? AppColors.primaryColor.withValues(alpha: 0.1))
              : (isDark ? AppColors.darkSurface : Colors.white)),
      child: InkWell(
        onTap: enabled ? onTap : null,
        onLongPress: enabled ? onLongPress : null,
        child: Container(
          padding: contentPadding ??
              EdgeInsets.symmetric(
                horizontal: 16,
                vertical: minVerticalPadding ?? (dense ? 8 : 16),
              ),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (variant) {
      case AppListTileVariant.defaultTile:
        return _buildDefaultTile();
      case AppListTileVariant.compactTile:
        return _buildCompactTile();
      case AppListTileVariant.avatarTile:
        return _buildAvatarTile();
      case AppListTileVariant.switchTile:
        return _buildSwitchTile();
    }
  }

  Widget _buildDefaultTile() {
    return Row(
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 16),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                fontWeight: FontWeight.w500,
                color: enabled
                    ? AppColors.textPrimaryColor
                    : AppColors.textSecondaryColor,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                AppText(
                  subtitle!,
                  color: AppColors.textSecondaryColor,
                  maxLines: isThreeLine ? 2 : 1,
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 16),
          trailing!,
        ],
      ],
    );
  }

  Widget _buildCompactTile() {
    return Row(
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 12),
        ],
        Expanded(
          child: AppText(
            title,
            fontWeight: FontWeight.w500,
            color: enabled
                ? AppColors.textPrimaryColor
                : AppColors.textSecondaryColor,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }

  Widget _buildAvatarTile() {
    return Row(
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 16),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                fontWeight: FontWeight.w600,
                color: enabled
                    ? AppColors.textPrimaryColor
                    : AppColors.textSecondaryColor,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                AppText(
                  subtitle!,
                  color: AppColors.textSecondaryColor,
                  maxLines: 1,
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 16),
          trailing!,
        ],
      ],
    );
  }

  Widget _buildSwitchTile() {
    return Row(
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(width: 16),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                title,
                fontWeight: FontWeight.w500,
                color: enabled
                    ? AppColors.textPrimaryColor
                    : AppColors.textSecondaryColor,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                AppText(
                  subtitle!,
                  color: AppColors.textSecondaryColor,
                  maxLines: 1,
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 16),
          trailing!,
        ],
      ],
    );
  }
}

/// Specialized list tile for settings
class AppSettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showArrow;
  final Color? iconColor;

  const AppSettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.trailing,
    this.onTap,
    this.showArrow = true,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: title,
      subtitle: subtitle,
      leading: AppIcon(
        icon: icon,
        color: iconColor ?? AppColors.primaryColor,
        size: 24,
      ),
      trailing: trailing ??
          (showArrow
              ? const AppIcon(
                  icon: Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.textSecondaryColor,
                )
              : null),
      onTap: onTap,
      variant: AppListTileVariant.defaultTile,
    );
  }
}

/// Specialized list tile for user profile
class AppProfileTile extends StatelessWidget {
  final String name;
  final String? subtitle;
  final String? avatar;
  final VoidCallback? onTap;
  final Widget? trailing;

  const AppProfileTile({
    super.key,
    required this.name,
    this.subtitle,
    this.avatar,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: name,
      subtitle: subtitle,
      leading: CircleAvatar(
        radius: 20,
        backgroundImage: avatar != null ? NetworkImage(avatar!) : null,
        child: avatar == null
            ? AppText(
                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )
            : null,
      ),
      trailing: trailing ??
          const AppIcon(
            icon: Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.textSecondaryColor,
          ),
      onTap: onTap,
      variant: AppListTileVariant.avatarTile,
    );
  }
}

/// Specialized list tile with switch
class AppSwitchTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? leading;
  final bool enabled;

  const AppSwitchTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.leading,
    this.enabled = true,
  });

  @override
  State<AppSwitchTile> createState() => _AppSwitchTileState();
}

class _AppSwitchTileState extends State<AppSwitchTile> {
  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: widget.title,
      subtitle: widget.subtitle,
      leading: widget.leading,
      trailing: Switch(
        value: widget.value,
        onChanged: widget.enabled ? widget.onChanged : null,
        activeColor: AppColors.primaryColor,
      ),
      onTap:
          widget.enabled ? () => widget.onChanged?.call(!widget.value) : null,
      variant: AppListTileVariant.switchTile,
    );
  }
}

/// Specialized list tile for menu items
class AppMenuTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;
  final bool showArrow;

  const AppMenuTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
    this.iconColor,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppListTile(
      title: title,
      subtitle: subtitle,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? AppColors.primaryColor).withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: AppIcon(
          icon: icon,
          color: iconColor ?? AppColors.primaryColor,
          size: 20,
        ),
      ),
      trailing: showArrow
          ? const AppIcon(
              icon: Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.textSecondaryColor,
            )
          : null,
      onTap: onTap,
      variant: AppListTileVariant.defaultTile,
    );
  }
}

/// List tile variants
enum AppListTileVariant {
  defaultTile,
  compactTile,
  avatarTile,
  switchTile,
}
