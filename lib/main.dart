import 'dart:ui';
import 'package:capston1/login.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'models/Diary.dart';
import 'package:firebase_core/firebase_core.dart';
import 'config/fcm_setting.dart';
import 'firebase_options.dart';
import 'statistics.dart';
import 'package:flutter/material.dart';
import 'category.dart';
import 'calendar.dart';
import 'diaryshare.dart';
import 'home.dart';
import 'style.dart' as style;
import 'alrampage.dart';
import 'models/Navigator.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {

 WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await FirebaseApi().initNotifications();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  // await FirebaseApi().initNotifications();
  // await FirebaseApi().fetchMyDataFromServer();
  // await FirebaseApi().checkMyDiaryExists();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseApi().initNotifications();
  await FirebaseApi().setupInteractedMessage();
  await FirebaseApi().fetchMyDataFromServer();
  //await FirebaseApi().checkMyDiaryExists();

  // 매월 1일에 알림 보내기
  /*sendMonthlyNotification();
  sendDiaryNotification();*/

  //int myId = await ApiManager().getApiManager().GetMyId() as int;
  //LoginedUserInfo.loginedUserInfo.id = myId;

  runApp(MaterialApp(
      navigatorKey: GlobalVariable.navState,
      routes: {
        "/diaryshare": (context) => calendar(),
      },
      theme: style.theme,
      home: MyApp(
          //firebaseToken: " ",
          )));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ApiManager apiManager = ApiManager().getApiManager();

  List<Diary> _diaryInfo = [];
  bool _myDiaryExists = false;

  @override
  void initState() {
    super.initState();

    checkMyDiaryExists();
    _permissionWithNotification();
  }

  void _permissionWithNotification() async {
    if (await Permission.notification.isDenied &&
        !await Permission.notification.isPermanentlyDenied) {
      await [Permission.notification].request();
    }
  }

  Future<void> fetchMyDataFromServer() async {
    try {
      final diaryData = await apiManager.getDiaryData();

      setState(() {
        _diaryInfo = diaryData;
      });
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

      setState(() {
        _myDiaryExists = myDiaryExists; // 필드 설정
      });

      if (_myDiaryExists) {
        print('오늘 작성한 본인의 일기가 있습니다.');
      } else {
        print('오늘 작성한 본인의 일기가 없습니다.');
      }
    } catch (error) {
      print('Error checking my diary existence: $error');
    }
  }

  var tab = 0;

  late List<Map<String, dynamic>> data;

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text('일기를 작성하셔야 보실 수 있습니다.'),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Color(0xFFD2C6BC),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                '확인',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.transparent,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const statistics()));
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
              if (i == 1 && !_myDiaryExists) {
                _showAlertDialog(context);
                return;
              }
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
      ),
    );
  }
}
