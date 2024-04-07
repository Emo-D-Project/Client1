import 'package:capston1/models/MyInfo.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'style.dart' as style;
import 'package:capston1/main.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:convert';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' hide TokenManager;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'tokenManager.dart' as tk;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  KakaoSdk.init(nativeAppKey: '002001aad48dcca2375e4c52bb8c1281');
  await initializeDateFormatting();

  runApp(MaterialApp(theme: style.theme, home: MyLogin()));
}

class MyLogin extends StatefulWidget {
  MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  //카카오 어세스 토큰을 사용해 서버의 어세스 토큰 및 리프레시 토큰 어플에 저장 함수

  String jwttoken = '';
  int sendMyId = 0;

  Future<void> authenticate(String token) async {
    MyInfo myInfo = MyInfo().getMyInfo();
    tk.TokenManager tokenManager = tk.TokenManager().getTokenManager();
    final url = Uri.parse(
        'http://34.64.78.56:8080/user/auth/kakao'); // 서버의 엔드포인트 URL로 변경
    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'kakaoAccessToken': token,
    });

    try{
      if (response.statusCode == 200) {
        String responseBody = utf8.decode(response.bodyBytes);
        Map<String, dynamic> jsonResponse = json.decode(responseBody);

        tokenManager.setAccessToken(jsonResponse["access_token"]);
        tokenManager.setRefreshToken(jsonResponse["refresh_token"]);

        myInfo.setNickName(jsonResponse["properties"]["nickname"]);

        ApiManager apiManager = ApiManager().getApiManager();
        apiManager.tokenManager = tokenManager;
        print("로그인통신성공입니댜");
        print("전달 받은 토큰 : ${tokenManager.accessToken}");
        jwttoken = tokenManager.accessToken;

        int myId = await ApiManager().GetMyId() as int;
        LoginedUserInfo.loginedUserInfo.id = myId;
        sendMyId = myId;
        print("내 아이디 : ${myId}");

      } else {
        print("ㅋㅋ안됨ㅋㅋ");
        throw Exception('Faild to authenticate');
      }
    }
    catch(error){
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
                      print("넘기는 아이디 : ${sendMyId}");
                      // 카카오 로그인 성공 시
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyApp()));
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
