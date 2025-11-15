import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/avatar_images/app_circular_avatar.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/badges/counter_badge.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/core/utils/badge_utils.dart';

/// Drawer-specific widgets for better performance

/// Drawer header with user profile
class AppDrawerHeader extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? userAvatar;
  final Color? headerColor;
  final VoidCallback? onProfileTap;

  const AppDrawerHeader({
    super.key,
    this.userName,
    this.userEmail,
    this.userAvatar,
    this.headerColor,
    this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            headerColor ?? AppColors.primaryColor,
            (headerColor ?? AppColors.primaryColor).withValues(alpha: 0.8),
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // User profile section
              GestureDetector(
                onTap: onProfileTap,
                child: Row(
                  children: [
                    AppCircularAvatar(
                      networkImageUrl: userAvatar,
                      name: userName,
                      radius: 30,
                      backgroundColor: Colors.white.withValues(alpha: 0.2),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppAutoSizeText(
                            userName ?? 'User',
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            maxFontSize: 18,
                          ),
                          if (userEmail != null) ...[
                            const SizedBox(height: 4),
                            AppAutoSizeText(
                              userEmail!,
                              color: Colors.white.withValues(alpha: 0.8),
                              maxFontSize: 14,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Drawer menu item
class AppDrawerMenuItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final int? badgeCount;
  final Widget? trailing;
  final bool isSelected;

  const AppDrawerMenuItem({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.badgeCount,
    this.trailing,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AppIcon(
        icon: icon,
        color:
            isSelected ? AppColors.primaryColor : AppColors.textSecondaryColor,
        size: 24,
      ),
      title: AppText(
        title,
        color: isSelected ? AppColors.primaryColor : AppColors.textPrimaryColor,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
      ),
      trailing: trailing ??
          (badgeCount != null && badgeCount! > 0
              ? CounterBadge(
                  value: badgeCount!,
                  variant: BadgeVariant.error,
                )
              : null),
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: AppColors.primaryColor.withValues(alpha: 0.1),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}

/// Drawer logout button
class AppDrawerLogoutButton extends StatelessWidget {
  final VoidCallback? onLogoutTap;

  const AppDrawerLogoutButton({
    super.key,
    this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const AppIcon(
        icon: AppIcons.logout,
        color: AppColors.errorColor,
        size: 24,
      ),
      title: const AppText(
        'Đăng xuất',
        color: AppColors.errorColor,
        fontWeight: FontWeight.w500,
      ),
      onTap: onLogoutTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
