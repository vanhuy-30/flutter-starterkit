// import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_starter_kit/core/configs/app_config.dart';
import 'package:flutter_starter_kit/core/network/api_service.dart';
import 'package:flutter_starter_kit/core/network/dio_client.dart';
// import 'package:flutter_starter_kit/core/services/push_notification_service.dart';
// import 'package:flutter_starter_kit/core/services/remote_config_service.dart';
import 'package:flutter_starter_kit/core/services/secure_storage_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  // Register core services
  getIt.registerLazySingleton<DioClient>(DioClient.new);
  getIt.registerLazySingleton<ApiService>(() => ApiService(
        DioClient.instance,
        baseUrl: appConfig.baseUrl,
      ));
  getIt.registerLazySingleton<SecureStorageService>(SecureStorageService.new);
  // getIt.registerSingleton(RemoteConfigService(FirebaseRemoteConfig.instance));
  // getIt.registerSingleton(PushNotificationService());
}
