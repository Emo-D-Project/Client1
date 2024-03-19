import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notifications = FlutterLocalNotificationsPlugin();

//1. 앱로드시 실행할 기본설정
initNotification(context) async {
  //안드로이드용 아이콘파일 이름
  var androidSetting = AndroidInitializationSettings('app_icon');

  var initializationSettings = InitializationSettings(
    android: androidSetting,
  );

  //알림 초기화
  await notifications.initialize(
    initializationSettings,
  );
}

//2. 이 함수 원하는 곳에서 실행하면 알림 뜸
showNotification() async {
  // 안드로이드
  var androidDetails = AndroidNotificationDetails(
    '유니크한 알림 채널 ID',
    '알림종류 설명',
    priority: Priority.high, // 중요도
    importance: Importance.max, // 중요도
    color: Color.fromARGB(255, 255, 0, 0), // 알림 색상
  );

  // 알림 id, 제목, 내용 맘대로 채우기
  notifications.show(
    1,
    '10시가 되었어요',
    '일기를 작성해보세요',
    NotificationDetails(android: androidDetails),
  );
}

//특정시간에 알림 띄우는 법
showNotification2() async {
  tz.initializeTimeZones();

  var androidDetails = const AndroidNotificationDetails(
    '유니크한 알림 ID',
    '알림종류 설명',
    priority: Priority.high,
    importance: Importance.max,
    color: Color.fromARGB(255, 255, 0, 0),
  );

// tz.TZDateTime.now(tz.local):이폰의 현재시간
  notifications.zonedSchedule(
      2,
      '특정시간알림',
      '5초지났다',
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 2)),
      NotificationDetails(android: androidDetails),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime);
}

//특정 시간을 만들어주는 함수임
makeDate(hour, min, sec) {
  var now = tz.TZDateTime.now(tz.local);
  var when =
      tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, min, sec);
  if (when.isBefore(now)) {
    return when.add(Duration(days: 1));
  } else {
    return when;
  }
}
