import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    final settings = await messaging.requestPermission();
    log("${settings.authorizationStatus}");

    final androidNotifySettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    final iosNotifySettings = IOSInitializationSettings();

    final notifySettings = InitializationSettings(
      android: androidNotifySettings,
      iOS: iosNotifySettings,
    );

    await localNotificationsPlugin.initialize(settings: notifySettings);
    await getToken();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) => log("${message.messageId}"),
    );
  }

  Future<void> getToken() async {
    /// WAIT FOR APNS TOKEN (iOS)
    String? apnsToken;

    if (Platform.isIOS) {
      apnsToken = await messaging.getAPNSToken();

      while (apnsToken == null) {
        await Future.delayed(const Duration(seconds: 1));

        apnsToken = await messaging.getAPNSToken();
      }

      log('APNS TOKEN: $apnsToken');
    }
    final token = await messaging.getToken();

    if (token != null) {
      log("Token-->$token");
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      "weather_channel",
      "Weather Notification",
      importance: Importance.max,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await localNotificationsPlugin.show(
      id: 0,
      title: message.notification?.title,
      body: message.notification!.body,
      notificationDetails: details,
    );
  }
}
