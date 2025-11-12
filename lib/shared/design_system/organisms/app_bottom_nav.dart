import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/badges/counter_badge.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/core/utils/badge_utils.dart';

/// Model for navigation item
class AppBottomNavItem {
  final dynamic icon;
  final dynamic selectedIcon;
  final String label;
  final int? badgeCount;
  final bool showBadge;
  final VoidCallback? onTap;

  const AppBottomNavItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
    this.badgeCount,
    this.showBadge = false,
    this.onTap,
  });
}

/// App Bottom Navigation Bar Organism
/// Using atoms and molecules to create bottom navigation bar
class AppBottomNavBar extends StatefulWidget {
  final List<AppBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final double? elevation;
  final bool showLabels;
  final double iconSize;
  final double labelFontSize;

  const AppBottomNavBar({
    super.key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation = 8.0,
    this.showLabels = true,
    this.iconSize = 24.0,
    this.labelFontSize = 12.0,
  });

  @override
  State<AppBottomNavBar> createState() => _AppBottomNavBarState();
}

class _AppBottomNavBarState extends State<AppBottomNavBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            (isDark ? AppColors.darkSurface : Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: widget.elevation!,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: widget.items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == widget.currentIndex;

              return _buildNavItem(
                item: item,
                index: index,
                isSelected: isSelected,
                isDark: isDark,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required AppBottomNavItem item,
    required int index,
    required bool isSelected,
    required bool isDark,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (item.onTap != null) {
            item.onTap!();
          } else if (widget.onTap != null) {
            widget.onTap!(index);
          }

          if (isSelected) {
            _animationController.forward().then((_) {
              _animationController.reverse();
            });
          }
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            final scale = isSelected ? _scaleAnimation.value : 1.0;
            return Transform.scale(
              scale: scale,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon with badge
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AppIcon(
                          icon: isSelected && item.selectedIcon != null
                              ? item.selectedIcon
                              : item.icon,
                          size: widget.iconSize,
                          color: isSelected
                              ? (widget.selectedItemColor ??
                                  AppColors.primaryColor)
                              : (widget.unselectedItemColor ??
                                  (isDark
                                      ? AppColors.darkDisabled
                                      : AppColors.textSecondaryColor)),
                        ),
                        // Badge if showBadge is true or badgeCount is greater than 0
                        if (item.showBadge ||
                            (item.badgeCount != null && item.badgeCount! > 0))
                          Positioned(
                            right: -8,
                            top: -8,
                            child: item.badgeCount != null
                                ? CounterBadge(
                                    value: item.badgeCount!,
                                    variant: BadgeVariant.error,
                                  )
                                : Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: AppColors.errorColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                          ),
                      ],
                    ),
                    // Label if showLabels is true
                    if (widget.showLabels) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          fontSize: widget.labelFontSize,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                          color: isSelected
                              ? (widget.selectedItemColor ??
                                  AppColors.primaryColor)
                              : (widget.unselectedItemColor ??
                                  (isDark
                                      ? AppColors.darkDisabled
                                      : AppColors.textSecondaryColor)),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
