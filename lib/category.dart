import 'package:capston1/alramsetting.dart';
import 'package:capston1/main.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'mypage.dart';
import 'alramsetting.dart';
import 'diaryReplay.dart';

class category extends StatelessWidget {
  const category({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF8F5EB),
        title: Text("CATEGORY",
          style: TextStyle(fontSize: 30, fontFamily: 'kim',color: Color(0xFF968C83),),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyApp()));
          },
          icon: Icon(Icons.arrow_back_ios,color: Color(0xFF968C83),),
        ),
      ),
      body: Container(
        //맨 밑에 깔린 body
        width: sizeX,
        height: sizeY,
        decoration: BoxDecoration(color: Color(0xFFF8F5EB),),
        child: Container(
          //흰 박스 올라온 화면
          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
          padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 130,
                  height: 5,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  color: Color.fromRGBO(117, 117, 117, 100),
                ),
              ), //맨 위에 줄같은거
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text("유저 설정",style: TextStyle(fontSize: 15,fontFamily: 'soojin',color: Color(0xFF7D5A50)),)
                  ), //유저 설정
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const mypage()));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person_2_outlined, color: Colors.black,size: 25,),
                          SizedBox(width: 5,),
                          Text("마이 페이지",style: TextStyle(color: Colors.black,fontSize: 15, fontFamily: 'soojin')),
                        ],
                      ),
                    ),
                  ), //마이페이지
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const alramsetting()));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.access_alarm, color: Colors.black,size: 25,),
                          SizedBox(width: 5,),
                          Text("알람 설정",style: TextStyle(color: Colors.black,fontSize: 15, fontFamily: 'soojin')),
                        ],
                      ),
                    ),
                  ), //알람 설정
                ],
              ), //유저 설정 칸
              Center(
                child: Container(
                  //칸 나누는 줄
                  color: Color.fromRGBO(125, 90, 80, 100),
                  width: 250, height: 2,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text("지원",style: TextStyle(fontSize: 15,fontFamily: 'soojin',color: Color(0xFF7D5A50)))
                  ), //지원
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.person_2_outlined, color: Colors.black,size: 25,),
                          SizedBox(width: 5,),
                          Text("의견 보내기",style: TextStyle(color: Colors.black,fontSize: 15, fontFamily: 'soojin')),
                        ],
                      ),
                    ),
                  ), //의견보내기
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.person_2_outlined, color: Colors.black,size: 25,),
                          SizedBox(width: 5,),
                          Text("자주 하는 질문",style: TextStyle(color: Colors.black,fontSize: 15, fontFamily: 'soojin')),
                        ],
                      ),
                    ),
                  ), //자주 하는 질문
                ],
              ), //지원 칸
              Center(
                child: Container(
                  //칸 나누는 줄
                  color: Color.fromRGBO(125, 90, 80, 100),
                  width: 250, height: 2,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Text("기타",style: TextStyle(fontSize: 15,fontFamily: 'soojin',color: Color(0xFF7D5A50)))
                  ), //기타
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => diaryReplay(date: '20230725')));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.person_2_outlined, color: Colors.black,size: 25,),
                          SizedBox(width: 5,),
                          Text("앱 정보",style: TextStyle(color: Colors.black,fontSize: 15, fontFamily: 'soojin')),
                        ],
                      ),
                    ),
                  ), //앱정보
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 30,),
                          Text("로그아웃", style: TextStyle(color: Colors.black, fontFamily: 'soojin')),
                        ],
                      ),
                    ),
                  ), //로그아웃
                  SizedBox(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        backgroundColor: Colors.white,
                      ),
                      onPressed: () {
                        _showDialog(context);
                      },
                      child: Row(
                        children: [
                          SizedBox(width: 30,),
                          Text("회원탈퇴", style: TextStyle(color: Colors.black,fontSize: 15, fontFamily: 'soojin')),
                        ],
                      ),
                    ),
                  ), //회원탈퇴
                ],
              ), //기타 칸
            ],
          ),
        ), //흰박스
      ),
    );
  }
}

Future<dynamic> _showLogoutDialog(BuildContext context) {
  final sizeY = MediaQuery.of(context).size.height;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(' '),
      content: SizedBox(
        height: sizeY*0.05,
        child: Center(child: Text("정말 로그아웃 하시겠습니까?", style: TextStyle(fontFamily: 'soojin'),))
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.amber,
                minimumSize: Size(150, 30)
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소',style: TextStyle(color: Colors.black,fontSize: 20, fontFamily: 'soojin'))),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.blue,
                minimumSize: Size(150, 30)
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('확인',style: TextStyle(color: Colors.black,fontSize: 20, fontFamily: 'soojin'))),
      ],
    ),
  );
}

Future<dynamic> _showDialog(BuildContext context) {
  final sizeY = MediaQuery.of(context).size.height;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(' '),
      content: SizedBox(
        height: sizeY*0.07,
        child: Center(
          child: Text("회원 탈퇴 시, 작성된 일기들은 "
              "모두 삭제됩니다. 정말로 탈퇴하시겠습니까?", style: TextStyle(fontFamily: 'soojin'),),
        ),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.amber,
                minimumSize: Size(150, 30)
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소',style: TextStyle(color: Colors.black,fontSize: 20))),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.blue,
                minimumSize: Size(150, 30)
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('확인',style: TextStyle(color: Colors.black,fontSize: 20))),
      ],
    ),
  );
}