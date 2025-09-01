import 'package:flutter/material.dart';
import 'dart:async';

class AppLifecycleService {
  static final AppLifecycleService _instance = AppLifecycleService._internal();
  factory AppLifecycleService() => _instance;
  AppLifecycleService._internal();

  final _lifecycleController = StreamController<AppLifecycleState>.broadcast();
  StreamSubscription? _subscription;
  bool _isInitialized = false;

  // Stream to listen to lifecycle state
  Stream<AppLifecycleState> get lifecycleStream => _lifecycleController.stream;

  // Current state
  AppLifecycleState _currentState = AppLifecycleState.resumed;
  AppLifecycleState get currentState => _currentState;

  // Time app was in background
  DateTime? _backgroundTime;
  Duration? _backgroundDuration;

  // Initialize service
  void initialize(WidgetsBindingObserver observer) {
    if (_isInitialized) return;

    _subscription = _lifecycleController.stream.listen((state) {
      _currentState = state;
      _handleLifecycleState(state);
    });

    _isInitialized = true;
  }

  // Add new state to stream
  void addState(AppLifecycleState state) {
    _lifecycleController.add(state);
  }

  // Handle lifecycle state
  void _handleLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _handleAppResumed();
        break;
      case AppLifecycleState.inactive:
        _handleAppInactive();
        break;
      case AppLifecycleState.paused:
        _handleAppPaused();
        break;
      case AppLifecycleState.detached:
        _handleAppDetached();
        break;
      case AppLifecycleState.hidden:
        _handleAppHidden();
        break;
    }
  }

  // Handle app resumed
  void _handleAppResumed() {
    debugPrint('App resumed');
    if (_backgroundTime != null) {
      _backgroundDuration = DateTime.now().difference(_backgroundTime!);
      debugPrint('App was in background for: ${_backgroundDuration?.inSeconds} seconds');
      _backgroundTime = null;
    }
  }

  // Handle app inactive
  void _handleAppInactive() {
    debugPrint('App inactive');
  }

  // Handle app paused
  void _handleAppPaused() {
    debugPrint('App paused');
    _backgroundTime = DateTime.now();
  }

  // Handle app detached
  void _handleAppDetached() {
    debugPrint('App detached');
  }

  // Handle app hidden
  void _handleAppHidden() {
    debugPrint('App hidden');
  }

  // Check if app is in background
  bool get isInBackground => _currentState == AppLifecycleState.paused;

  // Check if app is active
  bool get isActive => _currentState == AppLifecycleState.resumed;

  // Get background duration
  Duration? get backgroundDuration => _backgroundDuration;

  // Dispose service
  void dispose() {
    _subscription?.cancel();
    _lifecycleController.close();
  }
} 