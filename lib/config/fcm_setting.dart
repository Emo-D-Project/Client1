import 'dart:async';
import 'package:capston1/MessageRoom.dart';
import 'package:capston1/category.dart';
import 'package:capston1/comment.dart';
import 'package:capston1/message_write.dart';
import 'package:capston1/models/notification.dart';
import 'package:capston1/monthlyStatistics.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:capston1/tokenManager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:capston1/tokenManager.dart' as tk;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:capston1/main.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:capston1/alrampage.dart';
import 'package:capston1/diaryReplay.dart';
import 'package:permission_handler/permission_handler.dart';
import '../calendar.dart';
import '../diaryshare.dart';
import '../models/Diary.dart';
import '../models/Navigator.dart';
import '../network/api_manager.dart';
import 'package:capston1/models/Comment.dart';
import '../screens/LoginedUserInfo.dart';

int Myid = 0;
int senderId = 0;

Diary? diary;

int findDiary = 0; // 일기 postid

final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

bool _myDiaryExists = false;

class FirebaseApi {
  final int otherUserId = 0;

  final _firebaseMessaging = FirebaseMessaging.instance;
  ApiManager apiManager = ApiManager().getApiManager();
  final NavigatorState? currentState = navState.currentState;

  List<Diary> _diaryInfo = [];

  List<notification> notificationList = [];
  List<Message> messageList = [];

  // 서버로부터 데이터를 가져오는 함수
  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getMessageList(senderId);
      print('getMessageList ${senderId}');

      messageList = data.cast<Message>();
    } catch (error) {
      // 에러 제어하는 부분
      print('Error getting chat list: $error');
    }
  }

  Future<void> fetchMyDataFromServer() async {
    try {
      final myid = await apiManager.GetMyId();
      final diaryData = await apiManager.getDiaryData();
      Myid = myid!;
      _diaryInfo = diaryData;

      Diary? foundDiary =
          _diaryInfo.firstWhere((diary) => diary.diaryId == findDiary);

      if (foundDiary != null) {
        diary = foundDiary;
      } else {
        print('해당하는 post_id에 해당하는 일기를 찾을 수 없습니다.');
      }
    } catch (error) {
      print('Error fetching data: ${error.toString()}');
    }
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // 종료상태에서 클릭한 푸시 알림 메세지 핸들링
    if (initialMessage != null) offNotificationTap(initialMessage);

    // 앱이 백그라운드 상태에서 푸시 알림 클릭 하여 열릴 경우 메세지 스트림을 통해 처리
    FirebaseMessaging.onMessageOpenedApp.listen(offNotificationTap);
  }

  //백그라운드 알림 클릭
  void offNotificationTap(RemoteMessage message) {
    print('message = ${message.notification!.title}');
    if (message.data['title'] == '누군가가 당신의 일기에 좋아요를 눌렀습니다!') {
      print('백 - 좋아요 알림 클릭');

      Navigator.of(GlobalVariable.navState.currentContext!).push(
          MaterialPageRoute(builder: (context) => DiaryReplay(diary: diary!)));
    } else if (message.data['title'] == 'EMO:D가 이달의 감정 통지서를 보냈습니다!') {
      Navigator.of(GlobalVariable.navState.currentContext!)
          .push(MaterialPageRoute(builder: (context) => monthlyStatistics()));
    } else if (message.data['title'] == '누군가 댓글을 달았습니다') {
      Navigator.of(GlobalVariable.navState.currentContext!)
          .push(MaterialPageRoute(builder: (context) => alrampage()));
    } else if (message.data['title'] == '쪽지가 왔습니다!') {
      Navigator.pushNamed(
          GlobalVariable.navState.currentContext!, '/messageroom');
    } else if (message.data['title'] == '하루가 지나가요! 오늘을 공유해보세요') {
      Navigator.of(GlobalVariable.navState.currentContext!)
          .push(MaterialPageRoute(builder: (context) => MyApp()));
    } else {
      print('백그라운드 클릭 안됩니다!!!!!!');
    }
  }

  Future<void> initNotifications() async {
    // 백그라운드 메세지 핸들러
    Future<void> handleBackgroundMessage(RemoteMessage message) async {
      print('[FCM - Background] MESSAGE 입니다');
      print('bg-TITLE: ${message.notification?.title}');
      print('bg-BODY: ${message.notification?.body}');
      print('bg-PAYLOAD: ${message.data}');
    }

    // background 메세지 핸들링
    if (FirebaseMessaging.onBackgroundMessage != null) {
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    } else {
      print("backGround null ");
    }

    //오늘 본인일기 있는지 확인
    Future<void> checkMyDiaryExists() async {
      try {
        await fetchMyDataFromServer();
        // 오늘 작성한 본인의 일기가 있는지 확인
        bool myDiaryExists = _diaryInfo.any((diary) =>
            DateFormat('yyyy년 MM월 dd일').format(diary.date) == formattedDate);

        _myDiaryExists = myDiaryExists;

        if (_myDiaryExists) {
          print('오늘 작성한 본인의 일기가 있습니다.~~');
        } else {
          print('오늘 작성한 본인의 일기가 없습니다.~~');
        }
      } catch (error) {
        print('Error checking my diary existence: $error');
      }
    }

    await checkMyDiaryExists();

    Future<void> sendMonthlyNotification() async {
      final DateTime now = DateTime.now();
      //if (now.hour == 10 && now.minute == 30 && now.day == 1) {

      if (now.day == 60) {
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
          payload: "EMO:D가 이달의 감정 통지서를 보냈습니다!",
        );

        // 알림 전송
        final int targetUserId = Myid; // 대상 유저 ID 설정
        final String title = 'EMO:D가 이달의 감정 통지서를 보냈습니다!';
        final String body = '';
        apiManager.sendNotification(targetUserId, title, body);
      }
      alrampage.addToItemList(A_Emod);
    }

    Future<void> sendDiaryNotification() async {
      final DateTime now = DateTime.now();
      // if (now.hour == 22 && now.minute == 00 && !_myDiaryExists) {
      if (_myDiaryExists) {
        final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();
        flutterLocalNotificationsPlugin.show(
          0,
          '하루가 지나가요! 오늘을 공유해보세요',
          '',
          NotificationDetails(
            android: AndroidNotificationDetails(
              'diary_notification_channel',
              'diary Notifications',
              channelDescription: '매일 10 시 일기를 안 쓴 사람들에게 알림을 위한 채널',
              importance: Importance.high,
            ),
          ),
          payload: '하루가 지나가요! 오늘을 공유해보세요',
        );

        // 알림 전송
        final int targetUserId = Myid;
        final String title = '하루가 지나가요! 오늘을 공유해보세요';
        final String body = ''; //
        apiManager.sendNotification(targetUserId, title, body);
      }
      alrampage.addToItemList(A_DEmod);
    }

    // 매월 1일 알림
    await sendMonthlyNotification();

    // 매일 10시에 일기 작성 알림
    await sendDiaryNotification();

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

    final StreamController<String?> notificationStream =
        StreamController<String?>.broadcast();

    void onNotificationTap(NotificationResponse notificationResponse) {
      notificationStream.add(notificationResponse.payload!);
      if (notificationResponse.payload!.contains('누군가가 당신의 일기에 좋아요를 눌렀습니다!')) {
        print('포어 - 좋아요 알림 클릭');

        Navigator.of(GlobalVariable.navState.currentContext!).push(
            MaterialPageRoute(
                builder: (context) => DiaryReplay(diary: diary!)));
      } else if (notificationResponse.payload!.contains('누군가 댓글을 달았습니다')) {
        // 댓글 알림인 경우
        Navigator.pushNamed(
            GlobalVariable.navState.currentContext!, '/comment');
      } else if (notificationResponse.payload!
          .contains('하루가 지나가요! 오늘을 공유해보세요')) {
        // 일기작성 알림인 경우
        Navigator.of(GlobalVariable.navState.currentContext!)
            .push(MaterialPageRoute(builder: (context) => MyApp()));
      } else if (notificationResponse.payload!
          .contains('EMO:D가 이달의 감정 통지서를 보냈습니다!')) {
        Navigator.of(GlobalVariable.navState.currentContext!)
            .push(MaterialPageRoute(builder: (context) => monthlyStatistics()));
      } else if (notificationResponse.payload!.contains('쪽지가 왔습니다!')) {
        // 쪽지 알림인 경우
        Navigator.pushNamed(
            GlobalVariable.navState.currentContext!, '/messageroom');
      } else {
        print('알림 클릭이 안됩니다!!!!!!!!!!!!!!!!!');
      }
    }

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap);

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

    ////--------------------------------------------

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
            ),
            payload: message.data['title']);
      } else {
        // 알림이 없는 메시지 처리
        print('Message does not contain a notification.');
      }
    }

    // Foreground 메세지 핸들링
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final Map<String, dynamic>? data = message.data;
      if (data != null) {
        final String? title = data['senderId'] as String?;
        senderId = int.parse(title!);

        /*     final String? findDiary = data['post_id'] as String?;
        postId = int.parse(findDiary!);*/

        final String? body = data['sendTime'] as String?;
        print("Message from ${title ?? 'No Title'}: ${body ?? 'No Post_id'}");
      } else {
        print("안됨");
      }

      print(
          '푸시 알림 수신: ${message.notification?.title ?? 'No Title'} - ${message.notification?.body ?? 'No Body'}');

      fbMsgForegroundHandler(message, flutterLocalNotificationsPlugin, channel);
    });
  }
}

