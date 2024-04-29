import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../network/api_manager.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    // 안드로이드 알림 채널 설정
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // 임의의 id
        'High Importance Notifications',
        description: '중요도가 높은 알림을 위한 채널', importance: Importance.high);

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    // 플러그인 초기화
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
   //상단 알림
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // 토큰 발급
    final fcmToken = await _firebaseMessaging.getToken();
    print('Token: $fcmToken\n');

    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,

    );

    // background 메세지 핸들링
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Foreground 메세지 핸들링
    FirebaseMessaging.onMessage.listen((message) {
      fbMsgForegroundHandler(message, flutterLocalNotificationsPlugin, channel);

    });
  }
}

// 백그라운드 메세지 핸들러
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('[FCM - Background] MESSAGE 입니다 ');
  print('bg-TITLE: ${message.notification?.title}');
  print('bg-BODY: ${message.notification?.body}');
  print('bg-PAYLOAD: ${message.data}');
}

// Foreground Messaging 핸들러
Future<void> fbMsgForegroundHandler(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    AndroidNotificationChannel channel) async {
  print('[FCM - Foreground] MESSAGE 입니다');
  print('fg-TITLE: ${message.notification?.title}');
  print('fg-BODY: ${message.notification?.body}');
  print('fg-PAYLOAD: ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
    flutterLocalNotificationsPlugin.show(
        message.hashCode,
        message.notification?.title,
        message.notification?.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/launcher_icon',
            priority: Priority.high,
          ),
        ));
  } else {
    // 알림이 없는 메시지 처리
    print('Message does not contain a notification.');
  }
}
