import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/theme/colors.dart';
import 'package:flutter_starter_kit/core/theme/sizes.dart';
import 'package:flutter_starter_kit/core/theme/text_styles.dart';

class AppDropdownField<T> extends StatelessWidget {
  final List<T> items;
  final T? value;
  final String? hintText;
  final String? labelText;
  final String? Function(T?)? validator;
  final String? requiredValidationMessage;
  final void Function(T?)? onChanged;
  final bool isRequired;
  final bool isExpanded;
  final Widget Function(T)? itemBuilder;
  final Color? dropdownColor;
  final Widget? dropdownIcon;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? iconSize;
  final bool isCompactMode;
  final bool readOnly;
  final InputDecoration? decoration;
  final double? width;
  final double? height;

  const AppDropdownField({
    super.key,
    required this.items,
    this.value,
    this.hintText,
    this.labelText,
    this.validator,
    this.requiredValidationMessage,
    this.onChanged,
    this.isRequired = false,
    this.isExpanded = true,
    this.itemBuilder,
    this.dropdownColor,
    this.dropdownIcon,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.iconSize,
    this.isCompactMode = true,
    this.readOnly = false,
    this.decoration,
    this.width,
    this.height,
  });

  String _defaultItemToString(T item) {
    return item.toString();
  }

  String? _defaultValidator(T? value) {
    if (isRequired && value == null) {
      return requiredValidationMessage ?? 'Please select a value';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: DropdownButtonFormField<T>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: itemBuilder != null 
              ? itemBuilder!(item) 
              : Text(
                  _defaultItemToString(item),
                  overflow: TextOverflow.ellipsis,
                ),
          );
        }).toList(),
        onChanged: readOnly ? null : onChanged,
        validator: validator ?? _defaultValidator,
        decoration: decoration ?? InputDecoration(
          hintText: hintText,
          labelText: labelText,
          border: const OutlineInputBorder(
            borderRadius: AppSizes.borderRadiusMedium,
            borderSide: BorderSide(color: AppColors.greyColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: AppSizes.borderRadiusMedium,
            borderSide: BorderSide(
              color: AppColors.greyColor,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: AppSizes.borderRadiusMedium,
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 2.0,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
        dropdownColor: dropdownColor,
        icon: dropdownIcon,
        iconEnabledColor: iconEnabledColor ?? AppColors.primaryColor,
        iconDisabledColor: iconDisabledColor,
        iconSize: iconSize ?? 24,
        isDense: isCompactMode,
        isExpanded: isExpanded,
        style: AppTextStyles.bodyStyle(),
      ),
    );
  }
}
