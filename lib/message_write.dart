import 'package:flutter/material.dart';
import 'package:capston1/main.dart';

class message_write extends StatefulWidget {
  const message_write({super.key});

  @override
  State<message_write> createState() => _message_writeState();
}
class _message_writeState extends State<message_write> {
  @override

  late String content = _contentEditController.text;
  final _contentEditController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF8F5EB),
        title: Text(
          "쪽지보내기",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'kim',
            color: Color(0xFF968C83),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF968C83)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              // "전송" 버튼이 눌렸을 때 실행되는 코드
            },
            child: Text("전송"),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF968C83), // 버튼의 배경색
              onPrimary: Colors.white, // 버튼 텍스트의 색상
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), // 버튼의 모양을 조절합니다.
              ),
              minimumSize: Size(50, 50),
              padding: EdgeInsets.fromLTRB(8, 12, 8, 12),// 버튼의 최소 크기
              textStyle: TextStyle(fontSize: 12), // 버튼 텍스트 스타일
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    color: Colors.yellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 400,
                          height: 700,
                          color: Colors.deepOrange,
                          padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                          child: TextField(
                            style: TextStyle(fontFamily: 'soojin'),
                            controller: _contentEditController,
                            maxLines: 10,
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ))),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

