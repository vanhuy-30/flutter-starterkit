import '../../core/services/cache_service.dart';

mixin CacheMixin {
  final _cacheService = CacheService();

  // Cache data with key
  Future<void> cacheData({
    required String key,
    required dynamic value,
    Duration? expiration,
  }) async {
    await _cacheService.setData(
      key: key,
      value: value,
      expiration: expiration,
    );
  }

  // Get cached data
  Future<T?> getCachedData<T>({
    required String key,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _cacheService.getData<T>(
      key: key,
      fromJson: fromJson,
    );
  }

  // Remove cached data
  Future<void> removeCachedData(String key) async {
    await _cacheService.removeData(key);
  }

  // Clear all cached data
  Future<void> clearCache() async {
    await _cacheService.clearCache();
  }

  // Check if data is cached
  Future<bool> hasCachedData(String key) async {
    return _cacheService.hasKey(key);
  }

  // Get cache size
  Future<int> getCacheSize() async {
    return _cacheService.getCacheSize();
  }

  // Get all cached keys
  Future<List<String>> getAllCachedKeys() async {
    return _cacheService.getAllKeys();
  }
}
