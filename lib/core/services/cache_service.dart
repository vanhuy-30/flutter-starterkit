import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

/// Custom exceptions for cache operations
class CacheException implements Exception {
  final String message;
  final dynamic error;

  CacheException(this.message, [this.error]);

  @override
  String toString() => 'CacheException: $message${error != null ? ' ($error)' : ''}';
}

class CacheService {
  static final CacheService _instance = CacheService._internal();
  factory CacheService() => _instance;
  CacheService._internal();

  static const String _cacheBoxName = 'app_cache';
  static const Duration _defaultExpiration = Duration(days: 7);
  static const int _maxCacheSize = 1000; // Maximum number of items in cache
  
  @protected
  late Box _cacheBox;
  
  @protected
  bool _isInitialized = false;

  // Initialize cache service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final cacheDir = await getApplicationSupportDirectory();
      
      // Initialize Hive
      Hive.init(cacheDir.path);
      
      // Open cache box
      _cacheBox = await Hive.openBox(_cacheBoxName);
      _isInitialized = true;
      
      // Start cache cleanup
      _startCacheCleanup();
      
      debugPrint('Cache service initialized successfully');
    } catch (e) {
      throw CacheException('Failed to initialize cache service', e);
    }
  }

  // Start periodic cache cleanup
  void _startCacheCleanup() {
    // Clean up expired items every hour
    Future.delayed(const Duration(hours: 1), () {
      _cleanupExpiredItems();
      _startCacheCleanup();
    });
  }

  // Clean up expired items
  Future<void> _cleanupExpiredItems() async {
    try {
      final keys = _cacheBox.keys.toList();
      for (final key in keys) {
        final cachedString = _cacheBox.get(key);
        if (cachedString != null) {
          try {
            final cacheData = CacheData.fromJson(jsonDecode(cachedString));
            if (cacheData.isExpired) {
              await _cacheBox.delete(key);
            }
          } catch (e) {
            // Invalid cache data, remove it
            await _cacheBox.delete(key);
          }
        }
      }
    } catch (e) {
      debugPrint('Error cleaning up expired items: $e');
    }
  }

  // Save data to cache
  Future<void> setData<T>({
    required String key,
    required T value,
    Duration? expiration,
  }) async {
    if (!_isInitialized) await initialize();

    try {
      // Check cache size
      if (_cacheBox.length >= _maxCacheSize) {
        await _removeOldestItem();
      }

      final cacheData = CacheData<T>(
        value: value,
        timestamp: DateTime.now(),
        expiration: expiration ?? _defaultExpiration,
      );

      await _cacheBox.put(key, jsonEncode(cacheData.toJson()));
    } catch (e) {
      throw CacheException('Failed to save data to cache', e);
    }
  }

  // Remove oldest item from cache
  Future<void> _removeOldestItem() async {
    try {
      String? oldestKey;
      DateTime? oldestTimestamp;

      for (final key in _cacheBox.keys) {
        final cachedString = _cacheBox.get(key);
        if (cachedString != null) {
          try {
            final cacheData = CacheData.fromJson(jsonDecode(cachedString));
            if (oldestTimestamp == null || cacheData.timestamp.isBefore(oldestTimestamp)) {
              oldestKey = key.toString();
              oldestTimestamp = cacheData.timestamp;
            }
          } catch (e) {
            // Invalid cache data, remove it
            await _cacheBox.delete(key);
          }
        }
      }

      if (oldestKey != null) {
        await _cacheBox.delete(oldestKey);
      }
    } catch (e) {
      debugPrint('Error removing oldest item: $e');
    }
  }

  // Get data from cache
  Future<T?> getData<T>({
    required String key,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    if (!_isInitialized) await initialize();

    try {
      final cachedString = _cacheBox.get(key);
      if (cachedString == null) return null;

      final cacheData = CacheData<T>.fromJson(jsonDecode(cachedString));
      
      // Check if data is expired
      if (cacheData.isExpired) {
        await _cacheBox.delete(key);
        return null;
      }

      if (fromJson != null) {
        return fromJson(cacheData.value as Map<String, dynamic>);
      }
      
      return cacheData.value as T;
    } catch (e) {
      debugPrint('Error getting data from cache: $e');
      return null;
    }
  }

  // Remove data from cache
  Future<void> removeData(String key) async {
    if (!_isInitialized) await initialize();

    try {
      await _cacheBox.delete(key);
    } catch (e) {
      throw CacheException('Failed to remove data from cache', e);
    }
  }

  // Clear all cache
  Future<void> clearCache() async {
    if (!_isInitialized) await initialize();

    try {
      await _cacheBox.clear();
    } catch (e) {
      throw CacheException('Failed to clear cache', e);
    }
  }

  // Get cache size
  Future<int> getCacheSize() async {
    if (!_isInitialized) await initialize();

    try {
      return _cacheBox.length;
    } catch (e) {
      throw CacheException('Failed to get cache size', e);
    }
  }

  // Check if key exists in cache
  Future<bool> hasKey(String key) async {
    if (!_isInitialized) await initialize();

    try {
      return _cacheBox.containsKey(key);
    } catch (e) {
      throw CacheException('Failed to check key existence', e);
    }
  }

  // Get all keys in cache
  Future<List<String>> getAllKeys() async {
    if (!_isInitialized) await initialize();

    try {
      return _cacheBox.keys.map((key) => key.toString()).toList();
    } catch (e) {
      throw CacheException('Failed to get all keys', e);
    }
  }

  // Close cache box
  Future<void> close() async {
    if (!_isInitialized) return;

    try {
      await _cacheBox.close();
      _isInitialized = false;
    } catch (e) {
      throw CacheException('Failed to close cache box', e);
    }
  }
}

class CacheData<T> {
  final T value;
  final DateTime timestamp;
  final Duration expiration;

  CacheData({
    required this.value,
    required this.timestamp,
    required this.expiration,
  });

  bool get isExpired {
    return DateTime.now().difference(timestamp) > expiration;
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'timestamp': timestamp.toIso8601String(),
      'expiration': expiration.inSeconds,
    };
  }

  factory CacheData.fromJson(Map<String, dynamic> json) {
    return CacheData<T>(
      value: json['value'] as T,
      timestamp: DateTime.parse(json['timestamp']),
      expiration: Duration(seconds: json['expiration']),
    );
  }
} 