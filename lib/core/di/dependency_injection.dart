import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_starter_kit/core/network/dio_client.dart';
import 'package:flutter_starter_kit/core/services/push_notification_service.dart';
import 'package:flutter_starter_kit/core/services/remote_config_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  getIt.registerSingleton(RemoteConfigService(FirebaseRemoteConfig.instance));
  getIt.registerSingleton(PushNotificationService());
}