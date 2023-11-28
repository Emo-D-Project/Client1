import 'package:capston1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmSetting {

  Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  Future<String?> fcmSetting() async {
    print("fcmSetting 실행");

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    print("fcmSetting 1");

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    print("fcmSetting 2");

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    print("fcmSetting 3");

    print("User granted permission: ${settings.authorizationStatus}");

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'somain_notification'
        ,'somain_notification',
        description: '알림입니다',
        importance: Importance.max
    );

    print("fcmSetting 4");

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    // foreground 푸시 알림 핸들링
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      print('Got a message whilst in the foreground!');
      print('Message notification: ${message.notification.toString()}');

      if(message.notification != null && android != null){
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification?.title,
            notification?.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
              )
            ));
        print('Message also contained a notification: ${message.notification}');
      }
    });
    print("fcmSetting 5");

    // firebase token 발급
    String? firebaseToken = await messaging.getToken();
    print("fcmSetting 6");

    print('firebaseToken: ${firebaseToken}');

    return firebaseToken;
  }
}
