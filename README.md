# 🚀 Flutter Starter Kit

This Flutter Starter Kit is designed to help you bootstrap production-level apps quickly using **Clean Architecture**, **Riverpod**, **Firebase**, and best UI/UX practices. It's optimized for scalability, maintainability, and rapid development across multiple environments.

---

## 🧱 Architecture Overview

This project follows a **Clean Architecture** approach, clearly separating concerns into layers:

- **Presentation** – UI layer with MVVM pattern and atomic design
- **Application / Use Cases** – Core business logic
- **Domain** – Entity definitions and use case contracts
- **Data** – Implementations (API, Firebase, local storage)

---

## 📁 Folder Structure

```bash
lib/
├── core/                   # Configuration, theme, routes, services, DI, utils
│   ├── assests/            # Define assests as images, icons, animations
│   ├── base_state/         # Base state management classes
│   ├── configs/            # Theme, router, environment, deep link
│   ├── constants/          # App constants
│   ├── di/                 # Service Locator (GetIt)
│   ├── mixins/            # Reusable mixins
│   ├── network/           # Dio setup, interceptors
│   ├── routes/            # Route setup
│   ├── services/          # Firebase, Notifications, Locale, etc.
│   ├── theme/             # Theme app
│   ├── utils/             # UI helpers, formatters
│   └── widgets/           # Reusable widgets
│
├── data/                   # Models, repositories, data sources
│   ├── models/             # Data models
│   ├── repositories/       # Repository implementations
│   └── datasources/        # Remote and local data sources
│
├── domain/                 # Business logic layer
│   ├── entities/           # Business objects
│   ├── repositories/       # Repository interfaces
│   └── usecases/          # Use case implementations
│
├── presentation/           # UI Layer
│   ├── pages/              # Screens
│   ├── viewmodels/         # MVVM ViewModels
│   └── components/         # Atomic UI: atoms, molecules, organisms, templates
│
├── app.dart                # App configuration
├── main.dart               # App entry point
├── main_dev.dart           # Development environment entry
├── main_staging.dart       # Staging environment entry
└── main_production.dart    # Production environment entry
```

## 🛠 Features

- ✅ Clean Architecture with MVVM

- ✅ State management using flutter_riverpod

- ✅ Firebase integration:
  - Authentication
  - Remote Config
  - Cloud Messaging
  - Analytics
  - Performance Monitoring

- ✅ Security features:
  - Biometric authentication
  - Secure storage
  - JWT handling
  - Rate limiting
  - Retry mechanism

- ✅ Data persistence:
  - Hive for local database
  - SharedPreferences for key-value storage
  - Secure storage for sensitive data
  - Cache management

- ✅ File handling:
  - Image picking and processing
  - File picking
  - Permission management
  - MIME type handling

- ✅ Performance optimization:
  - Performance monitoring
  - Code quality checks
  - Background task management
  - App lifecycle management

- ✅ UI/UX features:
  - Dynamic theme switching (light/dark)
  - Multilingual support with easy_localization
  - Native splash screen
  - Custom Flutter splash screen
  - Reusable Lottie-based loading indicator
  - Shimmer Skeleton loaders
  - Cached image support
  - Auto-size text
  - Calendar date picker
  - OTP input handling

- ✅ Navigation:
  - Modular routing with go_router
  - Deep linking support
  - Navigation service

- ✅ Development tools:
  - Multiple environments via .env
  - GetIt service locator
  - Built-in reusable UI utilities
  - Error handling service
  - Documentation service
  - Analytics tracking
  - Push notification handling

- ✅ App maintenance:
  - Automatic app update checking
  - Background task scheduling
  - App lifecycle management
  - Performance monitoring
  - Error tracking and reporting

---

## 🚀 Getting Started

1. Clone the repository
```bash
git clone https://github.com/yourusername/flutter-starterkit.git
cd flutter-starterkit
```

2. Install dependencies
```bash
flutter pub get
```

3. Environment Setup
- Development:
```bash
flutter run --flavor development -t lib/main_dev.dart
```
- Staging:
```bash
flutter run --flavor staging -t lib/main_staging.dart
```
- Production:
```bash
flutter run --flavor production -t lib/main_production.dart
```

4. Firebase Setup
- Create a Firebase project and register your Android/iOS app

- Download google-services.json (Android) and/or GoogleService-Info.plist (iOS)

- Place them in the correct platform folders

- Run:
```bash
flutterfire configure
```
5. Run native splash generator
```bash
flutter pub run flutter_native_splash:create
```
6. Run the app
```bash
flutter run
```
---

## 🧬 State Management with Riverpod
- Global providers declared in presentation/viewmodels/

- Use StateNotifierProvider for business logic (MVVM)

- Fully testable, decoupled, and scalable

## 🔌 Dependency Injection
Using GetIt:
```bash
final sl = GetIt.instance;

Future<void> setupLocator() async {
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
}
```

