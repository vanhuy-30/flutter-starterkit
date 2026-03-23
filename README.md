# Flutter Starter Kit

A production-ready Flutter starter project focused on Clean Architecture, Riverpod, Firebase, multi-environment flows, and a comprehensive atomic design system. This repository is designed to help teams bootstrap applications quickly, maintain high code quality, and scale with confidence.

---

## Highlights

- Clean Architecture and MVVM pattern utilizing Riverpod.
- GoRouter navigation integrated with custom route guards and deep link support.
- Atomic design system (atoms to organisms) featuring theme switching and design tokens.
- Built-in support for localization, onboarding flows, biometrics, and caching strategies (Hive, SharedPreferences, SecureStorage).
- Core Firebase integration, including Cloud Messaging, Remote Config, Analytics, and Performance Monitoring.
- Multi-environment configurations using `.env` files (`main_dev`, `main_stg`, `main_prod`).
- Comprehensive tooling scripts and automated pre-commit hooks for consistent code quality.

---

## Architecture & Layers

- **app/**: Contains the bootstrap logic (`AppBootstrap`), application lifecycle handlers, global Riverpod providers, and the router/guards configuration.
- **core/**: Houses environment configurations (`Env`, `AppConfig`), networking implementations (Dio API client and interceptors), centralized error handling, dependency injection setup, and core services (analytics, push notifications, remote configuration, storage, security, background tasks, etc.).
- **features/**: Modular domain implementations (e.g., authentication, onboarding, home, settings, search). Each feature encompasses its own data, domain, and presentation layers along with corresponding Riverpod view models.
- **shared/**: Contains the atomic design system, reusable mixins (cache, biometrics, update), common UI components (splash, not-found pages), and shared view models.
- **entrypoints**: Entry files `main.dart`, `main_dev.dart`, `main_stg.dart`, and `main_prod.dart` that load the respective `.env` files and execute the application bootstrap flow.

---

## Folder Structure

```text
lib/
├── app/                 # Bootstrap, routes, global providers, lifecycle
├── core/                # Configs, env, DI, network, services, utils
├── features/            # Domain modules (auth, onboarding, settings, ...)
├── shared/              # Design system, mixins, shared pages/viewmodels
├── main.dart            # Default (production) entry point
├── main_dev.dart
├── main_stg.dart
└── main_prod.dart

assets/
├── animations/
├── icons/
├── images/
├── translations/
└── env/                 # Example: .env.dev, .env.stg, .env.prod

test/
├── unit/
├── widget/
├── integration/
└── golden/
```

---

## Core Capabilities

- **State Management**: Clean Architecture principles paired with MVVM and Riverpod.
- **Firebase Services**: Authentication, Remote Config, Cloud Messaging, Analytics, and Performance tracking.
- **Security**: Biometric authentication, secure storage, JWT handling, API rate limiting, and request retry mechanisms.
- **Data Persistence**: Integrated with Hive, SharedPreferences, and SecureStorage for robust cache management.
- **File Handling**: Utilities for managing file permissions, path resolution, and generic file downloading/uploading.
- **Performance & Monitoring**: Code-quality hooks, background task execution, and application lifecycle management.
- **UI/UX Infrastructure**: Dynamic theming, localization, splash screens, loading animations (Lottie), shimmer effects, cached images, auto-sizing text, and OTP input formatting.

---

## Environments Configuration

The application uses `AppBootstrap.run` to load environment-specific `.env` variables before initializing core services.

Example `.env` structure:

```env
API_URL=https://dev-api.example.com
ENV=dev
```

To set up your environments, create the following files:
- `assets/env/.env.dev`
- `assets/env/.env.stg`
- `assets/env/.env.prod`

Run the corresponding flavor:

```bash
flutter run -t lib/main_dev.dart
flutter run -t lib/main_stg.dart
flutter run -t lib/main_prod.dart
```

---

## Quick Start

1. **Clone the repository and install dependencies**
   ```bash
   git clone https://github.com/vanhuy-30/flutter-starterkit.git
   cd flutter-starterkit
   flutter pub get
   ```

2. **Configure environment files**
   Create `.env` files under `assets/env/` as detailed in the Environments section.

3. **Configure Firebase (Optional)**
   ```bash
   flutterfire configure
   ```
   Ensure the generated `google-services.json` and `GoogleService-Info.plist` files are placed in their respective platform directories.

4. **Generate required code and assets**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   flutter pub run flutter_native_splash:create
   ```

5. **Run the application**
   ```bash
   flutter run -t lib/main_dev.dart
   ```

---

## State Management

- Global providers are located in `lib/app/providers` and feature-specific providers in `features/**/presentation/providers`.
- Use `StateNotifierProvider` or code-generated providers for business logic (MVVM).
- Override dependencies when necessary using `ProviderScope`.
- Designed to integrate seamlessly with the internal design system widgets and GoRouter navigation.

## Dependency Injection

The architecture utilizes Riverpod providers for dependency injection. Core providers are defined in `lib/core/di/di_providers.dart`:

```dart
// Core service providers
final dioClientProvider = Provider<Dio>((ref) {
  final dio = Dio(BaseOptions(baseUrl: appConfig.baseUrl));
  dio.interceptors.addAll([AuthInterceptor(dio), LoggingInterceptor()]);
  return dio;
});

final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioClientProvider);
  return ApiService(dio, baseUrl: appConfig.baseUrl);
});

final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

