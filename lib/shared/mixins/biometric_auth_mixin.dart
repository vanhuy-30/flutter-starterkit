import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import '../../core/services/biometric_service.dart';
import '../design_system/widgets/biometric_auth_dialog.dart';

mixin BiometricAuthMixin {
  final _biometricService = BiometricService();

  // Show biometric auth dialog
  Future<bool> showBiometricAuth({
    required BuildContext context,
    String? title,
    String? message,
    VoidCallback? onSuccess,
    VoidCallback? onFailure,
    bool showCancelButton = true,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => BiometricAuthDialog(
        title: title ?? 'biometric_auth_title'.tr(),
        message: message ?? 'biometric_auth_message'.tr(),
        onSuccess: onSuccess,
        onFailure: onFailure,
        showCancelButton: showCancelButton,
      ),
    );
    return result ?? false;
  }

  // Check if device supports biometrics
  Future<bool> isBiometricsAvailable() async {
    return _biometricService.isBiometricsAvailable();
  }

  // Get available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return _biometricService.getAvailableBiometrics();
  }

  // Authenticate with biometrics
  Future<bool> authenticate({
    String? localizedReason,
  }) async {
    return _biometricService.authenticate(
      localizedReason: localizedReason ?? 'biometric_auth_message'.tr(),
    );
  }

  // Check if device has biometrics enrolled
  Future<bool> hasEnrolledBiometrics() async {
    return _biometricService.hasEnrolledBiometrics();
  }

  // Stop authentication
  Future<void> stopAuthentication() async {
    await _biometricService.stopAuthentication();
  }
}
