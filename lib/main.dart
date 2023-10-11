import 'package:flutter/material.dart';
import 'category.dart';
import 'calendar.dart';
import 'diaryshare.dart';
import 'home.dart';

void main() async{

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key) ;

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {
  var tab =0;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("AppBar"),
      ),
      body: [category(), home(), diaryshare(), calendar()][tab],
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,//선택되지 않은 하단바의 label 숨기기
        showSelectedLabels: false, //선택된 하단바의 label 숨기기
        currentIndex: tab, //현재 select된 bar item의 index, 변수 tab부터 시작
        type: BottomNavigationBarType.fixed,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: '첫 번째 화면',
            icon: Icon(Icons.heart_broken,),
          ),
          BottomNavigationBarItem(
            label: '두 번째 화면',
            icon: Icon(Icons.star, ),
          ),
          BottomNavigationBarItem(
            label: '세 번째 화면',
            icon: Icon(Icons.square, ),
          ),
          BottomNavigationBarItem(
            label: '첫 번째 화면',
            icon: Icon(Icons.access_alarm_rounded,),
          ),
        ],
      ),
    );
  }
}