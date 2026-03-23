# 🚀 Flutter Starter Kit

Production-ready Flutter starter focused on Clean Architecture, Riverpod, Firebase, multi-environment flows, and a complete atomic design system. The goal is to help teams bootstrap fast, keep quality high, and scale with confidence.

---

## 🌟 Highlights
- Clean Architecture + MVVM with Riverpod.
- GoRouter navigation with custom Route Guard + deep link support.
- Atomic design system (atoms → organisms), theme switching, design tokens.
- Easy Localization, onboarding, biometrics, Hive/SharedPreferences/SecureStorage caching.
- Firebase core integration (Messaging, Remote Config, Analytics, Performance) plus notifications.
- Multi-environment ready (`.env` + `main_dev/stg/prod`), tooling scripts, automated pre-commit hook.

---

## 🧱 Architecture & Layers
- **app/**: bootstrap (`AppBootstrap`), lifecycle, global Riverpod providers, router/guards.
- **core/**: env config (`Env`, `AppConfig`), networking (Dio + interceptors), error handling, DI (Riverpod), services (analytics, push, remote config, storage, security, retry, background tasks, ...), utils.
- **features/**: domain modules (auth, onboarding, home, settings, search) containing data/domain/presentation and Riverpod view models.
- **shared/**: Atomic design system, mixins (cache, biometrics, update), splash/not-found pages, shared view models.
- **entrypoints**: `main.dart`, `main_dev.dart`, `main_stg.dart`, `main_prod.dart` select the matching `.env` and run the bootstrap flow.

---

## 📁 Key Folder Structure
```bash
lib/
├── app/                 # Bootstrap, routes, global providers, lifecycle
├── core/                # Configs, env, DI, network, services, utils
├── features/            # Domain modules (auth, onboarding, settings, ...)
├── shared/              # Design system, mixins, shared pages/viewmodels
├── main.dart            # Default (production) entry
├── main_dev.dart
├── main_stg.dart
└── main_prod.dart

assets/
├── animations/
├── icons/, images/
├── translations/
└── env/                 # `.env.dev`, `.env.stg`, `.env.prod` (create locally)

test/
├── unit/
├── widget/
├── integration/
└── golden/
```

---

## 🛠 Feature Set
- ✅ Clean Architecture with MVVM & Riverpod.
- ✅ Firebase integration: Authentication, Remote Config, Cloud Messaging, Analytics, Performance.
- ✅ Security: biometrics, secure storage, JWT handling, rate limiting, retry.
- ✅ Persistence: Hive, SharedPreferences, SecureStorage, cache management.
- ✅ File handling: pick/process images & files, permission & MIME helpers.
- ✅ Performance tools: monitoring, code-quality hooks, background tasks, lifecycle manager.
- ✅ UI/UX: dynamic theme, localization, splash, Lottie loaders, shimmer, cached images, auto-size text, OTP widgets.
- ✅ Tooling: multi-env `.env`, Riverpod for DI, reusable UI utilities, analytics/error/docs services, notification handling.

---

## 🌐 Environments & `.env`
`AppBootstrap.run` loads a `.env` file before initializing services.

```env
API_URL=https://dev-api.example.com
ENV=dev
```

Create:
- `assets/env/.env.dev`
- `assets/env/.env.stg`
- `assets/env/.env.prod`

Run each flavor:
```bash
flutter run -t lib/main_dev.dart
flutter run -t lib/main_stg.dart
flutter run -t lib/main_prod.dart
```

---

## 🚀 Quick Start
1. **Clone & install**
   ```bash
   git clone https://github.com/yourusername/flutter-starterkit.git
   cd flutter-starterkit
   flutter pub get
   ```
2. **Prepare `.env` files** under `assets/env/` as shown above.
3. **(Optional) Configure Firebase**
   ```bash
   flutterfire configure
   ```
   Copy `google-services.json` & `GoogleService-Info.plist` into platform folders.
4. **Generate code/assets**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   flutter pub run flutter_native_splash:create
   ```
5. **Run an environment**
   ```bash
   flutter run -t lib/main_dev.dart
   ```

---

## 🧬 State Management with Riverpod
- Global providers in `lib/app/providers` and `features/**/presentation/providers`.
- Use `StateNotifierProvider` for business logic (MVVM) and override dependencies via `ProviderScope`.
- Works seamlessly with design system widgets and GoRouter navigation.

## 🔌 Dependency Injection
Using Riverpod providers for dependency injection. Core providers are defined in `lib/app/providers/core_providers.dart`:
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

## 📦 Key Packages Used
| Feature | Packages |
|---------|----------|
| State management | `flutter_riverpod`, `riverpod_generator` |
| Networking | `dio`, `retrofit`, `json_serializable`, `connectivity_plus` |
| Storage & cache | `hive`, `hive_flutter`, `shared_preferences`, `flutter_secure_storage` |
| Dependency Injection | `flutter_riverpod` |
| Localization | `easy_localization` |
| UI/UX | `google_fonts`, `shimmer`, `cached_network_image`, `flutter_svg`, `auto_size_text`, `calendar_date_picker2` |
| Animation | `lottie` |
| Firebase | `firebase_core`, `firebase_remote_config`, `firebase_messaging`, `firebase_analytics`, `firebase_performance` |
| Navigation & env | `go_router`, `flutter_dotenv`, `app_links`, `workmanager`, `upgrader` |
| Security & device | `local_auth`, `permission_handler`, `device_info_plus`, `package_info_plus`, `crypto`, `jwt_decoder` |
| Notifications | `flutter_local_notifications` |

---

## 🔄 Feature Services (Usage Guide)

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

final image = await fileService.pickImage();
final processedImage = await fileService.processImage(image);

final file = await fileService.pickFile(
  allowedExtensions: ['.pdf', '.docx'],
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
    // background logic
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
  // ...
} catch (e, s) {
  await errorHandler.handleError(
    error: e,
    stackTrace: s,
    context: 'API_CALL',
  );
}
```

