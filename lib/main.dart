import 'package:flutter/material.dart';
import 'category.dart';
import 'calendar.dart';
import 'diaryshare.dart';
import 'home.dart';
import 'style.dart' as style;

void main() async{

  runApp(MaterialApp(theme: style.theme, home: MyApp()));
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
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("EMO:D", style: TextStyle(fontFamily: 'fontnanum'),),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>const category())
            );
          },
          icon: Icon(Icons.menu),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>const category())
                );
              },
              icon: Icon(Icons.notifications_none)
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: [home(), diaryshare(), calendar()][tab],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(248, 245, 235, 100),
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
            icon: Image.asset("images/bottom/free-icon-home-8637633.png", width: 30, height: 30, color: Colors.black,),
          ),
          BottomNavigationBarItem(
            label: '두 번째 화면',

            icon: Image.asset("images/bottom/free-icon-globe-721998.png", width: 30, height:30, color: Colors.black,),

          ),
          BottomNavigationBarItem(
            label: '세 번째 화면',
            icon: Image.asset("images/bottom/free-icon-calendar-5115146.png",width: 30, height: 30, color: Colors.black,),
          ),
        ],
      ),
    );
  }
}