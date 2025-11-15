import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/buttons/app_button.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/buttons/app_text_button.dart';
import 'package:flutter_starter_kit/shared/design_system/theme/app_colors.dart';
import 'package:flutter_starter_kit/shared/design_system/atoms/app_text.dart';

/// App Form Controller
/// Manages form state, validation, and submission
class AppFormController {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  final Map<String, String?> _errors = {};
  bool _isLoading = false;
  String? _globalError;

  GlobalKey<FormState> get formKey => _formKey;
  Map<String, TextEditingController> get controllers => _controllers;
  Map<String, String?> get errors => _errors;
  bool get isLoading => _isLoading;
  String? get globalError => _globalError;

  /// Add a controller for a field
  void addController(String fieldName, TextEditingController controller) {
    _controllers[fieldName] = controller;
  }

  /// Get controller for a field
  TextEditingController? getController(String fieldName) {
    return _controllers[fieldName];
  }

  /// Set error for a specific field
  void setFieldError(String fieldName, String? error) {
    _errors[fieldName] = error;
  }

  /// Get error for a specific field
  String? getFieldError(String fieldName) {
    return _errors[fieldName];
  }

  /// Clear all field errors
  void clearFieldErrors() {
    _errors.clear();
  }

  /// Set global error message
  set setGlobalError(String? error) {
    _globalError = error;
  }

  /// Set loading state
  set setLoading(bool loading) {
    _isLoading = loading;
  }

  /// Validate form
  bool validate() {
    clearFieldErrors();
    return _formKey.currentState?.validate() ?? false;
  }

  /// Get form data as Map
  Map<String, String> getFormData() {
    final Map<String, String> data = {};
    _controllers.forEach((key, controller) {
      data[key] = controller.text;
    });
    return data;
  }

  /// Reset form
  void reset() {
    _formKey.currentState?.reset();
    _controllers.forEach((key, controller) {
      controller.clear();
    });
    clearFieldErrors();
    _globalError = null;
    _isLoading = false;
  }

  /// Dispose all controllers
  /// NOTE: Only call this if AppFormController owns the controllers
  void dispose() {
    // Do not dispose controllers here as they may be owned by external widgets
    // Controllers should be disposed by their owner widgets
    _controllers.clear();
    _errors.clear();
  }
}

/// Global Error Widget
/// Displays global error message for the form
class GlobalErrorWidget extends StatelessWidget {
  final String? errorMessage;

