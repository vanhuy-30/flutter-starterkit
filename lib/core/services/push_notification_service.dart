import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    NotificationSettings settings = await _messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      const android = AndroidInitializationSettings('@mipmap/ic_launcher');
      const settings = InitializationSettings(android: android);
      await _localNotificationsPlugin.initialize(settings);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _showNotification(message);
      });
    }
  }

  Future<void> _showNotification(RemoteMessage message) async {
    const android = AndroidNotificationDetails(
      'default_channel', 'Default',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platform = NotificationDetails(android: android);

    await _localNotificationsPlugin.show(
      0,
      message.notification?.title ?? '',
      message.notification?.body ?? '',
      platform,
    );
  }
}
