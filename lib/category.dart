import 'package:flutter/material.dart';

class category extends StatelessWidget {
  const category({super.key});

  @override
  Widget build(BuildContext context) {

    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(248, 245, 235, 100),
        title: Text("EMO:D", style: TextStyle(fontFamily: 'fontnanum'),),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=>const category())
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(//맨 밑에 깔린 body
        width: sizeX,
        height: sizeY,
        color: Color.fromRGBO(248, 245, 235, 100),
        child: Container(//흰 박스 올라온 화면
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )
            ),
          child: Column(
            children: [
              Container(
                width: 100, height: 5,
                margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                color: Color.fromRGBO(117, 117, 117, 100),
              ),//맨 위에 줄같은거
              Column(
                children: [
                  SizedBox(child: Text("유저 설정")),//유저 설정
                  Container(),//마이페이지
                  Container(),//알람 설정
                ],
              ), //유저 설정 칸
              Container(//칸 나누는 줄
                color: Color.fromRGBO(125, 90, 80, 100),
                width: 250, height: 2,
              ),
              Column(
                children: [
                  Container(),//지원
                  Container(),//의견보내기
                  Container(),//자주 하는 질문
                ],
              ),//지원 칸
              Container(//칸 나누는 줄
                color: Color.fromRGBO(125, 90, 80, 100),
                width: 250, height: 2,
              ),
              Column(children: [
                Container(),//기타
                Container(),//앱정보
                Container(),//로그아웃
                Container(),//회원탈퇴
              ],),//기타 칸
            ],
          ),
        ),//흰박스
      ),
    );
  }
}