  const GlobalErrorWidget({
    super.key,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (errorMessage == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.errorColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.errorColor.withValues(alpha: 0.3),
        ),
      ),
      child: AppText(
        errorMessage!,
        color: AppColors.errorColor,
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Form Fields Widget
/// Renders form fields with proper spacing
class FormFieldsWidget extends StatelessWidget {
  final List<Widget> children;
  final double fieldSpacing;

  const FormFieldsWidget({
    super.key,
    required this.children,
    this.fieldSpacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final List<Widget> widgets = [];

    for (int i = 0; i < children.length; i++) {
      widgets.add(children[i]);

      // Add spacing between fields (except for the last one)
      if (i < children.length - 1) {
        widgets.add(SizedBox(height: fieldSpacing));
      }
    }

    return Column(children: widgets);
  }
}

/// Submit Button Widget
/// Renders submit button with loading state
class SubmitButtonWidget extends StatelessWidget {
  final String submitButtonText;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final ButtonStyle? buttonStyle;
  final Widget? customButton;

  const SubmitButtonWidget({
    super.key,
    required this.submitButtonText,
    this.onPressed,
    this.isDisabled = false,
    this.buttonStyle,
    this.customButton,
  });

  @override
  Widget build(BuildContext context) {
    if (customButton != null) {
      return customButton!;
    }

    return AppButton(
      text: submitButtonText,
      onPressed: !isDisabled ? onPressed : null,
      isDisabled: isDisabled,
      color:
          buttonStyle?.backgroundColor?.resolve({}) ?? AppColors.primaryColor,
      textColor: buttonStyle?.foregroundColor?.resolve({}) ?? Colors.white,
    );
  }
}

/// Cancel Button Widget
/// Renders cancel button
class CancelButtonWidget extends StatelessWidget {
  final String cancelButtonText;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final ButtonStyle? buttonStyle;
  final Widget? customButton;

  const CancelButtonWidget({
    super.key,
    required this.cancelButtonText,
    this.onPressed,
    this.isDisabled = false,
    this.buttonStyle,
    this.customButton,
  });

  @override
  Widget build(BuildContext context) {
    if (customButton != null) {
      return customButton!;
    }

    return AppTextButton(
      label: cancelButtonText,
      onPressed: !isDisabled ? (onPressed ?? () {}) : () {},
      textColor: AppColors.textSecondaryColor,
    );
  }
}

/// App Form
/// A comprehensive form widget with validation, loading states, and error handling
class AppForm extends StatefulWidget {
  /// Form controller for managing form state
  final AppFormController? controller;

  /// List of form fields
  final List<Widget> children;

  /// Submit button text
  final String submitButtonText;

  /// Submit button callback
  final Future<void> Function(Map<String, String>)? onSubmit;

  /// Cancel button text (optional)
  final String? cancelButtonText;

  /// Cancel button callback (optional)
  final VoidCallback? onCancel;

  /// Additional widgets to display above submit button
  final List<Widget>? extraWidgets;

  /// Additional widgets to display below submit button
  final List<Widget>? bottomWidgets;

  /// Form padding
  final EdgeInsetsGeometry? padding;

  /// Spacing between form fields
  final double fieldSpacing;

  /// Submit button style
  final ButtonStyle? submitButtonStyle;

  /// Cancel button style
  final ButtonStyle? cancelButtonStyle;

  /// Whether to show loading indicator
  final bool showLoadingIndicator;

  /// Loading indicator widget
  final Widget? loadingIndicator;

  /// Global error message
  final String? globalError;

  /// Whether form is enabled
  final bool enabled;

  /// Form validation mode
  final AutovalidateMode autovalidateMode;

  /// Custom submit button widget
  final Widget? customSubmitButton;

  /// Custom cancel button widget
  final Widget? customCancelButton;

  const AppForm({
    super.key,
    this.controller,
    required this.children,
    required this.submitButtonText,
    this.onSubmit,
    this.cancelButtonText,
    this.onCancel,
    this.extraWidgets,
    this.bottomWidgets,
    this.padding,
    this.fieldSpacing = 16.0,
    this.submitButtonStyle,
    this.cancelButtonStyle,
    this.showLoadingIndicator = true,
    this.loadingIndicator,
    this.globalError,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.customSubmitButton,
    this.customCancelButton,
  });

  @override
  State<AppForm> createState() => _AppFormState();
}

class _AppFormState extends State<AppForm> {
  late AppFormController _formController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _formController = widget.controller ?? AppFormController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _formController.dispose();
    }
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!widget.enabled || _isSubmitting) return;

    if (!_formController.validate()) {
      return;
    }

    if (widget.onSubmit == null) return;

    setState(() {
      _isSubmitting = true;
    });

    _formController.setLoading = true;
    _formController.setGlobalError = null;

    try {
      await widget.onSubmit!(_formController.getFormData());
    } catch (e) {
      _formController.setGlobalError = e.toString();
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
      _formController.setLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formController.formKey,
      autovalidateMode: widget.autovalidateMode,
      child: Padding(
        padding: widget.padding ?? const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Global error message
            GlobalErrorWidget(
              errorMessage: widget.globalError ?? _formController.globalError,
            ),

            // Form fields
            FormFieldsWidget(
              fieldSpacing: widget.fieldSpacing,
              children: widget.children,
            ),

            // Extra widgets above submit button
            if (widget.extraWidgets != null) ...[
              const SizedBox(height: 8),
              ...widget.extraWidgets!,
            ],

            const SizedBox(height: 16),

            // Submit button
            SubmitButtonWidget(
              submitButtonText: widget.submitButtonText,
              onPressed:
                  widget.enabled && !_isSubmitting ? _handleSubmit : null,
              isDisabled: !widget.enabled || _isSubmitting,
              buttonStyle: widget.submitButtonStyle,
              customButton: widget.customSubmitButton,
            ),

            // Cancel button
            if (widget.cancelButtonText != null) ...[
              const SizedBox(height: 12),
              CancelButtonWidget(
                cancelButtonText: widget.cancelButtonText!,
                onPressed:
                    widget.enabled && !_isSubmitting ? widget.onCancel : null,
                isDisabled: !widget.enabled || _isSubmitting,
                buttonStyle: widget.cancelButtonStyle,
                customButton: widget.customCancelButton,
              ),
            ],

            // Bottom widgets
            if (widget.bottomWidgets != null) ...[
              const SizedBox(height: 16),
              ...widget.bottomWidgets!,
            ],
          ],
        ),
      ),
    );
  }
}

/// App Form Section
/// A section within a form with optional title and description
class AppFormSection extends StatelessWidget {
  final String? title;
  final String? description;
  final List<Widget> children;
  final EdgeInsetsGeometry? padding;
  final double spacing;

  const AppFormSection({
    super.key,
    this.title,
    this.description,
    required this.children,
    this.padding,
    this.spacing = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            AppText(
              title!,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimaryColor,
            ),
            const SizedBox(height: 8),
          ],
          if (description != null) ...[
            AppText(
              description!,
              color: AppColors.textSecondaryColor,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
          ],
          FormFieldsWidget(
            fieldSpacing: spacing,
            children: children,
          ),
        ],
      ),
    );
  }
}

/// App Form Row
/// A row of form fields with equal spacing
class AppFormRow extends StatelessWidget {
  final List<Widget> children;
  final double spacing;
  final CrossAxisAlignment crossAxisAlignment;

  const AppFormRow({
    super.key,
    required this.children,
    this.spacing = 12.0,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    final List<Widget> widgets = [];

    for (int i = 0; i < children.length; i++) {
      widgets.add(Expanded(child: children[i]));

      if (i < children.length - 1) {
        widgets.add(SizedBox(width: spacing));
      }
    }

    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: widgets,
    );
  }
}
