import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/molecules/app_list_tile.dart';
import 'package:flutter_starter_kit/shared/design_system/molecules/app_info_card.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// App List Section
/// Organized list sections with headers and various layouts
class AppListSection extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final Widget? header;
  final List<AppListItem> items;
  final AppListSectionStyle style;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showDivider;
  final VoidCallback? onSeeAllPressed;
  final String? seeAllText;
  final Widget? emptyWidget;
  final Widget? loadingWidget;
  final bool isLoading;
  final bool isEmpty;

  const AppListSection({
    super.key,
    this.title,
    this.subtitle,
    this.header,
    required this.items,
    this.style = AppListSectionStyle.list,
    this.padding,
    this.margin,
    this.showDivider = true,
    this.onSeeAllPressed,
    this.seeAllText = 'Xem tất cả',
    this.emptyWidget,
    this.loadingWidget,
    this.isLoading = false,
    this.isEmpty = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingSection();
    }

    if (isEmpty) {
      return _buildEmptySection();
    }

    return Container(
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          if (showDivider && title != null) ...[
            const Divider(height: 1),
            const SizedBox(height: 8),
          ],
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    if (header != null) return header!;

    if (title == null) return const SizedBox.shrink();

    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  title!,
                  fontWeight: FontWeight.bold,
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
          if (onSeeAllPressed != null)
            TextButton(
              onPressed: onSeeAllPressed,
              child: AppText(
                seeAllText!,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (style) {
      case AppListSectionStyle.list:
        return _buildListStyle();
      case AppListSectionStyle.grid:
        return _buildGridStyle();
      case AppListSectionStyle.horizontal:
        return _buildHorizontalStyle();
      case AppListSectionStyle.cards:
        return _buildCardsStyle();
    }
  }

  Widget _buildListStyle() {
    return Column(
      children: items.asMap().entries.map((entry) {
        final index = entry.key;
        final item = entry.value;
        final isLast = index == items.length - 1;

        return Column(
          children: [
            _buildListItem(item),
            if (!isLast && showDivider) const Divider(height: 1),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildGridStyle() {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return _buildGridItem(items[index]);
        },
      ),
    );
  }

  Widget _buildHorizontalStyle() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: index < items.length - 1 ? 16 : 0,
            ),
            child: _buildHorizontalItem(items[index]),
          );
        },
      ),
    );
  }

  Widget _buildCardsStyle() {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: Column(
        children: items
            .map((item) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildCardItem(item),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildListItem(AppListItem item) {
    return AppListTile(
      title: item.title,
      subtitle: item.subtitle,
      leading: item.leading,
      trailing: item.trailing,
      onTap: item.onTap,
      variant: item.variant,
    );
  }

  Widget _buildGridItem(AppListItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.leading != null) ...[
                item.leading!,
                const SizedBox(height: 8),
              ],
              AppText(
                item.title,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
              if (item.subtitle != null) ...[
                const SizedBox(height: 4),
                AppText(
                  item.subtitle!,
                  color: AppColors.textSecondaryColor,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalItem(AppListItem item) {
    return GestureDetector(
      onTap: item.onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (item.leading != null) ...[
                item.leading!,
                const SizedBox(height: 8),
              ],
              AppText(
                item.title,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryColor,
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardItem(AppListItem item) {
    return AppInfoCard(
      title: item.title,
      subtitle: item.subtitle,
      leading: item.leading,
      trailing: item.trailing,
      onTap: item.onTap,
      variant: AppInfoCardVariant.horizontalCard,
    );
  }

  Widget _buildLoadingSection() {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(16),
      child: loadingWidget ??
          const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ),
    );
  }

  Widget _buildEmptySection() {
    return Container(
      margin: margin,
      padding: padding ?? const EdgeInsets.all(32),
      child: emptyWidget ??
          const Column(
            children: [
              AppIcon(
                icon: AppIcons.info,
                color: AppColors.textSecondaryColor,
                size: 48,
              ),
              SizedBox(height: 16),
              AppText(
                'Không có dữ liệu',
                color: AppColors.textSecondaryColor,
                textAlign: TextAlign.center,
              ),
            ],
          ),
    );
  }
}

/// List item model
class AppListItem {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final AppListTileVariant variant;

  const AppListItem({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.variant = AppListTileVariant.defaultTile,
  });
}

/// List section styles
enum AppListSectionStyle {
  list,
  grid,
  horizontal,
  cards,
}

/// Specialized list section for settings
class AppSettingsSection extends StatelessWidget {
  final String? title;
  final List<AppSettingsItem> items;
  final bool showDivider;

  const AppSettingsSection({
    super.key,
    this.title,
    required this.items,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppListSection(
      title: title,
      items: items
          .map((item) => AppListItem(
                title: item.title,
                subtitle: item.subtitle,
                leading: AppIcon(
                  icon: item.icon,
                  color: item.iconColor ?? AppColors.primaryColor,
                  size: 24,
                ),
                trailing: item.trailing ??
                    (item.showArrow
                        ? const AppIcon(
                            icon: AppIcons.forwardIos,
                            color: AppColors.textSecondaryColor,
                            size: 16,
                          )
                        : null),
                onTap: item.onTap,
                variant: AppListTileVariant.defaultTile,
              ))
          .toList(),
      showDivider: showDivider,
    );
  }
}

/// Settings item model
class AppSettingsItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool showArrow;

  const AppSettingsItem({
    required this.title,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.trailing,
    this.onTap,
    this.showArrow = true,
  });
}

/// Specialized list section for menu items
class AppMenuSection extends StatelessWidget {
  final String? title;
  final List<AppMenuItem> items;
  final bool showDivider;

  const AppMenuSection({
    super.key,
    this.title,
    required this.items,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppListSection(
      title: title,
      items: items
          .map((item) => AppListItem(
                title: item.title,
                subtitle: item.subtitle,
                leading: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (item.iconColor ?? AppColors.primaryColor)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppIcon(
                    icon: item.icon,
                    color: item.iconColor ?? AppColors.primaryColor,
                    size: 20,
                  ),
                ),
                trailing: item.badgeCount != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.errorColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: AppAutoSizeText(
                          '${item.badgeCount}',
                          color: Colors.white,
                          maxFontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : (item.showArrow
                        ? const AppIcon(
                            icon: AppIcons.forwardIos,
                            color: AppColors.textSecondaryColor,
                            size: 16,
                          )
                        : null),
                onTap: item.onTap,
                variant: AppListTileVariant.defaultTile,
              ))
          .toList(),
      showDivider: showDivider,
    );
  }
}

/// Menu item model
class AppMenuItem {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Color? iconColor;
  final VoidCallback? onTap;
  final int? badgeCount;
  final bool showArrow;

  const AppMenuItem({
    required this.title,
    this.subtitle,
    required this.icon,
    this.iconColor,
    this.onTap,
    this.badgeCount,
    this.showArrow = true,
  });
}
