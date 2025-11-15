import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// List-specific widgets for better performance

/// List item with icon and text
class AppListItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showArrow;
  final Color? iconColor;
  final Color? titleColor;
  final Color? subtitleColor;

  const AppListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.trailing,
    this.onTap,
    this.showArrow = true,
    this.iconColor,
    this.titleColor,
    this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? AppIcon(
              icon: icon,
              color: iconColor ?? AppColors.primaryColor,
              size: 24,
            )
          : null,
      title: AppText(
        title,
        color: titleColor ?? AppColors.textPrimaryColor,
        fontWeight: FontWeight.w500,
      ),
      subtitle: subtitle != null
          ? AppAutoSizeText(
              subtitle!,
              color: subtitleColor ?? AppColors.textSecondaryColor,
              maxFontSize: 14,
            )
          : null,
      trailing: trailing ??
          (showArrow ? const AppIcon(icon: AppIcons.arrowForwardIos) : null),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

/// Settings item with switch
class AppSwitchItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final IconData? icon;
  final Color? iconColor;

  const AppSwitchItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? AppIcon(
              icon: icon,
              color: iconColor ?? AppColors.primaryColor,
              size: 24,
            )
          : null,
      title: AppText(
        title,
        color: AppColors.textPrimaryColor,
        fontWeight: FontWeight.w500,
      ),
      subtitle: subtitle != null
          ? AppAutoSizeText(
              subtitle!,
              color: AppColors.textSecondaryColor,
              maxFontSize: 14,
            )
          : null,
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryColor,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

/// Profile item with avatar
class AppProfileItem extends StatelessWidget {
  final String name;
  final String? email;
  final String? avatarUrl;
  final VoidCallback? onTap;
  final Widget? trailing;

  const AppProfileItem({
    super.key,
    required this.name,
    this.email,
    this.avatarUrl,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.primaryColor,
        backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
        child: avatarUrl == null
            ? AppAutoSizeText(
                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                maxFontSize: 16,
              )
            : null,
      ),
      title: AppText(
        name,
        color: AppColors.textPrimaryColor,
        fontWeight: FontWeight.w500,
      ),
      subtitle: email != null
          ? AppAutoSizeText(
              email!,
              color: AppColors.textSecondaryColor,
              maxFontSize: 14,
            )
          : null,
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

/// Menu item with badge
class AppMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final int? badgeCount;
  final Widget? trailing;
  final Color? iconColor;
  final Color? titleColor;

  const AppMenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.badgeCount,
    this.trailing,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppIcon(
        icon: icon,
        color: iconColor ?? AppColors.primaryColor,
        size: 24,
      ),
      title: AppText(
        title,
        color: titleColor ?? AppColors.textPrimaryColor,
        fontWeight: FontWeight.w500,
      ),
      trailing: trailing ??
          (badgeCount != null && badgeCount! > 0
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AppAutoSizeText(
                    '${badgeCount! > 99 ? '99+' : badgeCount}',
                    color: Colors.white,
                    maxFontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

/// Filter chip item
class AppFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onSelected;
  final Color? selectedColor;
  final Color? unselectedColor;

  const AppFilterChip({
    super.key,
    required this.label,
    required this.selected,
    this.onSelected,
    this.selectedColor,
    this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: AppText(
        label,
        color: selected
            ? (selectedColor ?? Colors.white)
            : (unselectedColor ?? AppColors.textPrimaryColor),
        fontWeight: FontWeight.w500,
      ),
      selected: selected,
      onSelected: onSelected != null ? (value) => onSelected!() : null,
      selectedColor: selectedColor ?? AppColors.primaryColor,
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: selected
            ? (selectedColor ?? AppColors.primaryColor)
            : (unselectedColor ?? AppColors.borderColor),
      ),
    );
  }
}
