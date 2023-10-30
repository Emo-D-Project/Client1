import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'package:capston1/main.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:convert';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' hide TokenManager;
import 'package:http/http.dart' as http;


void main() async {
  await initializeDateFormatting();
  runApp(MaterialApp(theme: style.theme, home: MyLogin()));
}

class MyLogin extends StatefulWidget {
  MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

Future<void> _handleKakaoLogin() async {
  String tmpKakaoAccessToken = "rAAxmDh64Nk9q5h6ZiZJyfGY0Qr0sX5fZjYKPXPrAAABi4BgqsOxu3fh8M0xkQ";
  sendTokenToServer(tmpKakaoAccessToken);


  // try {
  //   token = await UserApi.instance.loginWithKakaoTalk();
  //   print('카카오톡으로 로그인 성공 ${token.accessToken}');
  //
  //   sendTokenToServer(token.accessToken); // 토큰을 문자열로 전달
  //
  // } catch (error) {
  //   print('카카오톡으로 로그인 실패 $error');
  // }
}


Future<void> sendTokenToServer(String token) async {
  final url = Uri.parse(
      'http://34.64.78.183:8080/user/auth/kakao'); // 서버의 엔드포인트 URL로 변경

  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'kakaoAccessToken': token,
    }
  );

  if (response.statusCode == 200) {
    // 요청 성공, 서버에서의 추가 작업 처리
    // 요청 성공 시 메시지 박스 표시
    Fluttertoast.showToast(
        msg: '요청이 성공했습니다.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white
    );
  } else {
    // 요청 실패 처리
    Fluttertoast.showToast(
      msg: '요청이 실패했습니다.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  }
}


class _MyLoginState extends State<MyLogin> {
  var tab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD1CBC2),
      body: Center(
        child: Container(
          height: 355,
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
                      fontWeight: FontWeight.bold,
                      fontFamily: 'fontnanum',
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
                      fontWeight: FontWeight.w900,
                      fontFamily: 'fontnanum'),
                ),
              ),
              ButtonTheme(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                onPressed: () {
                  _handleKakaoLogin();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => MyApp()));
                },
                icon: Image.asset(
                  'images/main/kaka.png',
                  fit: BoxFit.contain,
                ),
                iconSize: 230,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
