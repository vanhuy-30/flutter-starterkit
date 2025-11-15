import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/molecules/app_search_bar.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// App Header Bar
/// Customizable app bar with various configurations
class AppHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBackButton;
  final bool showSearchButton;
  final bool showMenuButton;
  final bool showNotificationButton;
  final bool showProfileButton;
  final VoidCallback? onBackPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final bool centerTitle;
  final bool automaticallyImplyLeading;
  final PreferredSizeWidget? bottom;
  final int? notificationCount;
  final String? profileImage;
  final AppHeaderBarStyle style;

  const AppHeaderBar({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.showBackButton = false,
    this.showSearchButton = false,
    this.showMenuButton = false,
    this.showNotificationButton = false,
    this.showProfileButton = false,
    this.onBackPressed,
    this.onSearchPressed,
    this.onMenuPressed,
    this.onNotificationPressed,
    this.onProfilePressed,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.centerTitle = true,
    this.automaticallyImplyLeading = true,
    this.bottom,
    this.notificationCount,
    this.profileImage,
    this.style = AppHeaderBarStyle.standard,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AppBar(
      title: _buildTitle(),
      leading: _buildLeading(context),
      actions: _buildActions(context),
      backgroundColor:
          backgroundColor ?? (isDark ? AppColors.darkSurface : Colors.white),
      foregroundColor: foregroundColor ??
          (isDark
              ? AppColors.darkThemeTextColor
              : AppColors.lightThemeTextColor),
      elevation: elevation,
      centerTitle: centerTitle,
      automaticallyImplyLeading: automaticallyImplyLeading,
      bottom: bottom,
      flexibleSpace: style == AppHeaderBarStyle.gradient
          ? _buildGradientBackground()
          : null,
    );
  }

  Widget? _buildTitle() {
    if (title == null) return null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          title!,
          fontWeight: FontWeight.bold,
          color: foregroundColor ?? AppColors.textPrimaryColor,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 2),
          AppAutoSizeText(
            subtitle!,
            maxFontSize: 12,
            color: (foregroundColor ?? AppColors.textPrimaryColor)
                .withValues(alpha: 0.7),
          ),
        ],
      ],
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (showBackButton) {
      return IconButton(
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        icon: const AppIcon(
          icon: AppIcons.back,
          color: AppColors.primaryColor,
        ),
      );
    }

    if (showMenuButton) {
      return IconButton(
        onPressed: onMenuPressed,
        icon: const AppIcon(
          icon: AppIcons.menu,
          color: AppColors.primaryColor,
        ),
      );
    }

    return null;
  }

  List<Widget>? _buildActions(BuildContext context) {
    final List<Widget> actionWidgets = [];

    if (showSearchButton) {
      actionWidgets.add(
        IconButton(
          onPressed: onSearchPressed,
          icon: const AppIcon(
            icon: AppIcons.search,
            color: AppColors.primaryColor,
          ),
        ),
      );
    }

    if (showNotificationButton) {
      actionWidgets.add(
        Stack(
          children: [
            IconButton(
              onPressed: onNotificationPressed,
              icon: const AppIcon(
                icon: AppIcons.notifications,
                color: AppColors.primaryColor,
              ),
            ),
            if (notificationCount != null && notificationCount! > 0)
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.errorColor,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: AppAutoSizeText(
                    '${notificationCount! > 99 ? '99+' : notificationCount}',
                    color: Colors.white,
                    maxFontSize: 10,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      );
    }

    if (showProfileButton) {
      actionWidgets.add(
        GestureDetector(
          onTap: onProfilePressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: CircleAvatar(
              radius: 16,
              backgroundImage:
                  profileImage != null ? NetworkImage(profileImage!) : null,
              child: profileImage == null
                  ? const AppIcon(
                      icon: AppIcons.profile,
                      color: AppColors.primaryColor,
                      size: 16,
                    )
                  : null,
            ),
          ),
        ),
      );
    }

    if (actions != null) {
      actionWidgets.addAll(actions!);
    }

    return actionWidgets.isNotEmpty ? actionWidgets : null;
  }

  Widget? _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundColor ?? AppColors.primaryColor,
            (backgroundColor ?? AppColors.primaryColor).withValues(alpha: 0.8),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
}

/// Specialized header bar for main app
class AppMainHeaderBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onProfilePressed;
  final int? notificationCount;
  final String? profileImage;
  final bool showSearchButton;
  final bool showNotificationButton;
  final bool showProfileButton;

  const AppMainHeaderBar({
    super.key,
    this.title,
    this.onMenuPressed,
    this.onSearchPressed,
    this.onNotificationPressed,
    this.onProfilePressed,
    this.notificationCount,
    this.profileImage,
    this.showSearchButton = true,
    this.showNotificationButton = true,
    this.showProfileButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppHeaderBar(
      title: title ?? 'App',
      showMenuButton: true,
      showSearchButton: showSearchButton,
      showNotificationButton: showNotificationButton,
      showProfileButton: showProfileButton,
      onMenuPressed: onMenuPressed,
      onSearchPressed: onSearchPressed,
      onNotificationPressed: onNotificationPressed,
      onProfilePressed: onProfilePressed,
      notificationCount: notificationCount,
      profileImage: profileImage,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Specialized header bar with search
class AppSearchHeaderBar extends StatefulWidget {
  final String? hintText;
  final TextEditingController? searchController;
  final void Function(String)? onSearchChanged;
  final void Function(String)? onSearchSubmitted;
  final VoidCallback? onBackPressed;
  final VoidCallback? onFilterPressed;
  final bool showFilterButton;
  final String? title;

  const AppSearchHeaderBar({
    super.key,
    this.hintText,
    this.searchController,
    this.onSearchChanged,
    this.onSearchSubmitted,
    this.onBackPressed,
    this.onFilterPressed,
    this.showFilterButton = false,
    this.title,
  });

  @override
  State<AppSearchHeaderBar> createState() => _AppSearchHeaderBarState();
}

class _AppSearchHeaderBarState extends State<AppSearchHeaderBar> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = widget.searchController ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.searchController == null) {
      _searchController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: widget.title != null
          ? AppText(
              widget.title!,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimaryColor,
            )
          : AppSearchBar(
              hintText: widget.hintText ?? 'search'.tr(),
              controller: _searchController,
              onChanged: widget.onSearchChanged,
              onSubmitted: widget.onSearchSubmitted,
              showFilterButton: widget.showFilterButton,
              onFilterTap: widget.onFilterPressed,
              variant: AppSearchBarVariant.filledBar,
              height: 40,
            ),
      leading: IconButton(
        onPressed: widget.onBackPressed ?? () => Navigator.of(context).pop(),
        icon: const AppIcon(
          icon: AppIcons.back,
          color: AppColors.primaryColor,
        ),
      ),
      actions: widget.showFilterButton
          ? [
              IconButton(
                onPressed: widget.onFilterPressed,
                icon: const AppIcon(
                  icon: AppIcons.filter,
                  color: AppColors.primaryColor,
                ),
              ),
            ]
          : null,
      backgroundColor: Colors.white,
      foregroundColor: AppColors.textPrimaryColor,
      elevation: 1,
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Specialized header bar for detail pages
class AppDetailHeaderBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final bool showShareButton;
  final bool showFavoriteButton;
  final bool showMoreButton;
  final VoidCallback? onSharePressed;
  final VoidCallback? onFavoritePressed;
  final VoidCallback? onMorePressed;
  final bool isFavorite;

  const AppDetailHeaderBar({
    super.key,
    required this.title,
    this.subtitle,
    this.onBackPressed,
    this.actions,
    this.showShareButton = true,
    this.showFavoriteButton = true,
    this.showMoreButton = true,
    this.onSharePressed,
    this.onFavoritePressed,
    this.onMorePressed,
    this.isFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> actionWidgets = [];

    if (showShareButton) {
      actionWidgets.add(
        IconButton(
          onPressed: onSharePressed,
          icon: const AppIcon(
            icon: AppIcons.share,
            color: AppColors.primaryColor,
          ),
        ),
      );
    }

    if (showFavoriteButton) {
      actionWidgets.add(
        IconButton(
          onPressed: onFavoritePressed,
          icon: AppIcon(
            icon: isFavorite ? AppIcons.favorite : AppIcons.favoriteOutlined,
            color: isFavorite ? AppColors.errorColor : AppColors.primaryColor,
          ),
        ),
      );
    }

    if (showMoreButton) {
      actionWidgets.add(
        IconButton(
          onPressed: onMorePressed,
          icon: const AppIcon(
            icon: AppIcons.moreVert,
            color: AppColors.primaryColor,
          ),
        ),
      );
    }

    if (actions != null) {
      actionWidgets.addAll(actions!);
    }

    return AppHeaderBar(
      title: title,
      subtitle: subtitle,
      showBackButton: true,
      onBackPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      actions: actionWidgets,
    );
  }

  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Header bar styles
enum AppHeaderBarStyle {
  standard,
  gradient,
  transparent,
}
