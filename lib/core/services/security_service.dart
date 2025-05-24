import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

class SecurityService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final LocalAuthentication _localAuth = LocalAuthentication();
  
  // Rate limiting
  final Map<String, List<DateTime>> _attempts = {};
  final int _maxAttempts = 5;
  final Duration _lockoutDuration = const Duration(minutes: 15);
  
  // Encryption key (in production, this should be stored securely)
  static const String _encryptionKey = 'your-32-char-encryption-key-here';
  
  // Secure storage operations
  Future<void> saveSecureData(String key, String value) async {
    try {
      final encryptedValue = encryptData(value);
      await _secureStorage.write(key: key, value: encryptedValue);
    } catch (e) {
      debugPrint('Failed to save secure data: $e');
      rethrow;
    }
  }

  Future<String?> getSecureData(String key) async {
    try {
      final encryptedValue = await _secureStorage.read(key: key);
      if (encryptedValue == null) return null;
      return decryptData(encryptedValue);
    } catch (e) {
      debugPrint('Failed to get secure data: $e');
      rethrow;
    }
  }

  Future<void> deleteSecureData(String key) async {
    try {
      await _secureStorage.delete(key: key);
    } catch (e) {
      debugPrint('Failed to delete secure data: $e');
      rethrow;
    }
  }

  // Token management
  Future<void> saveAuthToken(String token) async {
    await saveSecureData('auth_token', token);
  }

  Future<String?> getAuthToken() async {
    return await getSecureData('auth_token');
  }

  Future<void> deleteAuthToken() async {
    await deleteSecureData('auth_token');
  }

  // Token validation
  bool isTokenValid(String token) {
    try {
      return !JwtDecoder.isExpired(token);
    } catch (e) {
      debugPrint('Failed to validate token: $e');
      return false;
    }
  }

  // Password hashing with salt
  String hashPassword(String password) {
    try {
      final salt = _generateSalt();
      final bytes = utf8.encode(password + salt);
      final digest = sha256.convert(bytes);
      return '$salt:${digest.toString()}';
    } catch (e) {
      debugPrint('Failed to hash password: $e');
      rethrow;
    }
  }

  String _generateSalt() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    final bytes = utf8.encode(random);
    return sha256.convert(bytes).toString().substring(0, 16);
  }

  // Data encryption using AES
  String encryptData(String data) {
    try {
      final key = _encryptionKey.padRight(32).substring(0, 32);
      final iv = _generateIV();
      final encrypted = _aesEncrypt(data, key, iv);
      return '$iv:$encrypted';
    } catch (e) {
      debugPrint('Failed to encrypt data: $e');
      rethrow;
    }
  }

  String _generateIV() {
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    final bytes = utf8.encode(random);
    return sha256.convert(bytes).toString().substring(0, 16);
  }

  String _aesEncrypt(String data, String key, String iv) {
    // Implement AES encryption here
    // This is a placeholder - you should use proper AES encryption
    return base64Encode(utf8.encode(data));
  }

  // Data decryption
  String decryptData(String encryptedData) {
    try {
      final parts = encryptedData.split(':');
      if (parts.length != 2) throw Exception('Invalid encrypted data format');
      
      final iv = parts[0];
      final encrypted = parts[1];
      final key = _encryptionKey.padRight(32).substring(0, 32);
      
      return _aesDecrypt(encrypted, key, iv);
    } catch (e) {
      debugPrint('Failed to decrypt data: $e');
      rethrow;
    }
  }

  String _aesDecrypt(String encrypted, String key, String iv) {
    // Implement AES decryption here
    // This is a placeholder - you should use proper AES decryption
    return utf8.decode(base64Decode(encrypted));
  }

  // Input validation
  bool isValidEmail(String email) {
    try {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      return emailRegex.hasMatch(email);
    } catch (e) {
      debugPrint('Failed to validate email: $e');
      return false;
    }
  }

  bool isValidPassword(String password) {
    try {
      // Password should be at least 8 characters long
      // and contain at least one uppercase letter, one lowercase letter,
      // one number and one special character
      final passwordRegex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
      );
      return passwordRegex.hasMatch(password);
    } catch (e) {
      debugPrint('Failed to validate password: $e');
      return false;
    }
  }

  // Rate limiting
  bool isRateLimited(String key) {
    final now = DateTime.now();
    _attempts[key] ??= [];
    
    // Remove old attempts
    _attempts[key]!.removeWhere(
      (attempt) => now.difference(attempt) > _lockoutDuration,
    );
    
    return _attempts[key]!.length >= _maxAttempts;
  }

  void recordAttempt(String key) {
    _attempts[key] ??= [];
    _attempts[key]!.add(DateTime.now());
  }

  Duration getRemainingLockoutTime(String key) {
    if (!isRateLimited(key)) return Duration.zero;
    
    final oldestAttempt = _attempts[key]!.reduce(
      (a, b) => a.isBefore(b) ? a : b,
    );
    
    final lockoutEnd = oldestAttempt.add(_lockoutDuration);
    final now = DateTime.now();
    
    return lockoutEnd.isAfter(now)
        ? lockoutEnd.difference(now)
        : Duration.zero;
  }

  // Biometric authentication
  Future<bool> authenticateWithBiometrics() async {
    try {
      if (isRateLimited('biometric')) {
        debugPrint('Biometric authentication is rate limited');
        return false;
      }

      final canCheckBiometrics = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();

      if (!canCheckBiometrics || !isDeviceSupported) {
        return false;
      }

      final result = await _localAuth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (!result) {
        recordAttempt('biometric');
      }

      return result;
    } catch (e) {
      debugPrint('Failed to authenticate with biometrics: $e');
      recordAttempt('biometric');
      return false;
    }
  }

  // Certificate pinning
  Future<bool> validateCertificate(String certificate) async {
    try {
      // Implement certificate pinning logic here
      // This is platform specific and might require native code
      return false;
    } catch (e) {
      debugPrint('Failed to validate certificate: $e');
      return false;
    }
  }

  // Check available biometric types
  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      debugPrint('Failed to get available biometrics: $e');
      return [];
    }
  }

  // Check if device supports biometrics
  Future<bool> isBiometricsSupported() async {
    try {
      return await _localAuth.isDeviceSupported();
    } catch (e) {
      debugPrint('Failed to check biometrics support: $e');
      return false;
    }
  }
} 