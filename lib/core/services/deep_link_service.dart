import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import '../configs/deep_link_config.dart';

class DeepLinkService {
  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  final _deepLinkController = StreamController<Map<String, dynamic>>.broadcast();
  StreamSubscription? _subscription;
  bool _isInitialized = false;

  // Stream to listen to deep links
  Stream<Map<String, dynamic>> get deepLinkStream => _deepLinkController.stream;

  // Initialize service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Listen to deep links when app is running
      _subscription = AppLinks().uriLinkStream.listen((Uri? uri) {
        if (uri != null) {
          _handleDeepLink(uri.toString());
        }
      }, onError: (err) {
        debugPrint('Deep link error: $err');
      });

      // Check deep link when app is opened from link
      final initialLink = await AppLinks().getInitialLink();
      if (initialLink != null) {
        _handleDeepLink(initialLink.toString());
      }

      _isInitialized = true;
    } catch (e) {
      debugPrint('Failed to initialize deep links: $e');
    }
  }

  // Handle deep link
  void _handleDeepLink(String? link) {
    if (link == null) return;

    final parsedData = DeepLinkConfig.parseDeepLink(link);
    if (parsedData != null) {
      _deepLinkController.add(parsedData);
    }
  }

  // Create deep link
  String createDeepLink({
    required String path,
    Map<String, String>? queryParams,
  }) {
    return DeepLinkConfig.createDeepLink(
      path: path,
      queryParams: queryParams,
    );
  }

  // Dispose service
  void dispose() {
    _subscription?.cancel();
    _deepLinkController.close();
  }
} 