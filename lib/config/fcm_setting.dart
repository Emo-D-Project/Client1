import 'dart:async';
import 'package:capston1/MessageRoom.dart';
import 'package:capston1/models/notification.dart';
import 'package:capston1/monthlyStatistics.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:capston1/tokenManager.dart' as tk;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:capston1/main.dart';
import 'package:intl/intl.dart';
import 'package:capston1/alrampage.dart';
import 'package:capston1/diaryReplay.dart';
import '../diaryshare.dart';
import '../models/Diary.dart';
import '../models/Navigator.dart';
import 'package:capston1/models/Comment.dart';
import 'package:capston1/commentClick.dart';

late int Myid;
late int post_Id = 0;

final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

bool _myDiaryExists = false;

class FirebaseApi {
  final int otherUserId = 0;
  late int sendId = 0; // 보낸 사람
  Diary? diary;
  late String comments = " ";
  int id = 0;
  late String message_content = " ";
  late int receiver_Id;
  late DateTime sentAt;
  final _firebaseMessaging = FirebaseMessaging.instance;
  ApiManager apiManager = ApiManager().getApiManager();
  final NavigatorState? currentState = navState.currentState;

  List<Diary> _diaryInfo = [];
  List<notification> notificationList = [];
  List<Message> messageList = [];
  List<Comment> commentList = [];

  Future<void> setSendId() async {
    sendId = 123;
    post_Id = 123;
  }

  Future<void> GetComments() async {
    try {
      final data = await apiManager.getCommentData(post_Id);

      print('getComment List ${post_Id}');

      commentList = data.cast<Comment>();
    } catch (error) {
      // 에러 제어하는 부분
      print('Error getting chat list: $error');
    }
  }

  Future<void> GetComment(String endpoint) async {
    try {
      final response = await apiManager.Get(endpoint);
      final value = response['post_id'];
      print('post_id: $value');
      post_Id = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      final value = response['comment'];
      print('comment: $value');
      comments = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      final value = response['id'];
      print('id: $value');
      id = value;
    } catch (e) {
      print('Error: $e');
    }
  }

  // 서버에서 가져온 가상의 채팅방 목록
  Future<void> GetMessage(String endpoint) async {
    try {
      final response = await apiManager.Get(endpoint); // 실제 API 엔드포인트로 대체

      // 요청 응답 받기
      final value = response['content']; // 키를 통해 value를 받아오기
      print('content: $value');
      message_content = value;
    } catch (e) {
      print('Error: $e');
    }
    // 보낸 쪽지
    try {
      final response = await apiManager.Get(endpoint); // 실제 API 엔드포인트로 대체

      // 요청 응답 받기
      final value = response['senderId']; // 키를 통해 value를 받아오기
      print('senderId: $value');
      sendId = value;
    } catch (e) {
      print('Error: $e');
    }
    //받은 쪽지
    try {
      final response = await apiManager.Get(endpoint); // 실제 API 엔드포인트로 대체

      // 요청 응답 받기
      final value = response['receiverId']; // 키를 통해 value를 받아오기
      print('receiverId: $value');
      receiver_Id = value;
    } catch (e) {
      print('Error: $e');
    }

    // 보낸 시간
    try {
      final response = await apiManager.Get(endpoint); // 실제 API 엔드포인트로 대체

      // 요청 응답 받기
      final value = response['sentAt']; // 키를 통해 value를 받아오기
      print('sentAt: $value');
      sentAt = value;
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getMessageList(sendId);
      print('getMessageList ${sendId}');

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

      for (Diary d in _diaryInfo) {
        print(d.diaryId);

        if (d.diaryId == post_Id) {
          diary = d;
          print(diary?.diaryId);
          break;
        }
      }
    } catch (error) {
      print('데이터를 불러오는 도중 오류가 발생했습니다: ${error.toString()}');
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
      Navigator.of(GlobalVariable.navState.currentContext!).push(
          MaterialPageRoute(
              builder: (context) =>
                  commentClick(diary: diary!, postId: post_Id, userid: Myid)));
    } else if (message.data['title'] == '쪽지가 왔습니다!') {
      Navigator.of(GlobalVariable.navState.currentContext!).push(
          MaterialPageRoute(
              builder: (context) => MessageRoom(otherUserId: sendId)));
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
      if (now.hour == 10 && now.minute == 30 && now.day == 1) {
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
        final int postId = 0;

        apiManager.sendNotification(targetUserId, title, body, postId);
      }
      alrampage.addToItemList(A_Emod);
    }

    Future<void> sendDiaryNotification() async {
      final DateTime now = DateTime.now();
      if (now.hour == 22 && now.minute == 00 && !_myDiaryExists) {
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
        final int postId = 0;

        apiManager.sendNotification(targetUserId, title, body, postId);
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
        Navigator.of(GlobalVariable.navState.currentContext!).push(
            MaterialPageRoute(
                builder: (context) => commentClick(
                    diary: diary!, postId: post_Id, userid: Myid)));
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
        Navigator.of(GlobalVariable.navState.currentContext!).push(
            MaterialPageRoute(
                builder: (context) => MessageRoom(otherUserId: sendId)));
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
        //   sendId = int.parse(title!);
        sendId = 2;
        print(sendId);
        fetchDataFromServer();
        print("Message from ${title ?? 'No Title'}:");
        final String? findDiary = data['postId'] as String?;
        post_Id = int.parse(findDiary!);

        GetComments();

        fetchMyDataFromServer();
        print("Message comment from ${findDiary ?? 'No findairy'}:");
      } else {
        print("안됨");
      }
      print(
          '푸시 알림 수신: ${message.notification?.title ?? 'No Title'} - ${message.notification?.body ?? 'No Body'}');
      fbMsgForegroundHandler(message, flutterLocalNotificationsPlugin, channel);
    });
  }
}
