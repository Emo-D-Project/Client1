import 'package:capston1/models/MyInfo.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'blur.dart';
import 'config/fcm_setting.dart';
import 'firebase_options.dart';
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


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: '002001aad48dcca2375e4c52bb8c1281');
  await initializeDateFormatting();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();


  runApp(MaterialApp(theme: style.theme, home: MyLogin()));
}

class MyLogin extends StatefulWidget {
  MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  //카카오 어세스 토큰을 사용해 서버의 어세스 토큰 및 리프레시 토큰 어플에 저장 함수

  final storage = FlutterSecureStorage();
  String jwttoken = '';
  int sendMyId = 0;
  bool lockk = false;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    final accessToken = await storage.read(key: 'ACCESS_TOKEN');
    final refreshToken = await storage.read(key: 'REFRESH_TOKEN');
    Dio dio = Dio();

    if (accessToken != null) {
      print('djdjdjdjdj: ${accessToken}');
      tk.TokenManager tokenManager = tk.TokenManager().getTokenManager();
      tokenManager.setAccessToken(accessToken);
      tokenManager.setRefreshToken(refreshToken!);
      print("kkkkkkkk:${refreshToken}");
      ApiManager apiManager = ApiManager().getApiManager();
      int myId = await ApiManager().GetMyId() as int;
      LoginedUserInfo.loginedUserInfo.id = myId;
      print('아아아 ${myId}');
      print("에프씨엠${tokenManager.getFirebaseToken()}");
      apiManager.putFirebaseToken(tokenManager.getFirebaseToken());
      String passSwitchString = await ApiManager().GetPassSwitch() ?? 'false';
      if (passSwitchString.toLowerCase() == 'true') {
        lockk = true;
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (context) =>
          lockk
              ? blur()
              : MyApp()));
    }
    else {
      try {
        print("44");
        Map<String, String> headers = {
          'Content-Type': 'application/json',
        };
        var response = await dio.post(
          'http://34.64.255.126:8000/api/token',
          data: {
            "refreshToken": refreshToken
          },
          options: Options(headers: headers),// 요청 데이터
        );
        print(response.statusCode);
        if (response.statusCode == 201) {
          print('토큰 재발급 성공');
        } else {
          throw Exception('ㅏㅏFailed to load data from the API');
        }
      }
      catch (e) {
        _handleKakaoLogin();
        print("이거 실행 $e");
      }
      // user의 정보가 있다면 로그인 후 들어가는 첫 페이지로 넘어가게 합니다.
    }
  }

  Future<void> authenticate(String token) async {
    MyInfo myInfo = MyInfo().getMyInfo();
    tk.TokenManager tokenManager = tk.TokenManager().getTokenManager();
    final url = Uri.parse(
        'http://34.64.255.126:8000/user/auth/kakao'); // 서버의 엔드포인트 URL로 변경
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
        var accessToken = tokenManager
            .accessToken; // resp.data.accessToken : api서버를 통해 발급받은 accessToken
        var refreshToken = tokenManager
            .refreshToken; // resp.data.refreshToken : api서버를 통해 발급받은 refreshToken

        await storage.write(key: 'ACCESS_TOKEN', value: accessToken);
        await storage.write(key: 'REFRESH_TOKEN', value: refreshToken);

        myInfo.setNickName(jsonResponse["properties"]["nickname"]);

        ApiManager apiManager = ApiManager().getApiManager();
        apiManager.tokenManager = tokenManager;
        print("로그인통신성공입니댜");
        print("전달 받은 토큰 : ${tokenManager.accessToken}");
        jwttoken = tokenManager.accessToken;

        int myId = await ApiManager().GetMyId() as int;
        LoginedUserInfo.loginedUserInfo.id = myId;
        apiManager.putFirebaseToken(tokenManager.getFirebaseToken());
        String passSwitchString = await apiManager.GetPassSwitch();
        if (passSwitchString.toLowerCase() == 'true') {
          lockk = true;
        }
        print("내 아이디 : ${myId}");
        print("잠금여부 : ${lockk}");
      } else {
        throw Exception('Faild to authenticate');
      }
    }
    catch (error) {
      print("에러입니다 : $error");
    }
  }

  Future<int> _handleKakaoLogin() async {
    MyInfo myInfo = MyInfo().getMyInfo();

    OAuthToken? token;

    if (await isKakaoTalkInstalled()) {
      try {
        print(await KakaoSdk.origin);
        token = await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공 ${token.accessToken}');
        await authenticate(token.accessToken); //토큰 전달
        print("토토큰큰 : ${jwttoken}");
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
          print("토토큰큰 : ${jwttoken}");
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
        print("토토큰큰 : ${jwttoken}");
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                          lockk
                              ? blur()
                              : MyApp()));
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