### Documentation / Rate Limiter / Retry / Lifecycle
Additional helpers live in `lib/core/services/` and expose straightforward APIs for docs export, throttling operations, retrying async tasks, and tracking app lifecycle transitions.

---

## 📚 Using the Key Capabilities
- **Riverpod global state**: see `lib/app/providers/app_providers.dart` & `features/**/presentation/providers`.
- **GoRouter & RouteGuard**: defined under `lib/app/routes`. `RouteGuard` orchestrates onboarding/login redirects and exposes `navigateWithGuard` / `pushWithGuard`.
- **Design System**: Atomic components under `lib/shared/design_system`. Use `AppTheme`, `app_colors.dart`, atoms/buttons, molecules/forms, organisms/bottom_nav, etc.
- **Localization**: `EasyLocalization` wraps `AppBootstrap`. Define keys in `assets/translations` and call `.tr()`.
- **Security & storage**: Secure tokens with `SecureStorageService`, persist user cache via `HiveService`, keep theme/locale in `PreferencesService`, enable biometrics via `BiometricService`.

---

## 🧰 Tooling & Scripts
| Task | Command / Location | Notes |
|------|--------------------|-------|
| Auto format + analyze on commit | `.git/hooks/pre-commit` | Formats staged Dart files, runs `flutter analyze`, warns on TODO/print. |
| Manual lint | `flutter analyze` | Uses `analysis_options.yaml`. |
| Tests + coverage | `./test_coverage.sh` | Runs unit/widget/integration tests, opens coverage HTML. |
| Code generation | `make gen-code` | Wrapper for `fvm dart run build_runner build --delete-conflicting-outputs` (fallback `dart` if no FVM). |
| Code generation (watch) | `make gen-code-watch` | Wrapper for `fvm dart run build_runner watch --delete-conflicting-outputs` (fallback `dart` if no FVM). |
| Build Android APK | `make build-apk FLAVOR=dev` | Supports `FLAVOR=dev|stg|prod`. |
| Build iOS IPA | `make build-ipa FLAVOR=dev` | Supports `FLAVOR=dev|stg|prod` on macOS. |

Quick examples:
```bash
make gen-code
make gen-code-watch
make build-apk FLAVOR=stg
make build-ipa FLAVOR=prod
```

---

## 🧪 Testing Strategy
- `test/unit/`: feature/domain tests (mocktail ready).
- `test/widget/`: UI states with Riverpod overrides.
- `test/integration/`: `integration_test` package.
- `golden/`: snapshot-driven visual checks.

Quick commands:
```bash
flutter test
flutter test integration_test
```

---

## 📝 License & Contributions
- License: **MIT**
- PRs/issues welcome. Keep the pre-commit hook enabled and update docs when adding features.

---

vanhuy-30

