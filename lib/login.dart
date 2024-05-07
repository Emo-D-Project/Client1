import 'package:capston1/MessageRoom.dart';
import 'package:capston1/comment.dart';
import 'package:capston1/diaryshare.dart';
import 'package:capston1/models/MyInfo.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'blur.dart';
import 'config/fcm_setting.dart';
import 'firebase_options.dart';
import 'models/Navigator.dart';
import 'style.dart' as style;
import 'package:capston1/main.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' hide TokenManager;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'tokenManager.dart' as tk;
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final storage = FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: '002001aad48dcca2375e4c52bb8c1281');
  await initializeDateFormatting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  await FirebaseApi().fetchMyDataFromServer();
  await FirebaseApi().checkMyDiaryExists();
  sendMonthlyNotification();
  sendDiaryNotification();

  runApp(MaterialApp(
      routes: {
        '/diaryshare': (context) => diaryshare(),
        '/comment': (context) => comment(postId: 0, userid: senderId),
        '/messageroom': (context) => MessageRoom(otherUserId: senderId),
      },
      navigatorKey: GlobalVariable.navState,
      theme: style.theme,
      home: MyLogin()));
}

class MyLogin extends StatefulWidget {
  MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  String jwttoken = '';
  int sendMyId = 0;
  bool lockk = false;
  ApiManager apiManager = ApiManager().getApiManager();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    final accessToken = await storage.read(key: 'ACCESS_TOKEN');
    final refreshToken = await storage.read(key: 'REFRESH_TOKEN');
    final nickname = await storage.read(key: 'NICKNAME');
    Dio dio = Dio();

    if (accessToken != null) {
      MyInfo myInfo = MyInfo().getMyInfo();
      tk.TokenManager tokenManager = tk.TokenManager().getTokenManager();
      tokenManager.setAccessToken(accessToken);
      tokenManager.setRefreshToken(refreshToken!);
      myInfo.setNickName(nickname!);
      int myId = await ApiManager().GetMyId() as int;
      LoginedUserInfo.loginedUserInfo.id = myId;

      print('아이디 가져오기 성공 : ${myId}');
      print("닉네임: ${myInfo.nickName}");
      print("FCM 토큰 : ${tokenManager.getFirebaseToken()}");
      apiManager.putFirebaseToken(tokenManager.getFirebaseToken());
      String passSwitchString = await ApiManager().GetPassSwitch() ?? 'false';
      if (passSwitchString.toLowerCase() == 'true') {
        lockk = true;
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => lockk ? blur() : MyApp()));
    } else {
      try {
        Map<String, String> headers = {
          'Content-Type': 'application/json',
        };
        var response = await dio.post(
          'http://34.64.255.126:8000/api/token',
          data: {"refreshToken": refreshToken},
          options: Options(headers: headers), // 요청 데이터
        );
        print(response.statusCode);
        if (response.statusCode == 201) {
          print('토큰 재발급 성공');
        } else {
          throw Exception('Failed to load data from the API');
        }
      } catch (e) {
        print("$e");
      }
    }
  }

  Future<void> authenticate(String token) async {
    MyInfo myInfo = MyInfo().getMyInfo();
    tk.TokenManager tokenManager = tk.TokenManager().getTokenManager();
    final url = Uri.parse('http://34.64.255.126:8000/user/auth/kakao');
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'kakaoAccessToken': token,
    });

    try {
      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = json.decode(responseBody);

        tokenManager.setAccessToken(jsonResponse["access_token"]);
        tokenManager.setRefreshToken(jsonResponse["refresh_token"]);

        await storage.write(key: 'ACCESS_TOKEN', value: tokenManager.accessToken);
        await storage.write(key: 'REFRESH_TOKEN', value: tokenManager.refreshToken);

        myInfo.setNickName(jsonResponse["properties"]["nickname"]);
        await storage.write(key: 'NICKNAME', value: myInfo.nickName);


        print("로그인 통신 성공입니댜");
        print("닉네임: ${myInfo.nickName}");
        print("전달 받은 토큰 : ${tokenManager.accessToken}");

        int myId = await ApiManager().GetMyId() as int;
        LoginedUserInfo.loginedUserInfo.id = myId;
        apiManager.putFirebaseToken(tokenManager.getFirebaseToken());
        String passSwitchString = await apiManager.GetPassSwitch();
        if (passSwitchString.toLowerCase() == 'true') {
          lockk = true;
        }
        print("내 아이디 : ${myId}");
        print("잠금 여부 : ${lockk}");
      } else {
        throw Exception('로그인 인증에 실패했습니다.');
      }
    } catch (error) {
      print("에러입니다 : $error");
    }
  }

  Future<int> _handleKakaoLogin() async {
    OAuthToken? token;

    if (await isKakaoTalkInstalled()) {
      try {
        print(await KakaoSdk.origin);
        token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공 ${token.accessToken}');
        await authenticate(token.accessToken); //토큰 전달
        print("토큰 : ${token.accessToken}");
        return 1;
      } catch (error) {
        print(await KakaoSdk.origin);
        print('카카오톡으로 로그인 실패 $error');
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return 0;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          token = await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          await authenticate(token.accessToken);
          print("토큰 : ${token.accessToken}");
          return 1;
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return 0;
        }
      }
    } else {
      try {
        token = await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        await authenticate(token.accessToken);
        print("토큰 : ${token.accessToken}");
        return 1;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return 0;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1CBC2),
      body: Center(
        child: Container(
          height: 400,
          width: 329,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFFC5C4C4),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(4, 4),
              ),
            ],
            color: Color(0xFFEBE9E5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  'EMO:D',
                  style: TextStyle(
                      color: Color(0xFF7D5A50),
                      fontFamily: 'soojin',
                      fontSize: 40),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  'SNS로 간편 로그인 하기',
                  style: TextStyle(
                      color: Color(0xFF414040),
                      fontSize: 15,
                      fontFamily: 'soojin'),
                ),
              ),
              ButtonTheme(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: IconButton(
                  onPressed: () async {
                    if (await _handleKakaoLogin() == 1) {
                      // 카카오 로그인 성공 시
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => lockk ? blur() : MyApp()));
                    } else {
                      // 카카오 로그인 실패시
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            title: Column(
                              children: <Widget>[
                                Text("로그인 실패"),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("카카오톡 로그인에 실패했습니다."),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                child: Text("확인"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  icon: Image.asset(
                    'images/main/kakao.png',
                    fit: BoxFit.contain,
                  ),
                  iconSize: 230,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
