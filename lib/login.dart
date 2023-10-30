import 'package:flutter/material.dart';
import 'package:capston1/home.dart';
import 'style.dart' as style;
import 'package:capston1/main.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  await initializeDateFormatting();
  runApp(MaterialApp(theme: style.theme, home: MyLogin()));
}

class MyLogin extends StatefulWidget {
  MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
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
