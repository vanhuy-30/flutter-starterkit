class DeepLinkConfig {
  // Scheme for deep links
  static const String scheme = 'flutterstarterkit';

  // Host for deep links
  static const String host = 'flutterstarterkit.com';

  // Path patterns
  static const String homePath = '/home';
  static const String profilePath = '/profile';
  static const String settingsPath = '/settings';
  static const String productPath = '/product';
  static const String categoryPath = '/category';
  static const String notificationPath = '/notification';

  // Query parameters
  static const String idParam = 'id';
  static const String typeParam = 'type';
  static const String sourceParam = 'source';

  // Create deep link URL
  static String createDeepLink({
    required String path,
    Map<String, String>? queryParams,
  }) {
    final uri = Uri(
      scheme: scheme,
      host: host,
      path: path,
      queryParameters: queryParams,
    );
    return uri.toString();
  }

  // Parse deep link URL to get path and query parameters
  static Map<String, dynamic>? parseDeepLink(String url) {
    try {
      final uri = Uri.parse(url);
      if (uri.scheme != scheme || uri.host != host) {
        return null;
      }

      return {
        'path': uri.path,
        'queryParams': uri.queryParameters,
      };
    } catch (e) {
      return null;
    }
  }
}
