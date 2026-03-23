import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// App Search Bar
/// Advanced search bar with various features and configurations
class AppSearchBar extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback? onSearch;
  final VoidCallback? onClear;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final bool autofocus;
  final bool showClearButton;
  final bool showFilterButton;
  final VoidCallback? onFilterTap;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? height;
  final AppSearchBarVariant variant;

  const AppSearchBar({
    super.key,
    this.hintText = 'Search...',
    required this.controller,
    this.onSearch,
    this.onClear,
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.autofocus = false,
    this.showClearButton = true,
    this.showFilterButton = false,
    this.onFilterTap,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.margin,
    this.height,
    this.variant = AppSearchBarVariant.defaultBar,
  });

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: widget.margin,
      height: widget.height ?? 48,
      child: _buildSearchBar(isDark),
    );
  }

  Widget _buildSearchBar(bool isDark) {
    switch (widget.variant) {
      case AppSearchBarVariant.defaultBar:
        return _buildDefaultSearchBar(isDark);
      case AppSearchBarVariant.outlinedBar:
        return _buildOutlinedSearchBar(isDark);
      case AppSearchBarVariant.filledBar:
        return _buildFilledSearchBar(isDark);
      case AppSearchBarVariant.compactBar:
        return _buildCompactSearchBar(isDark);
    }
  }

  Widget _buildDefaultSearchBar(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            (isDark ? AppColors.darkSurface : Colors.white),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 24),
        border: Border.all(
          color: _isFocused
              ? AppColors.primaryColor
              : (widget.borderColor ?? AppColors.borderColor),
          width: _isFocused ? 2 : 1,
        ),
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          if (widget.leading != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: widget.leading,
            ),
          ] else ...[
            const Padding(
              padding: EdgeInsets.only(left: 16),
              child: AppIcon(
                icon: AppIcons.search,
                color: AppColors.textSecondaryColor,
                size: 20,
              ),
            ),
          ],
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppColors.textSecondaryColor,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
          ),
          if (widget.showClearButton && widget.controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                widget.controller.clear();
                widget.onClear?.call();
              },
              icon: const AppIcon(
                icon: AppIcons.clear,
                color: AppColors.textSecondaryColor,
                size: 20,
              ),
            ),
          if (widget.showFilterButton) ...[
            IconButton(
              onPressed: widget.onFilterTap,
              icon: const AppIcon(
                icon: AppIcons.tune,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
          ],
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }

  Widget _buildOutlinedSearchBar(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
        border: Border.all(
          color: _isFocused
              ? AppColors.primaryColor
              : (widget.borderColor ?? AppColors.borderColor),
          width: _isFocused ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          if (widget.leading != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: widget.leading,
            ),
          ] else ...[
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.search,
                color: AppColors.textSecondaryColor,
                size: 20,
              ),
            ),
          ],
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppColors.textSecondaryColor,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
              ),
            ),
          ),
          if (widget.showClearButton && widget.controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                widget.controller.clear();
                widget.onClear?.call();
              },
              icon: const AppIcon(
                icon: AppIcons.clear,
                color: AppColors.textSecondaryColor,
                size: 20,
              ),
            ),
          if (widget.showFilterButton) ...[
            IconButton(
              onPressed: widget.onFilterTap,
              icon: const AppIcon(
                icon: AppIcons.tune,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
          ],
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }

  Widget _buildFilledSearchBar(bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            (isDark ? AppColors.darkSurface : AppColors.backgroundColor),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 8),
      ),
      child: Row(
        children: [
          if (widget.leading != null) ...[
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: widget.leading,
            ),
          ] else ...[
            const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.search,
                color: AppColors.textSecondaryColor,
                size: 20,
              ),
            ),
          ],
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppColors.textSecondaryColor,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
              ),
            ),
          ),
          if (widget.showClearButton && widget.controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                widget.controller.clear();
                widget.onClear?.call();
              },
              icon: const AppIcon(
                icon: AppIcons.clear,
                color: AppColors.textSecondaryColor,
                size: 20,
              ),
            ),
          if (widget.showFilterButton) ...[
            IconButton(
              onPressed: widget.onFilterTap,
              icon: const AppIcon(
                icon: AppIcons.tune,
                color: AppColors.primaryColor,
                size: 20,
              ),
            ),
          ],
          if (widget.trailing != null) widget.trailing!,
        ],
      ),
    );
  }

  Widget _buildCompactSearchBar(bool isDark) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: widget.backgroundColor ??
            (isDark ? AppColors.darkSurface : AppColors.backgroundColor),
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 18),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: AppIcon(
              icon: AppIcons.search,
              color: AppColors.textSecondaryColor,
              size: 16,
            ),
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppColors.textSecondaryColor,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
              ),
            ),
          ),
          if (widget.showClearButton && widget.controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                widget.controller.clear();
                widget.onClear?.call();
              },
              icon: const AppIcon(
                icon: AppIcons.clear,
                color: AppColors.textSecondaryColor,
                size: 16,
              ),
              padding: const EdgeInsets.all(8),
              constraints: const BoxConstraints(
                minWidth: 32,
                minHeight: 32,
              ),
            ),
        ],
      ),
    );
  }
}

/// Specialized search bar for app bar
class AppBarSearchBar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onClear;
  final bool showFilterButton;
  final VoidCallback? onFilterTap;

  const AppBarSearchBar({
    super.key,
    this.hintText = 'Search...',
    required this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.showFilterButton = false,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppSearchBar(
      hintText: hintText,
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      onClear: onClear,
      showFilterButton: showFilterButton,
      onFilterTap: onFilterTap,
      variant: AppSearchBarVariant.filledBar,
      height: 40,
    );
  }
}

/// Specialized search bar with suggestions
class AppSearchBarWithSuggestions extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final List<String> suggestions;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function(String)? onSuggestionTap;
  final VoidCallback? onClear;
  final bool showSuggestions;
  final int maxSuggestions;

  const AppSearchBarWithSuggestions({
    super.key,
    this.hintText = 'Search...',
    required this.controller,
    this.suggestions = const [],
    this.onChanged,
    this.onSubmitted,
    this.onSuggestionTap,
    this.onClear,
    this.showSuggestions = true,
    this.maxSuggestions = 5,
  });

  @override
  State<AppSearchBarWithSuggestions> createState() =>
      _AppSearchBarWithSuggestionsState();
}

class _AppSearchBarWithSuggestionsState
    extends State<AppSearchBarWithSuggestions> {
  List<String> _filteredSuggestions = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.showSuggestions) {
      setState(() {
        _filteredSuggestions = widget.suggestions
            .where((suggestion) => suggestion
                .toLowerCase()
                .contains(widget.controller.text.toLowerCase()))
            .take(widget.maxSuggestions)
            .toList();
        _showSuggestions = widget.controller.text.isNotEmpty &&
            _filteredSuggestions.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSearchBar(
          hintText: widget.hintText,
          controller: widget.controller,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          onClear: widget.onClear,
        ),
        if (_showSuggestions && _filteredSuggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: _filteredSuggestions.map((suggestion) {
                return InkWell(
                  onTap: () {
                    widget.controller.text = suggestion;
                    widget.onSuggestionTap?.call(suggestion);
                    setState(() {
                      _showSuggestions = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const AppIcon(
                          icon: AppIcons.history,
                          color: AppColors.textSecondaryColor,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: AppText(
                            suggestion,
                            color: AppColors.textPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}

/// Search bar variants
enum AppSearchBarVariant {
  defaultBar,
  outlinedBar,
  filledBar,
  compactBar,
}
