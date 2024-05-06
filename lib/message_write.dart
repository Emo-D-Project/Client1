import 'package:capston1/category.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:capston1/MessageRoom.dart';
import 'alrampage.dart';
import 'config/fcm_setting.dart';
import 'main.dart';
import 'models/Message.dart';

class message_write extends StatefulWidget {
  final int otherUserId;

  const message_write({Key? key, required this.otherUserId}) : super(key: key);

  @override
  State<message_write> createState() => _message_writeState(otherUserId);
}

class _message_writeState extends State<message_write> {
  final int otherUserId; // 대화할 상대 id(식별자)
  TextEditingController _contentEditController = TextEditingController();
  List<Map<String, dynamic>> messages = [];

  ApiManager apiManager = ApiManager().getApiManager();

  _message_writeState(this.otherUserId);

  // int Myid = 0;

  List<Message> messageList = [];
  String latestMessage = " ";

  @override
  void initState() {
    fetchDataFromServer();

    super.initState();
  }

  // 서버로부터 데이터를 가져오는 함수
  Future<void> fetchDataFromServer() async {
    try {
      // 상대방과의 대화나눈 메시지 가져오기
      final data = await apiManager.getMessageList(otherUserId);

      setState(() {
        messageList = data!;
      });
    } catch (error) {
      // 에러 제어하는 부분
      print('Error getting chat list: $error');
    }
  }

  //알람 실행
  void _sendNotification(String title, String body) async {
    try {
     //int targetUserId = otherUserId;
       int targetUserId = 1;
      print("///////////////");
      print(targetUserId);
      print(title);
      print(body);
      print(".........");

      apiManager.sendNotification(targetUserId, title, body);

      setState(() {
        latestMessage = body;
      });


      print('쪽지 알람실행');
    } catch (error) {
      print('Error sending write message notification : $error');
    }
  }

  // 메세지 전송 함수
  void _sendMessage() {
    String writeMessage = _contentEditController.text;
    if (writeMessage.isNotEmpty) {
      apiManager.sendMessage(writeMessage, otherUserId, DateTime.now());
      _contentEditController.clear();

      // 알림 생성 및 전송
      String title = "쪽지가 왔습니다!";
      String body = writeMessage.length > 6
          ? writeMessage.substring(0,6) + "..."
          : writeMessage;
      _sendNotification(title, body);

      Navigator.pop(context);
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
            fontFamily: 'kim',
            color: Color(0xFF968C83),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Color(0xFF968C83)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              _sendMessage(); // 이 부분에 추가해줘
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => MessageRoom(otherUserId: otherUserId)),);
              //
            },
            child: Text("전송"),
            style: ElevatedButton.styleFrom(
              elevation: 0,
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              primary: Color(0xFFF8F5EB),
              onPrimary: Color(0xFF968C83),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              minimumSize: Size(50, 30),
              textStyle: TextStyle(
                  fontSize: 16, fontFamily: 'kim', fontWeight: FontWeight.bold),
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