/*

// 오후 10시에 일기를 안 쓴 사람에게 알림 보내기
void sendDiaryNotification() {
  final DateTime now = DateTime.now();

 // if (now.hour == 22 && now.minute == 00 && !_myDiaryExists) {
    if (_myDiaryExists) {

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(
      0,
      '하루가 지나가요! 오늘을 공유해보세요',
      '',
      NotificationDetails(
        android: AndroidNotificationDetails(
          'diary_notification_channel',
          'diary Notifications',
          channelDescription: '매일 10 시 일기를 안 쓴 사람들에게 알림을 위한 채널',
          importance: Importance.high,
        ),
      ),
      payload: "일기 쓰라는 알림",
    );

    // 알림 전송
    final int targetUserId = Myid;
    final String title = '하루가 지나가요! 오늘을 공유해보세요';
    final String body = ''; //
    apiManager.sendNotification(targetUserId, title, body);
  }
  alrampage.addToItemList(A_DEmod);
}
*/

/*
// 매월 1일에 감정 통지서 알림 보내기
void sendMonthlyNotification() {
  final DateTime now = DateTime.now();
  //if (now.hour == 10 && now.minute == 30 && now.day == 1) {

  if (now.day == 60) {

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
      payload: "통지서 알림",
    );

    // 알림 전송
    final int targetUserId = Myid; // 대상 유저 ID 설정
    final String title = 'EMO:D가 이달의 감정 통지서를 보냈습니다!';
    final String body = '';
    apiManager.sendNotification(targetUserId, title, body);
  }
  alrampage.addToItemList(A_Emod);
}
*/