// Feature providers can use core providers via ref.watch()
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRepositoryImpl(apiService);
});
```

---

## Primary Packages

| Domain | Packages |
|---------|----------|
| State Management | `flutter_riverpod`, `riverpod_generator` |
| Networking | `dio`, `retrofit`, `json_serializable`, `connectivity_plus` |
| Storage | `hive`, `hive_flutter`, `shared_preferences`, `flutter_secure_storage` |
| Localization | `easy_localization` |
| User Interface | `google_fonts`, `shimmer`, `cached_network_image`, `flutter_svg`, `auto_size_text`, `calendar_date_picker2`, `lottie` |
| Firebase | `firebase_core`, `firebase_remote_config`, `firebase_messaging`, `firebase_analytics`, `firebase_performance` |
| Infrastructure | `go_router`, `flutter_dotenv`, `app_links`, `workmanager`, `upgrader`, `flutter_local_notifications` |
| Security & System | `local_auth`, `permission_handler`, `device_info_plus`, `package_info_plus`, `crypto`, `jwt_decoder` |

---

## Feature Services Reference

### App Update Service
```dart
final updateService = AppUpdateService();
await updateService.initialize();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return updateService.buildUpgradeWrapper(
      child: MaterialApp.router(
        routerConfig: appRouter,
      ),
    );
  }
}
```

### Security Service
```dart
final securityService = SecurityService();
await securityService.initialize();

final authenticated = await securityService.authenticateWithBiometrics();
await securityService.setSecureValue('key', 'value');
final value = await securityService.getSecureValue('key');
```

### File Service
```dart
final fileService = FileService();
await fileService.initialize();

await fileService.downloadFile(
  url: 'https://example.com/file.pdf',
  fileName: 'document.pdf',
);

await fileService.uploadFile(
  filePath: '/path/to/document.pdf',
  url: 'https://example.com/upload',
);
```

### Cache Service
```dart
final cacheService = CacheService();
await cacheService.initialize();

await cacheService.setData('key', data, duration: const Duration(hours: 1));
final data = await cacheService.getData('key');
await cacheService.clearCache();
```

### Performance Service
```dart
final performanceService = PerformanceService();
await performanceService.initialize();
await performanceService.startMonitoring();
await performanceService.trackMetric('screen_load_time', 150);
```

### Background Task Service
```dart
final backgroundService = BackgroundTaskService();
await backgroundService.initialize();

await backgroundService.scheduleTask(
  taskName: 'sync_data',
  frequency: const Duration(hours: 1),
  task: () async {
    // Background execution logic
  },
);
```

### Analytics Service
```dart
final analyticsService = AnalyticsService();
await analyticsService.initialize();
await analyticsService.logScreenView('HomeScreen');
await analyticsService.logEvent(
  name: 'button_click',
  parameters: {'button_id': 'submit'},
);
```

### Error Handling Service
```dart
final errorHandler = ErrorHandlingService();
errorHandler.initialize();

try {
  // Executable code
} catch (e, s) {
  await errorHandler.handleError(
    error: e,
    stackTrace: s,
    context: 'API_CALL',
  );
}
```

### Additional Utilities
Further helper classes for documentation generation, rate limiting, request retries, and application lifecycle tracking are available in the `lib/core/services/` directory.

---

## Design System & Navigation

- **Riverpod Global State**: Found in `lib/app/providers/app_providers.dart` and `features/**/presentation/providers`.
- **Navigation & Guards**: Implemented using GoRouter under `lib/app/routes`. The `RouteGuard` orchestrates onboarding and authentication redirects, exposing methods like `navigateWithGuard` and `pushWithGuard`.
- **Atomic Components**: Accessible internally at `lib/shared/design_system`. Includes `AppTheme`, standardized colors, typography, buttons (atoms), formatting blocks (molecules), and complex layouts (organisms).
- **Localization**: Uses `EasyLocalization` layered within `AppBootstrap`. Define keys in `assets/translations` and implement `.tr()` in UI.
- **Data Stores**: Use `SecureStorageService` for tokens, `HiveService` for standard caching, and `PreferencesService` for application settings such as theme and locale preferences.

---

## Available Scripts

| Operation | Command / Location | Description |
|-----------|--------------------|-------------|
| Pre-commit Hook | `.git/hooks/pre-commit` | Validates formats, checks `flutter analyze`, and flags prints/TODOs. |
| Code Analysis | `flutter analyze` | Executes internal lint rules via `analysis_options.yaml`. |
| Run Test Suites | `./test_coverage.sh` | Executes unit, widget, and integration tests, then generates coverage. |
| Generate Assets | `make gen-code` | Runs build_runner to auto-generate providers and serializations. |
| Watch Definitions | `make gen-code-watch` | Development watch mode for code generation. |
| Android Build | `make build-apk FLAVOR=dev` | Compiles APK target (`dev`, `stg`, or `prod`). |
| iOS Build | `make build-ipa FLAVOR=dev` | Compiles IPA target (`dev`, `stg`, or `prod`) on macOS endpoints. |

**Usage Examples:**
```bash
make gen-code
make gen-code-watch
make build-apk FLAVOR=stg
make build-ipa FLAVOR=prod
```

---

## Testing Implementation

- `test/unit/`: Dedicated space for core domain logic tests, leveraging mock dependencies.
- `test/widget/`: Validates UI components with Riverpod overrides to mock expected states.
- `test/integration/`: Uses `integration_test` to orchestrate full user-journey simulations.
- `golden/`: Location of snapshot-driven visual regressions.

**Execution Commands:**
```bash
flutter test
flutter test integration_test
```

---

## License

This project is licensed under the **MIT License**.
Contributions are welcome. Please ensure pre-commit hooks remain intact and documentation strings are maintained when issuing pull requests.

---
vanhuy-30
