import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// App Info Card
/// Displays information in a card format with various layouts
class AppInfoCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? description;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? elevation;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final bool showBorder;
  final AppInfoCardVariant variant;

  const AppInfoCard({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.leading,
    this.trailing,
    this.onTap,
    this.backgroundColor,
    this.borderColor,
    this.elevation = 2.0,
    this.padding,
    this.margin,
    this.borderRadius,
    this.showBorder = false,
    this.variant = AppInfoCardVariant.defaultCard,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color:
            backgroundColor ?? (isDark ? AppColors.darkSurface : Colors.white),
        elevation: elevation ?? 2.0,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: borderRadius ?? BorderRadius.circular(12),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: borderRadius ?? BorderRadius.circular(12),
              border: showBorder
                  ? Border.all(
                      color: borderColor ??
                          (isDark
                              ? AppColors.darkBorder
                              : AppColors.borderColor),
                      width: 1,
                    )
                  : null,
            ),
            child: _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (variant) {
      case AppInfoCardVariant.defaultCard:
        return _buildDefaultCard();
      case AppInfoCardVariant.horizontalCard:
        return _buildHorizontalCard();
      case AppInfoCardVariant.verticalCard:
        return _buildVerticalCard();
      case AppInfoCardVariant.compactCard:
        return _buildCompactCard();
    }
  }

  Widget _buildDefaultCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    title,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryColor,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 4),
                    AppText(
                      subtitle!,
                      color: AppColors.textSecondaryColor,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
        if (description != null) ...[
          const SizedBox(height: 8),
          AppText(
            description!,
            color: AppColors.textSecondaryColor,
            maxLines: 3,
          ),
        ],
      ],
    );
  }

  Widget _buildHorizontalCard() {
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
                color: AppColors.textPrimaryColor,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                AppText(
                  subtitle!,
                  color: AppColors.textSecondaryColor,
                ),
              ],
              if (description != null) ...[
                const SizedBox(height: 8),
                AppText(
                  description!,
                  color: AppColors.textSecondaryColor,
                  maxLines: 2,
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

  Widget _buildVerticalCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leading != null) ...[
          leading!,
          const SizedBox(height: 12),
        ],
        AppText(
          title,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryColor,
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          AppText(
            subtitle!,
            color: AppColors.textSecondaryColor,
            textAlign: TextAlign.center,
          ),
        ],
        if (description != null) ...[
          const SizedBox(height: 8),
          AppText(
            description!,
            color: AppColors.textSecondaryColor,
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ],
        if (trailing != null) ...[
          const SizedBox(height: 12),
          trailing!,
        ],
      ],
    );
  }

  Widget _buildCompactCard() {
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
            color: AppColors.textPrimaryColor,
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// Specialized info card for statistics
class AppStatsCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;
  final Color? valueColor;
  final VoidCallback? onTap;

  const AppStatsCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.valueColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppInfoCard(
      title: title,
      subtitle: subtitle,
      leading: icon != null
          ? Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (iconColor ?? AppColors.primaryColor)
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppIcon(
                icon: icon,
                color: iconColor ?? AppColors.primaryColor,
                size: 20,
              ),
            )
          : null,
      trailing: AppText(
        value,
        fontWeight: FontWeight.bold,
        color: valueColor ?? AppColors.primaryColor,
      ),
      onTap: onTap,
      variant: AppInfoCardVariant.horizontalCard,
    );
  }
}

/// Specialized info card for user profile
class AppProfileCard extends StatelessWidget {
  final String name;
  final String? email;
  final String? avatar;
  final String? subtitle;
  final VoidCallback? onTap;

  const AppProfileCard({
    super.key,
    required this.name,
    this.email,
    this.avatar,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppInfoCard(
      title: name,
      subtitle: subtitle ?? email,
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: avatar != null ? NetworkImage(avatar!) : null,
        child: avatar == null
            ? AppText(
                name.isNotEmpty ? name[0].toUpperCase() : 'U',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )
            : null,
      ),
      trailing: const AppIcon(
        icon: Icons.arrow_forward_ios,
        size: 16,
        color: AppColors.textSecondaryColor,
      ),
      onTap: onTap,
      variant: AppInfoCardVariant.horizontalCard,
    );
  }
}

/// Specialized info card for settings
class AppSettingsCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showArrow;

  const AppSettingsCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.trailing,
    this.onTap,
    this.showArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppInfoCard(
      title: title,
      subtitle: subtitle,
      leading: AppIcon(
        icon: icon,
        color: AppColors.primaryColor,
        size: 20,
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
      variant: AppInfoCardVariant.horizontalCard,
    );
  }
}

/// Card variants
enum AppInfoCardVariant {
  defaultCard,
  horizontalCard,
  verticalCard,
  compactCard,
}
