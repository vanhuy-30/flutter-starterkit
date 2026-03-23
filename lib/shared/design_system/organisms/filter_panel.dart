import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/buttons/app_button.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_icon.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';

/// Filter Panel
/// Advanced filtering panel with multiple filter options
class FilterPanel extends StatefulWidget {
  final List<FilterGroup> filterGroups;
  final Map<String, dynamic> initialFilters;
  final void Function(Map<String, dynamic>)? onFiltersChanged;
  final VoidCallback? onApply;
  final VoidCallback? onReset;
  final VoidCallback? onClose;
  final String title;
  final bool showResetButton;
  final bool showApplyButton;

  const FilterPanel({
    super.key,
    required this.filterGroups,
    this.initialFilters = const {},
    this.onFiltersChanged,
    this.onApply,
    this.onReset,
    this.onClose,
    this.title = 'Filter',
    this.showResetButton = true,
    this.showApplyButton = true,
  });

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  late Map<String, dynamic> _filters;

  @override
  void initState() {
    super.initState();
    _filters = Map.from(widget.initialFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildContent(),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        children: [
          Expanded(
            child: AppAutoSizeText(
              widget.title,
              fontWeight: FontWeight.bold,
              maxFontSize: 18,
            ),
          ),
          if (widget.onClose != null)
            IconButton(
              onPressed: widget.onClose,
              icon: const AppIcon(
                icon: AppIcons.close,
                color: AppColors.textSecondaryColor,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Flexible(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: widget.filterGroups.map(_buildFilterGroup).toList(),
        ),
      ),
    );
  }

  Widget _buildFilterGroup(FilterGroup group) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          group.title,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimaryColor,
        ),
        const SizedBox(height: 12),
        ...group.filters.map(_buildFilterItem),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildFilterItem(FilterItem filter) {
    switch (filter.type) {
      case FilterType.checkbox:
        return _buildCheckboxFilter(filter);
      case FilterType.radio:
        return _buildRadioFilter(filter);
      case FilterType.range:
        return _buildRangeFilter(filter);
      case FilterType.chip:
        return _buildChipFilter(filter);
    }
  }

  Widget _buildCheckboxFilter(FilterItem filter) {
    return Column(
      children: filter.options.map((option) {
        final isSelected =
            (_filters[filter.key] as List?)?.contains(option.value) ?? false;
        return CheckboxListTile(
          title: AppText(option.label),
          value: isSelected,
          onChanged: (value) {
            setState(() {
              final isSelected = value ?? false;
              if (isSelected) {
                _filters[filter.key] = [
                  ...(_filters[filter.key] ?? []),
                  option.value
                ];
              } else {
                _filters[filter.key] = (_filters[filter.key] as List?)
                        ?.where((e) => e != option.value)
                        .toList() ??
                    [];
              }
              widget.onFiltersChanged?.call(_filters);
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRadioFilter(FilterItem filter) {
    return Column(
      children: filter.options.map((option) {
        return RadioListTile<String>(
          title: AppText(option.label),
          value: option.value,
          groupValue: _filters[filter.key],
          onChanged: (value) {
            setState(() {
              _filters[filter.key] = value;
              widget.onFiltersChanged?.call(_filters);
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRangeFilter(FilterItem filter) {
    return Column(
      children: [
        RangeSlider(
          values: RangeValues(
            _filters['${filter.key}_min']?.toDouble() ?? filter.minValue,
            _filters['${filter.key}_max']?.toDouble() ?? filter.maxValue,
          ),
          min: filter.minValue,
          max: filter.maxValue,
          divisions: filter.divisions,
          onChanged: (values) {
            setState(() {
              _filters['${filter.key}_min'] = values.start;
              _filters['${filter.key}_max'] = values.end;
              widget.onFiltersChanged?.call(_filters);
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppText(
                '${_filters['${filter.key}_min']?.toInt() ?? filter.minValue.toInt()}'),
            AppText(
                '${_filters['${filter.key}_max']?.toInt() ?? filter.maxValue.toInt()}'),
          ],
        ),
      ],
    );
  }

  Widget _buildChipFilter(FilterItem filter) {
    return Wrap(
      spacing: 8,
      children: filter.options.map((option) {
        final isSelected =
            _filters[filter.key]?.contains(option.value) ?? false;
        return FilterChip(
          label: AppText(option.label),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _filters[filter.key] = [
                  ...(_filters[filter.key] ?? []),
                  option.value
                ];
              } else {
                _filters[filter.key] = (_filters[filter.key] as List?)
                        ?.where((e) => e != option.value)
                        .toList() ??
                    [];
              }
              widget.onFiltersChanged?.call(_filters);
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildActions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        children: [
          if (widget.showResetButton) ...[
            Expanded(
              child: AppButton(
                text: 'Reset',
                onPressed: _resetFilters,
                color: AppColors.textSecondaryColor,
              ),
            ),
            const SizedBox(width: 16),
          ],
          if (widget.showApplyButton)
            Expanded(
              child: AppButton(
                text: 'Apply',
                onPressed: widget.onApply ?? () {},
              ),
            ),
        ],
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _filters = {};
      widget.onReset?.call();
    });
  }
}

/// Filter group model
class FilterGroup {
  final String title;
  final List<FilterItem> filters;

  const FilterGroup({
    required this.title,
    required this.filters,
  });
}

/// Filter item model
class FilterItem {
  final String key;
  final String title;
  final FilterType type;
  final List<FilterOption> options;
  final double minValue;
  final double maxValue;
  final int? divisions;

  const FilterItem({
    required this.key,
    required this.title,
    required this.type,
    required this.options,
    this.minValue = 0,
    this.maxValue = 100,
    this.divisions,
  });
}

/// Filter option model
class FilterOption {
  final String value;
  final String label;

  const FilterOption({
    required this.value,
    required this.label,
  });
}

/// Filter types
enum FilterType {
  checkbox,
  radio,
  range,
  chip,
}
