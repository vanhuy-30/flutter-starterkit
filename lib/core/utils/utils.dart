import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

/// Displays a SnackBar with a custom message and optional styling.
void showAppSnackBar(BuildContext context, String message,
    {Color backgroundColor = Colors.black, Duration duration = const Duration(seconds: 2)}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: duration,
    ),
  );
}

/// Shows a simple AlertDialog with a title, content, and confirmation button.
Future<void> showAppDialog({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = 'OK',
  VoidCallback? onConfirm,
}) {
  return showDialog<void>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            if (onConfirm != null) onConfirm();
          },
          child: Text(confirmText),
        )
      ],
    ),
  );
}

/// Displays a customizable bottom sheet with the provided child widget.
Future<void> showAppBottomSheet({
  required BuildContext context,
  required Widget child,
  bool isDismissible = true,
  bool enableDrag = true,
  double? maxHeight,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => Container(
      constraints: BoxConstraints(maxHeight: maxHeight ?? 400),
      padding: const EdgeInsets.all(16),
      child: child,
    ),
  );
}

/// Opens a date picker dialog to select a single date.
/// Returns the selected date or null if cancelled.
Future<DateTime?> pickSingleDate({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  String title = 'Select a date',
}) async {
  final results = await showDialog<List<DateTime?>>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: SizedBox(
        height: 300,
        child: CalendarDatePicker2WithActionButtons(
          config: CalendarDatePicker2WithActionButtonsConfig(
            calendarType: CalendarDatePicker2Type.single,
            firstDate: firstDate ?? DateTime(2000),
            lastDate: lastDate ?? DateTime(2100),
          ),
          value: [initialDate ?? DateTime.now()],
          onValueChanged: (dates) {},
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, [
            ...[initialDate ?? DateTime.now()]
          ]),
          child: const Text('Select'),
        ),
      ],
    ),
  );
  return results?.first;
}

/// Opens a date range picker dialog.
/// Returns a list of two dates [start, end] or an empty list if cancelled.
Future<List<DateTime?>> pickDateRange({
  required BuildContext context,
  List<DateTime?>? initialDates,
  DateTime? firstDate,
  DateTime? lastDate,
  String title = 'Select date range',
}) async {
  final results = await showDialog<List<DateTime?>>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(title),
      content: SizedBox(
        height: 300,
        child: CalendarDatePicker2WithActionButtons(
          config: CalendarDatePicker2WithActionButtonsConfig(
            calendarType: CalendarDatePicker2Type.range,
            firstDate: firstDate ?? DateTime(2000),
            lastDate: lastDate ?? DateTime(2100),
          ),
          value: initialDates ?? [],
          onValueChanged: (dates) {},
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, initialDates),
          child: const Text('Select'),
        ),
      ],
    ),
  );
  return results ?? [];
}
