# 🚀 Flutter Starter Kit

Production-ready Flutter starter focused on Clean Architecture, Riverpod, Firebase, multi-environment flows, and a complete design system. The goal is to help teams bootstrap fast, keep quality high, and scale with confidence.

---

## 🌟 Highlights
- Clean Architecture + MVVM using Riverpod and GetIt.
- Multi-tab navigation with GoRouter and custom Route Guard.
- Cross-platform theming (light/dark), Atomic Design System, reusable UI components.
- Easy Localization for multi-language apps, onboarding flow, biometrics, Hive/SharedPreferences/SecureStorage caching.
- Firebase core integration (Messaging, Remote Config, Analytics, Performance) plus local notifications.
- Multi-environment ready (.env + `main_dev/stg/prod`), lint/test/coverage scripts, automated pre-commit hook.

---

## 🧱 Architecture & Layers
- **app/**: bootstrap (`AppBootstrap`), lifecycle, global Riverpod providers, router + guard.
- **core/**: env config (`Env`, `AppConfig`), networking (Dio + interceptors), error handling, DI (GetIt), infrastructure services (analytics, push, remote config, storage, security, retry, background tasks, ...), utils.
- **features/**: domain modules (auth, onboarding, home, settings, search) containing data/domain/presentation and Riverpod view models.
- **shared/**: Atomic design system (atoms → organisms), theme, mixins (cache, biometrics, update), splash/not-found pages, shared view models.
- **entrypoints**: `main_dev.dart`, `main_stg.dart`, `main_prod.dart` select the matching `.env` and run the bootstrap flow.

---

## 📁 Key Folder Structure
```bash
lib/
├── app/                 # Bootstrap, routes, global providers, lifecycle
├── core/                # Configs, env, DI, network, services, utils
├── features/            # Domain modules (auth, onboarding, settings, ...)
├── shared/              # Design system, mixins, shared pages/viewmodels
├── main_dev.dart
├── main_stg.dart
└── main_prod.dart

assets/
├── animations/          # Lottie loaders / not-found
├── icons/, images/      # Brand & UI assets
├── translations/        # en.json, vi.json
└── env/                 # `.env.dev`, `.env.stg`, `.env.prod` (create locally)

test/
├── unit/
├── widget/
├── integration/
└── golden/
```

---

## 🌐 Environments & `.env`
`AppBootstrap.run` loads a `.env` file before initializing services. Add keys like:
```
API_URL=https://dev-api.example.com
ENV=dev
```
Create the files:
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
1. Clone & install dependencies
   ```bash
   git clone https://github.com/yourusername/flutter-starterkit.git
   cd flutter-starterkit
   flutter pub get
   ```
2. Prepare the `.env` files as above.
3. (Optional) Configure Firebase
   ```bash
   flutterfire configure
   ```
   Copy `google-services.json` and `GoogleService-Info.plist` into the respective platform folders.
4. Generate assets or code
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   flutter pub run flutter_native_splash:create
   ```
5. Run the desired environment (example: dev)
   ```bash
   flutter run -t lib/main_dev.dart
   ```

---

## 📚 Using the Key Capabilities
- **Riverpod global state**: see `lib/app/providers/app_providers.dart` & `features/**/presentation/providers`. Build StateNotifier-based view models and inject dependencies via provider overrides.
- **GoRouter & RouteGuard**: defined under `lib/app/routes`. `RouteGuard` orchestrates onboarding/login redirects and exposes `navigateWithGuard` / `pushWithGuard` helpers.
- **Design System**: Atomic components live in `lib/shared/design_system`. Use `AppTheme`, `app_colors.dart`, atoms/buttons, molecules/forms, organisms/bottom_nav, etc.
- **Localization**: `EasyLocalization` wraps the entire app inside `AppBootstrap`. Define keys in `assets/translations` and call `.tr()`.
- **Security & storage**: Secure tokens with `SecureStorageService`, persist user cache via `HiveService`, keep theme/locale in `PreferencesService`, enable biometrics via `BiometricAuthMixin`.

---

## 🧰 Tooling & Scripts
| Task | Command / Location | Notes |
|------|--------------------|-------|
| Auto format + analyze on commit | `.git/hooks/pre-commit` | Formats staged Dart files, runs `flutter analyze` by directory, warns on TODO/print. |
| Manual lint | `flutter analyze` | Uses `analysis_options.yaml` (single quotes, avoid print, require trailing commas, ...). |
| Tests + coverage | `./test_coverage.sh` | Runs unit/widget + integration tests, formats coverage (HTML) and opens report. |
| Code generation | `dart run build_runner build` | Add `--delete-conflicting-outputs` for clean rebuilds. |

---

## 🧪 Testing Strategy
- `test/unit/`: example `auth_view_model_test.dart` + onboarding module; extend with mocktail.
- `test/widget/`: add concrete UI scenarios (currently empty samples).
- `test/integration/`: relies on the `integration_test` package.
- `golden/`: snapshot-driven visual checks.

Quick commands:
```bash
flutter test
flutter test integration_test
```

---

## 📦 Featured Packages
| Category | Packages |
|----------|----------|
| State management | `flutter_riverpod`, `riverpod_generator` |
| Networking | `dio`, `retrofit`, `json_serializable`, `connectivity_plus` |
| Storage & cache | `hive`, `hive_flutter`, `shared_preferences`, `flutter_secure_storage` |
| Firebase & backend | `firebase_core`, `firebase_remote_config`, `firebase_messaging`, `firebase_analytics`, `firebase_performance` |
| UI/UX | `google_fonts`, `lottie`, `shimmer`, `cached_network_image`, `auto_size_text` |
| Navigation & env | `go_router`, `flutter_dotenv`, `app_links`, `workmanager`, `upgrader` |
| Security & device | `local_auth`, `permission_handler`, `device_info_plus`, `package_info_plus` |

---

## 📝 License & Contributions
- License: **MIT**
- PRs/issues are welcome. Please keep the pre-commit hook enabled and update README/docs when adding new features.

---

vanhuy-30
