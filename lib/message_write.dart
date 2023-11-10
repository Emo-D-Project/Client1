import 'package:flutter/material.dart';
import 'package:capston1/main.dart';

class message_write extends StatefulWidget {
  const message_write({super.key});

  @override
  State<message_write> createState() => _message_writeState();
}

class _message_writeState extends State<message_write> {



  final _contentEditController = TextEditingController();

  // 메세지 전송 함수 - 전송 버튼을 눌렀을 때 호출이 되는 함수
  void _sendMessage() {
    String message = _contentEditController.text; // 이건 쪽지 내용..
    print('전송된 메세지: $message'); //콘솔창에 뜸

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF8F5EB),
        title: Text(
          "쪽지를 보내보세용 ",
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
              _sendMessage(); // 메세지를 전송하는 함수 호출
            },
            child: Text("전송"),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF968C83),
              onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
              minimumSize: Size(54, 54), // 버튼의 최소 크기 설정
              padding: EdgeInsets.all(5), // 동그라미 모양에 맞게 여백 조절
              textStyle: TextStyle(fontSize: 13),
              
            ),
          ),

        ],
      ),

      // 전송버튼 누르면
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 350,
                          height: 600,
                          padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                          child: TextField(
                            style: TextStyle(fontFamily: 'soojin'),
                            controller: _contentEditController,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: '여기에 입력을 해주세요',
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                              ),
                            ),
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
