import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/widgets/drawer_widgets.dart';

/// App Drawer
/// Navigation drawer with user profile and menu items
class AppDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? userAvatar;
  final List<AppDrawerItem> menuItems;
  final List<AppDrawerItem>? bottomItems;
  final VoidCallback? onProfileTap;
  final VoidCallback? onLogoutTap;
  final Color? backgroundColor;
  final Color? headerColor;

  const AppDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.userAvatar,
    required this.menuItems,
    this.bottomItems,
    this.onProfileTap,
    this.onLogoutTap,
    this.backgroundColor,
    this.headerColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor:
          backgroundColor ?? (isDark ? AppColors.darkSurface : Colors.white),
      child: Column(
        children: [
          // Header with user profile
          AppDrawerHeader(
            userName: userName,
            userEmail: userEmail,
            userAvatar: userAvatar,
            headerColor: headerColor,
            onProfileTap: onProfileTap,
          ),

          // Menu items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                ...menuItems.map((item) => AppDrawerMenuItem(
                      title: item.title,
                      icon: item.icon,
                      onTap: item.onTap,
                      badgeCount: item.badgeCount,
                      trailing: item.trailing,
                    )),
                if (bottomItems != null) ...[
                  const Divider(height: 1),
                  ...bottomItems!.map((item) => AppDrawerMenuItem(
                        title: item.title,
                        icon: item.icon,
                        onTap: item.onTap,
                        badgeCount: item.badgeCount,
                        trailing: item.trailing,
                      )),
                ],
              ],
            ),
          ),

          // Logout button
          if (onLogoutTap != null) ...[
            const Divider(height: 1),
            AppDrawerLogoutButton(onLogoutTap: onLogoutTap),
          ],
        ],
      ),
    );
  }
}

/// Drawer item model
class AppDrawerItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final Widget? trailing;
  final int? badgeCount;
  final VoidCallback? onTap;

  const AppDrawerItem({
    required this.title,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.trailing,
    this.badgeCount,
    this.onTap,
  });
}

/// Specialized drawer for main navigation
class AppMainDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? userAvatar;
  final VoidCallback? onProfileTap;
  final VoidCallback? onHomeTap;
  final VoidCallback? onSearchTap;
  final VoidCallback? onFavoritesTap;
  final VoidCallback? onSettingsTap;
  final VoidCallback? onHelpTap;
  final VoidCallback? onLogoutTap;
  final int? notificationCount;

  const AppMainDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.userAvatar,
    this.onProfileTap,
    this.onHomeTap,
    this.onSearchTap,
    this.onFavoritesTap,
    this.onSettingsTap,
    this.onHelpTap,
    this.onLogoutTap,
    this.notificationCount,
  });

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      userName: userName,
      userEmail: userEmail,
      userAvatar: userAvatar,
      onProfileTap: onProfileTap,
      onLogoutTap: onLogoutTap,
      menuItems: [
        AppDrawerItem(
          title: 'Home',
          icon: AppIcons.home,
          onTap: onHomeTap,
        ),
        AppDrawerItem(
          title: 'Search',
          icon: AppIcons.search,
          onTap: onSearchTap,
        ),
        AppDrawerItem(
          title: 'Favorites',
          icon: AppIcons.favorite,
          onTap: onFavoritesTap,
        ),
        AppDrawerItem(
          title: 'Notifications',
          icon: AppIcons.notifications,
          badgeCount: notificationCount,
          onTap: () {},
        ),
      ],
      bottomItems: [
        AppDrawerItem(
          title: 'Settings',
          icon: AppIcons.settings,
          onTap: onSettingsTap,
        ),
        AppDrawerItem(
          title: 'Help',
          icon: AppIcons.help,
          onTap: onHelpTap,
        ),
      ],
    );
  }
}

/// Specialized drawer for settings
class AppSettingsDrawer extends StatelessWidget {
  final String? userName;
  final String? userEmail;
  final String? userAvatar;
  final VoidCallback? onProfileTap;
  final VoidCallback? onAccountTap;
  final VoidCallback? onPrivacyTap;
  final VoidCallback? onSecurityTap;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onAboutTap;
  final VoidCallback? onLogoutTap;

  const AppSettingsDrawer({
    super.key,
    this.userName,
    this.userEmail,
    this.userAvatar,
    this.onProfileTap,
    this.onAccountTap,
    this.onPrivacyTap,
    this.onSecurityTap,
    this.onNotificationsTap,
    this.onAboutTap,
    this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppDrawer(
      userName: userName,
      userEmail: userEmail,
      userAvatar: userAvatar,
      onProfileTap: onProfileTap,
      onLogoutTap: onLogoutTap,
      menuItems: [
        AppDrawerItem(
          title: 'Account',
          subtitle: 'Manage personal information',
          icon: AppIcons.profile,
          onTap: onAccountTap,
        ),
        AppDrawerItem(
          title: 'Privacy',
          subtitle: 'Privacy settings',
          icon: AppIcons.privacy,
          onTap: onPrivacyTap,
        ),
        AppDrawerItem(
          title: 'Security',
          subtitle: 'Password and authentication',
          icon: AppIcons.security,
          onTap: onSecurityTap,
        ),
        AppDrawerItem(
          title: 'Notifications',
          subtitle: 'Notification settings',
          icon: AppIcons.notifications,
          onTap: onNotificationsTap,
        ),
      ],
      bottomItems: [
        AppDrawerItem(
          title: 'About the app',
          subtitle: 'Version and information',
          icon: AppIcons.info,
          onTap: onAboutTap,
        ),
      ],
    );
  }
}
