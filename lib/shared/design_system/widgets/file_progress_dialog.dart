import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class FileProgressDialog extends StatelessWidget {
  final String title;
  final String message;
  final double progress;
  final bool isUploading;
  final VoidCallback? onCancel;

  const FileProgressDialog({
    super.key,
    required this.title,
    required this.message,
    required this.progress,
    this.isUploading = true,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              isUploading ? Colors.blue : Colors.green,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${(progress * 100).toStringAsFixed(1)}%',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        if (onCancel != null)
          TextButton(
            onPressed: onCancel,
            child: Text('cancel'.tr()),
          ),
      ],
    );
  }
}