## 📦 Key Packages Used
| Feature                    | Package                        |
|---------------------------|--------------------------------|
| State Management          | `flutter_riverpod`, `provider` |
| Networking                | `dio`, `retrofit`, `connectivity_plus` |
| Local Storage             | `hive`, `hive_flutter`, `shared_preferences`, `flutter_secure_storage` |
| Dependency Injection      | `get_it`                       |
| Localization             | `easy_localization`            |
| UI Components            | `google_fonts`, `shimmer`, `cached_network_image`, `flutter_svg`, `auto_size_text`, `calendar_date_picker2` |
| Animation                | `lottie`                       |
| Firebase Services        | `firebase_core`, `firebase_remote_config`, `firebase_messaging`, `firebase_analytics`, `firebase_performance` |
| Navigation               | `go_router`                    |
| Environment Config       | `flutter_dotenv`               |
| App Update               | `upgrader`                     |
| Deep Linking             | `app_links`                    |
| Background Tasks         | `workmanager`                  |
| Security                 | `crypto`, `jwt_decoder`, `local_auth` |
| File Handling            | `permission_handler`, `image_picker`, `file_picker` |
| Performance Monitoring   | `device_info_plus`, `package_info_plus` |
| Logging & Crash Reporting| `logger`                       |
| Local Notifications      | `flutter_local_notifications`  |
| Splash Screen            | `flutter_native_splash`        |
| OTP Input                | `pinput`                       |
| Documentation            | `markdown`, `http`             |

## 🔄 New Features Usage Guide

### App Update Service
```dart
// Initialize the service
final updateService = AppUpdateService();
await updateService.initialize();

// Use in your app
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return updateService.buildUpgradeWrapper(
      child: MaterialApp(
        // ... your app configuration
      ),
    );
  }
}
```

### Security Service
```dart
// Initialize the service
final securityService = SecurityService();
await securityService.initialize();

// Biometric authentication
final isAuthenticated = await securityService.authenticateWithBiometrics();

// Secure storage
await securityService.setSecureValue('key', 'value');
final value = await securityService.getSecureValue('key');

// JWT handling
final token = await securityService.generateJWT(payload);
final isValid = await securityService.validateJWT(token);
```

### File Service
```dart
// Initialize the service
final fileService = FileService();
await fileService.initialize();

// Pick and process image
final image = await fileService.pickImage();
final processedImage = await fileService.processImage(image);

// Pick file
final file = await fileService.pickFile(
  allowedExtensions: ['.pdf', '.doc', '.docx']
);

// Check and request permissions
final hasPermission = await fileService.checkPermission();
await fileService.requestPermission();
```

### Cache Service
```dart
// Initialize the service
final cacheService = CacheService();
await cacheService.initialize();

// Cache data
await cacheService.setData('key', data, duration: Duration(hours: 1));

// Get cached data
final data = await cacheService.getData('key');

// Clear cache
await cacheService.clearCache();
```

### Performance Service
```dart
// Initialize the service
final performanceService = PerformanceService();
await performanceService.initialize();

// Start performance monitoring
await performanceService.startMonitoring();

// Track custom metrics
await performanceService.trackMetric('screen_load_time', 150);

// Get performance report
final report = await performanceService.getPerformanceReport();
```

### Background Task Service
```dart
// Initialize the service
final backgroundService = BackgroundTaskService();
await backgroundService.initialize();

// Schedule background task
await backgroundService.scheduleTask(
  taskName: 'sync_data',
  frequency: Duration(hours: 1),
  task: () async {
    // Your background task logic
  }
);

// Cancel scheduled task
await backgroundService.cancelTask('sync_data');
```

### Analytics Service
```dart
// Initialize the service
final analyticsService = AnalyticsService();
await analyticsService.initialize();

// Track screen view
await analyticsService.logScreenView('HomeScreen');

// Track custom event
await analyticsService.logEvent(
  name: 'button_click',
  parameters: {'button_id': 'submit'}
);

// Set user properties
await analyticsService.setUserProperty('user_type', 'premium');
```

### Error Handling Service
```dart
// Initialize the service
final errorHandler = ErrorHandlingService();
errorHandler.initialize();

// Handle errors
try {
  // Your code
} catch (e) {
  await errorHandler.handleError(
    error: e,
    stackTrace: StackTrace.current,
    context: 'API_CALL'
  );
}

// Set custom error handler
errorHandler.setCustomHandler((error, stackTrace) {
  // Custom error handling logic
});
```

### Documentation Service
```dart
// Initialize the service
final docService = DocumentationService();
await docService.initialize();

// Generate API documentation
final apiDocs = await docService.generateApiDocs();

// Generate code documentation
final codeDocs = await docService.generateCodeDocs();

// Export documentation
await docService.exportDocs(format: 'markdown');
```

### Rate Limiter Service
```dart
// Initialize the service
final rateLimiter = RateLimiterService();
await rateLimiter.initialize();

// Check rate limit
final canProceed = await rateLimiter.checkLimit('api_call', maxAttempts: 5);

// Reset rate limit
await rateLimiter.resetLimit('api_call');
```

### Retry Service
```dart
// Initialize the service
final retryService = RetryService();
await retryService.initialize();

// Execute with retry
final result = await retryService.executeWithRetry(
  operation: () => apiCall(),
  maxAttempts: 3,
  delay: Duration(seconds: 1)
);
```

### App Lifecycle Service
```dart
// Initialize the service
final lifecycleService = AppLifecycleService();
await lifecycleService.initialize();

// Listen to lifecycle changes
lifecycleService.onStateChanged.listen((state) {
  switch (state) {
    case AppLifecycleState.resumed:
      // App is in foreground
      break;
    case AppLifecycleState.paused:
      // App is in background
      break;
  }
});
```

## 📄 License
This project is licensed under the MIT License.

## 🙌 Contributions
Feel free to fork, customize, and contribute to this template. Pull requests are welcome!

---
vanhuy-30
