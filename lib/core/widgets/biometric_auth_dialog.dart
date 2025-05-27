import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/core/services/navigation_service.dart';
import '../services/biometric_service.dart';

class BiometricAuthDialog extends StatefulWidget {
  final String title;
  final String message;
  final VoidCallback? onSuccess;
  final VoidCallback? onFailure;
  final bool showCancelButton;

  const BiometricAuthDialog({
    super.key,
    this.title = 'Biometric Authentication',
    this.message = 'Please authenticate to continue',
    this.onSuccess,
    this.onFailure,
    this.showCancelButton = true,
  });

  @override
  State<BiometricAuthDialog> createState() => _BiometricAuthDialogState();
}

class _BiometricAuthDialogState extends State<BiometricAuthDialog> {
  final _biometricService = BiometricService();
  bool _isAuthenticating = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    final isAvailable = await _biometricService.isBiometricsAvailable();
    if (!isAvailable) {
      setState(() {
        _errorMessage = 'Device does not support biometric authentication';
      });
    } else {
      _authenticate();
    }
  }

  Future<void> _authenticate() async {
    if (_isAuthenticating) return; // Prevent multiple calls

    _updateState(isAuthenticating: true, errorMessage: null);

    try {
      final success = await _biometricService.authenticate(
        localizedReason: widget.message,
      );

      if (success) {
        widget.onSuccess?.call();
        if (mounted) context.nav.pop(context, true);
      } else {
        _updateState(errorMessage: 'Authentication failed');
        widget.onFailure?.call();
      }
    } on Exception catch (e) {
      _updateState(errorMessage: 'Error: ${e.toString()}');
      widget.onFailure?.call();
    } finally {
      if (mounted) {
        _updateState(isAuthenticating: false);
      }
    }
  }

  void _updateState({bool? isAuthenticating, String? errorMessage}) {
    if (!mounted) return;
    setState(() {
      if (isAuthenticating != null) _isAuthenticating = isAuthenticating;
      if (errorMessage != null) _errorMessage = errorMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_isAuthenticating)
            const CircularProgressIndicator()
          else if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            )
          else
            Text(widget.message),
        ],
      ),
      actions: [
        if (widget.showCancelButton)
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
        if (!_isAuthenticating && _errorMessage != null)
          TextButton(
            onPressed: _authenticate,
            child: const Text('Try again'),
          ),
      ],
    );
  }
} 