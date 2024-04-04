import 'dart:io';

import 'package:capston1/network/api_manager.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/date_symbol_data_file.dart';
//import 'config/fcm_setting.dart';

import 'config/fcm_new.dart';
import 'firebase_options.dart';
import 'statistics.dart';
import 'package:flutter/material.dart';
import 'category.dart';
import 'calendar.dart';
import 'diaryshare.dart';
import 'home.dart';
import 'style.dart' as style;
import 'alrampage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();



  //final fcmToken = await FirebaseMessaging.instance.getToken();
  //String? firebaseToken = await FcmSetting().fcmSetting(); // 수정된 부분
  // await initializeFDateFormatting();


  // 파이어베이스 초기화
  await Firebase.initializeApp();
  await FirebaseApi().initNotifications();

  int myId = await ApiManager().getApiManager().GetMyId() as int;
  LoginedUserInfo.loginedUserInfo.id = myId;
  runApp(MaterialApp(
      theme: style.theme,
      home: MyApp(
          //firebaseToken: "",
          )));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ApiManager apiManager = ApiManager().getApiManager();

  var tab = 0;

  late List<Map<String, dynamic>> data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF8F5EB),
        title: Text(
          "EMO:D",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'kim',
            color: Color(0xFF968C83),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const category()));
            },
            icon: Image.asset(
              'images/bottom/menu.png',
              width: 30,
              height: 30,
              color: Color(0xFF968C83),
            )),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const statistics()));
            },
            icon: Image.asset(
              'images/bottom/stats.png',
              width: 30,
              height: 30,
              color: Color(0xFF968C83),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => alrampage()));
            },
            icon: Image.asset(
              'images/bottom/bell.png',
              width: 30,
              height: 30,
              color: Color(0xFF968C83),
            ),
          )
        ],
      ),
      body: [home(), diaryshare(), calendar()][tab],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5.0,
        backgroundColor: Color(0xFFF8F5EB),
        showUnselectedLabels: false,
        //선택되지 않은 하단바의 label 숨기기
        showSelectedLabels: false,
        //선택된 하단바의 label 숨기기
        currentIndex: tab,
        //현재 select된 bar item의 index, 변수 tab부터 시작
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: '홈화면',
            icon: Image.asset(
              "images/bottom/home.png",
              width: 30,
              height: 30,
              color: Color(0xFF968C83),
            ),
          ),
          BottomNavigationBarItem(
            label: '일기공유',
            icon: Image.asset(
              "images/bottom/globe.png",
              width: 30,
              height: 30,
              color: Color(0xFF968C83),
            ),
          ),
          BottomNavigationBarItem(
            label: '캘린더',
            icon: Image.asset(
              "images/bottom/calendar.png",
              width: 35,
              height: 35,
              color: Color(0xFF968C83),
            ),
          ),
        ],
      ),
    );
  }
}
