# 🚀 Flutter Starter Kit

This Flutter Starter Kit is designed to help you bootstrap production-level apps quickly using **Clean Architecture**, **Riverpod**, **Firebase**, and best UI/UX practices. It’s optimized for scalability, maintainability, and rapid development across multiple environments.

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
├── core/                   # Configuration, theme, routes, DI, utils
│   ├── config/             # Theme, router, environment
│   ├── di/                 # Service Locator (GetIt)
│   ├── localization/       # Multi-language support
│   ├── network/            # Dio setup
│   ├── services/           # Firebase, Notifications, etc.
│   └── utils/              # UI helpers, formatters
│
├── data/                   # Models, repositories, data sources
│   ├── models/             # Freezed models
│   ├── network/            # Dio + Retrofit
│   ├── firebase/           # Remote config, messaging, etc.
│   └── local/              # Hive & SharedPreferences
│
├── domain/                 # Interfaces and entities
│   ├── entities/
│   └── repositories/
│
├── presentation/           # UI Layer
│   ├── pages/              # Screens
│   ├── viewmodels/         # MVVM ViewModels
│   └── components/         # Atomic UI: atoms, molecules, organisms, templates
│
└── main.dart               # App entry point
```

## 🛠 Features

- ✅ Clean Architecture with MVVM

- ✅ State management using flutter_riverpod

- ✅ Firebase integration: Auth, Remote Config, Messaging

- ✅ Dynamic theme switching (light/dark)

- ✅ Multilingual support with localization

- ✅ Native splash screen via flutter_native_splash

- ✅ Custom Flutter splash screen

- ✅ Reusable Lottie-based loading indicator

- ✅ Shimmer Skeleton loaders for UX

- ✅ Cached image support

- ✅ Modular routing with go_router

- ✅ Support for multiple environments via .env + flutter_flavorizr

- ✅ GetIt service locator

- ✅ Built-in reusable UI utilities (SnackBar, Dialog, BottomSheet)

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
3. Firebase Setup
- Create a Firebase project and register your Android/iOS app

- Download google-services.json (Android) and/or GoogleService-Info.plist (iOS)

- Place them in the correct platform folders

- Run:
```bash
flutterfire configure
```
4. Run native splash generator
```bash
flutter pub run flutter_native_splash:create
```
5. Run the app
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
| State Management          | `flutter_riverpod`             |
| Networking                | `dio`, `retrofit`              |
| Firebase Integration      | `firebase_core`, `firebase_auth`, `firebase_remote_config`, `firebase_messaging` |
| Local Storage             | `hive`, `shared_preferences`   |
| Dependency Injection      | `get_it`                       |
| Splash Screen             | `flutter_native_splash`        |
| Theme/Fonts               | `google_fonts`                 |
| Animation Loading         | `lottie`, `shimmer`            |
| Cached Images             | `cached_network_image`         |
| Routing                   | `go_router`                    |
| Environment Config        | `flutter_dotenv`               |

## 📄 License
This project is licensed under the MIT License.

## 🙌 Contributions
Feel free to fork, customize, and contribute to this template. Pull requests are welcome!

---
vanhuy-30
