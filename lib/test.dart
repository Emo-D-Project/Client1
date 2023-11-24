import 'package:capston1/message_write.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:capston1/main.dart';

import 'message.dart';

class YourChatScreen extends StatefulWidget {
  // 다른 코드...

  @override
  _YourChatScreenState createState() => _YourChatScreenState();
}

class _YourChatScreenState extends State<YourChatScreen> {
  // 서버에서 받아온 쪽지 데이터
  List<Map<String, dynamic>> messages = [];
  ApiManager apiManager = ApiManager().getApiManager();

  // 데이터 불러오는 함수
  Future<void> fetchData() async {
    try {
      // /api/messages 엔드포인트로부터 메시지 데이터 가져오기
      List<dynamic> response = await ApiManager.apiManager.GetMessage('/api/messages');

      // 가져온 데이터를 List로 변환
      List<Map<String, dynamic>> parsedMessages = response
          .map((message) => {
        'content': message['content'],
        'senderId': message['senderId'],
        'receiverId': message['receiverId'],
        'sentAt': DateTime.parse(message['sentAt']),
      })
          .toList();


      // 가져온 데이터를 상태에 반영
      setState(() {
        messages = parsedMessages;
      });
    } catch (e) {
      // 예외 발생 시 처리
      print('에러 발생: $e');
      // 예외를 처리하거나 사용자에게 알릴 수 있음
      // 예를 들어, ScaffoldMessenger 또는 showDialog를 사용하여 에러 메시지 표시
    }
  }


  @override
  void initState() {
    super.initState();
    // 여기에서 서버에서 쪽지 데이터를 가져오는 로직을 추가합니다.
    // 예를 들어, 비동기 함수를 호출하여 데이터를 받아올 수 있습니다.
    fetchData(); // fetchData는 실제로 쓰이는 함수명이므로 필요에 따라 변경하세요.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xFFF8F5EB),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "채팅방입니다",
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'kim',
                color: Color(0xFF968C83),
              ),
            ),
            SizedBox(width: 110), // 간격 조절
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => message_write()),
                );
              },
              icon: Image.asset(
                'images/send/real_send.png',
                height: 50, // 이미지 높이 조절
                width: 30, // 이미지 너비 조절
              ),
            ),
          ],
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
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return ListTile(
                  title: Text(message['content']),
                  subtitle: Text(
                    '${message['sentAt'].year}-${message['sentAt'].month}-${message['sentAt'].day} ${message['sentAt'].hour}:${message['sentAt'].minute}',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}
