import 'package:flutter/material.dart';
import 'package:capston1/main.dart';
import 'message.dart';
import 'package:intl/intl.dart';
import 'models/Message.dart';

class message_write extends StatefulWidget {
  const message_write({Key? key}) : super(key: key);

  @override
  State<message_write> createState() => _message_writeState();
}

class _message_writeState extends State<message_write> {

  final _contentEditController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  // 메세지 전송 함수임 - 전송 버튼을 눌렀을 때  근데.. 이제 이게 보낸 쪽지가 되는..?
  void _sendMessage() {
    String message = _contentEditController.text;
    // // Message 클래스를 사용하여 메시지 객체 생성
    // Message newMessage = Message(
    //   senderId: 1, // 현재 사용자의 ID
    //   receiverId: 2, // 선택된 대화 상대방의 ID
    //   content: _contentEditController.text, // 텍스트 입력 필드에서 얻은 메시지 내용
    //   dateTime: DateTime.now(), // 현재 날짜와 시간
    // );
    if (message.isNotEmpty) {
      String sentTime = DateFormat('MM/dd hh:mm').format(DateTime.now());

      setState(() {
        messages.add({'content': message, 'receiverId': 2, 'senderId': 1, 'sendtime': DateTime.now(),
        });
      });
      print('보낸 사람: ${messages.last['senderId']}, 전송된 메세지: $message, 전송 시간: $sentTime');
      // Clear the text field after sending the message
   //   _contentEditController.clear();
    }
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
          "쪽지를 보내보세요 ",
          style: TextStyle(
            fontSize: 23,
            fontFamily: 'soojin',
            color: Color(0xFF968C83),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  message(messages: messages)),
            );
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF968C83)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _sendMessage();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => message(messages: messages)),
              );// 메세지를 전송하는 함수 호출
            },
            child: Text("전송"),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF968C83),
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              minimumSize: Size(50, 30),
              textStyle: TextStyle(fontSize: 13,fontFamily: 'soojin'),
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
                              hintText: '내용을 입력해주세요',
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