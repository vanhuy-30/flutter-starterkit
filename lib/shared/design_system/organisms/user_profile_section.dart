import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/molecules/app_info_card.dart';
import 'package:flutter_starter_kit/shared/design_system/molecules/app_list_tile.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/buttons/app_button.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// User Profile Section
/// Comprehensive user profile display with various sections
class UserProfileSection extends StatelessWidget {
  final String name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String? bio;
  final List<UserProfileItem> profileItems;
  final List<UserProfileAction> actions;
  final VoidCallback? onEditProfile;
  final VoidCallback? onSettings;
  final VoidCallback? onLogout;
  final bool showEditButton;
  final bool showSettingsButton;
  final bool showLogoutButton;
  final UserProfileStyle style;

  const UserProfileSection({
    super.key,
    required this.name,
    this.email,
    this.phone,
    this.avatar,
    this.bio,
    this.profileItems = const [],
    this.actions = const [],
    this.onEditProfile,
    this.onSettings,
    this.onLogout,
    this.showEditButton = true,
    this.showSettingsButton = true,
    this.showLogoutButton = true,
    this.style = UserProfileStyle.card,
  });

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case UserProfileStyle.card:
        return _buildCardStyle();
      case UserProfileStyle.list:
        return _buildListStyle();
      case UserProfileStyle.compact:
        return _buildCompactStyle();
    }
  }

  Widget _buildCardStyle() {
    return Column(
      children: [
        // Profile header
        AppInfoCard(
          title: name,
          subtitle: email ?? phone,
          leading: _buildAvatar(),
          trailing: showEditButton
              ? AppButton(
                  text: 'Edit',
                  onPressed: onEditProfile ?? () {},
                  height: 36,
                )
              : null,
          variant: AppInfoCardVariant.horizontalCard,
        ),

        if (bio != null) ...[
          const SizedBox(height: 16),
          AppInfoCard(
            title: 'About',
            subtitle: bio,
            variant: AppInfoCardVariant.defaultCard,
          ),
        ],

        if (profileItems.isNotEmpty) ...[
          const SizedBox(height: 16),
          Column(
            children: [
              const AppInfoCard(
                title: 'Personal information',
                variant: AppInfoCardVariant.defaultCard,
              ),
              ...profileItems.map(_buildProfileItem),
            ],
          ),
        ],

        if (actions.isNotEmpty) ...[
          const SizedBox(height: 16),
          Column(
            children: [
              const AppInfoCard(
                title: 'Actions',
                variant: AppInfoCardVariant.defaultCard,
              ),
              ...actions.map(_buildActionItem),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildListStyle() {
    return Column(
      children: [
        // Profile header
        AppListTile(
          title: name,
          subtitle: email ?? phone,
          leading: _buildAvatar(),
          trailing: showEditButton
              ? const AppIcon(
                  icon: AppIcons.edit,
                  color: AppColors.primaryColor,
                )
              : null,
          onTap: onEditProfile,
          variant: AppListTileVariant.avatarTile,
        ),

        if (bio != null) ...[
          const Divider(height: 1),
          AppListTile(
            title: 'About',
            subtitle: bio,
            leading: const AppIcon(
              icon: AppIcons.info,
              color: AppColors.primaryColor,
            ),
            variant: AppListTileVariant.defaultTile,
          ),
        ],

        ...profileItems.map((item) => Column(
              children: [
                const Divider(height: 1),
                _buildProfileItem(item),
              ],
            )),

        ...actions.map((action) => Column(
              children: [
                const Divider(height: 1),
                _buildActionItem(action),
              ],
            )),
      ],
    );
  }

  Widget _buildCompactStyle() {
    return Row(
      children: [
        _buildAvatar(),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                name,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimaryColor,
              ),
              if (email != null) ...[
                const SizedBox(height: 4),
                AppText(
                  email!,
                  color: AppColors.textSecondaryColor,
                ),
              ],
              if (phone != null) ...[
                const SizedBox(height: 4),
                AppText(
                  phone!,
                  color: AppColors.textSecondaryColor,
                ),
              ],
            ],
          ),
        ),
        if (showEditButton)
          AppButton(
            text: 'Edit',
            onPressed: onEditProfile ?? () {},
            height: 36,
          ),
      ],
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 30,
      backgroundImage: avatar != null ? NetworkImage(avatar!) : null,
      child: avatar == null
          ? AppAutoSizeText(
              name.isNotEmpty ? name[0].toUpperCase() : 'U',
              color: Colors.white,
              fontWeight: FontWeight.bold,
              maxFontSize: 24,
            )
          : null,
    );
  }

  Widget _buildProfileItem(UserProfileItem item) {
    return AppListTile(
      title: item.title,
      subtitle: item.value,
      leading: AppIcon(
        icon: item.icon,
        color: item.iconColor ?? AppColors.primaryColor,
        size: 20,
      ),
      onTap: item.onTap,
      variant: AppListTileVariant.defaultTile,
    );
  }

  Widget _buildActionItem(UserProfileAction action) {
    return AppListTile(
      title: action.title,
      subtitle: action.subtitle,
      leading: AppIcon(
        icon: action.icon,
        color: action.iconColor ?? AppColors.primaryColor,
        size: 20,
      ),
      trailing: action.showArrow
          ? const AppIcon(
              icon: AppIcons.forwardIos,
              color: AppColors.textSecondaryColor,
              size: 16,
            )
          : null,
      onTap: action.onTap,
      variant: AppListTileVariant.defaultTile,
    );
  }
}

/// User profile item model
class UserProfileItem {
  final String title;
  final String value;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;

  const UserProfileItem({
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.onTap,
  });
}

/// User profile action model
class UserProfileAction {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final bool showArrow;

  const UserProfileAction({
    required this.title,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.onTap,
    this.showArrow = true,
  });
}

/// User profile styles
enum UserProfileStyle {
  card,
  list,
  compact,
}

/// Specialized profile for settings
class UserSettingsProfile extends StatelessWidget {
  final String name;
  final String? email;
  final String? avatar;
  final VoidCallback? onEditProfile;
  final VoidCallback? onAccountSettings;
  final VoidCallback? onPrivacySettings;
  final VoidCallback? onSecuritySettings;
  final VoidCallback? onNotificationSettings;

  const UserSettingsProfile({
    super.key,
    required this.name,
    this.email,
    this.avatar,
    this.onEditProfile,
    this.onAccountSettings,
    this.onPrivacySettings,
    this.onSecuritySettings,
    this.onNotificationSettings,
  });

  @override
  Widget build(BuildContext context) {
    return UserProfileSection(
      name: name,
      email: email,
      avatar: avatar,
      onEditProfile: onEditProfile,
      style: UserProfileStyle.list,
      profileItems: [
        UserProfileItem(
          title: 'Account',
          value: 'Manage personal information',
          icon: AppIcons.profile,
          onTap: onAccountSettings,
        ),
        UserProfileItem(
          title: 'Privacy',
          value: 'Privacy settings',
          icon: AppIcons.privacy,
          onTap: onPrivacySettings,
        ),
        UserProfileItem(
          title: 'Security',
          value: 'Password and authentication',
          icon: AppIcons.security,
          onTap: onSecuritySettings,
        ),
        UserProfileItem(
          title: 'Notifications',
          value: 'Notification settings',
          icon: AppIcons.notifications,
          onTap: onNotificationSettings,
        ),
      ],
    );
  }
}
