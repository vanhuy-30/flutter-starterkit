import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_starter_kit/features/auth/domain/entities/user_entity.dart';
import 'dart:convert';

/// Secure storage service for sensitive data like tokens and user info
/// Uses Flutter Secure Storage for encrypted storage
class SecureStorageService {
  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.first_unlock_this_device,
    ),
  );

  // Keys for storage
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';

  /// Save access token
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  /// Get access token
  Future<String?> getAccessToken() async {
    return _storage.read(key: _accessTokenKey);
  }

  /// Save refresh token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return _storage.read(key: _refreshTokenKey);
  }

  /// Save user data
  Future<void> saveUserData(UserEntity user) async {
    final userJson = jsonEncode(user.toJson());
    await _storage.write(key: _userDataKey, value: userJson);
  }

  /// Get user data
  Future<UserEntity?> getUserData() async {
    final userJson = await _storage.read(key: _userDataKey);
    if (userJson == null) return null;

    try {
      final userMap = jsonDecode(userJson) as Map<String, dynamic>;
      return UserEntity.fromJson(userMap);
    } catch (e) {
      return null;
    }
  }

  /// Clear all stored data
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      // Also try to clear individual keys as backup
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);
      await _storage.delete(key: _userDataKey);
    } catch (e) {
      // If deleteAll fails, try individual deletions
      await _storage.delete(key: _accessTokenKey);
      await _storage.delete(key: _refreshTokenKey);
      await _storage.delete(key: _userDataKey);
    }
  }

  /// Clear specific token
  Future<void> clearAccessToken() async {
    await _storage.delete(key: _accessTokenKey);
  }

  /// Clear refresh token
  Future<void> clearRefreshToken() async {
    await _storage.delete(key: _refreshTokenKey);
  }

  /// Clear user data
  Future<void> clearUserData() async {
    await _storage.delete(key: _userDataKey);
  }

  /// Check if user has valid session
  Future<bool> hasValidSession() async {
    final accessToken = await getAccessToken();
    final userData = await getUserData();
    return accessToken != null && userData != null;
  }
}
