import 'package:capston1/network/api_manager.dart';
import 'package:capston1/tokenManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capston1/tokenManager.dart' as tk;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:capston1/main.dart';
import 'package:intl/intl.dart';

import '../diaryshare.dart';
import '../models/Diary.dart';
import '../network/api_manager.dart';

bool _myDiaryExists = false;

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  ApiManager apiManager = ApiManager().getApiManager();

  List<Diary> _diaryInfo = [];

  Future<void> fetchMyDataFromServer() async {
    try {
      final diaryData = await apiManager.getDiaryData();

      _diaryInfo = diaryData;
    } catch (error) {
      print('Error fetching data: ${error.toString()}');
    }
  }

  //오늘 본인일기 있는지 확인
  Future<void> checkMyDiaryExists() async {
    try {
      await fetchMyDataFromServer();
      // 오늘 작성한 본인의 일기가 있는지 확인
      bool myDiaryExists = _diaryInfo.any((diary) =>
          DateFormat('yyyy년 MM월 dd일').format(diary.date) == formattedDate);

      _myDiaryExists = myDiaryExists; // 필드 설정

      if (_myDiaryExists) {
        print('오늘 작성한 본인의 일기가 있습니다.~~');
      } else {
        print('오늘 작성한 본인의 일기가 없습니다.~~');
      }
    } catch (error) {
      print('Error checking my diary existence: $error');
    }
  }

  Future<void> initNotifications() async {
    // 안드로이드 알림 채널 설정
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // 임의의 id
        'High Importance Notifications',
        description: '중요도가 높은 알림을 위한 채널',
        importance: Importance.high);

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
    String? fcmToken = await _firebaseMessaging.getToken();
    tk.TokenManager tokenManager = tk.TokenManager().getTokenManager();
    tokenManager.setFirebaseToken(fcmToken!);
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

//오후 10시에 일기 안 쓴 사람에게 알림 가기

void sendDiaryNotification() {
  final DateTime now = DateTime.now();

  if (now.hour == 13 && _myDiaryExists ) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(
      0,
      'EMO:D가 일기 좀 쓰라고 보냇습니다',
      '',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'diary_notification_channel',
          'diary Notifications',
          channelDescription: '매일 10 시 일기 안쓴 사람들에게 알림을 위한 채널',
          importance: Importance.high,
        ),
      ),
    );
  }
}

//매월 1일 감정 통시서 알람 확인 보내기
void sendMonthlyNotification() {
  // 현재 날짜를 확인하여 매월 1일이면 알림을 보냅니다.
  final DateTime now = DateTime.now();
  if (now.day == 2) {
    // 알림 보내기
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(
      1, // ID
      'EMO:D가 이달의 감정 통지서를 보냈습니다!', // 제목
      '', // 내용
      NotificationDetails(
        android: AndroidNotificationDetails(
          'monthly_notification_channel', // 채널 ID
          'Monthly Notifications',
          channelDescription: '매월 1일 알림을 위한 채널',
          importance: Importance.high,
        ),
      ),
    );
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
        message.notification?.body
            ?.replaceAll(RegExp(r'보낸 시간 : .+'), '')
            .trim(),
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
