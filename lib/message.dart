import 'package:flutter/material.dart';
import 'package:capston1/main.dart';
import 'message_write.dart';
import 'package:intl/intl.dart';
import 'network/api_manager.dart';

class message extends StatefulWidget {
  final List<Map<String, dynamic>> messages; // massages 변수 생성

  const message({Key? key, required this.messages}) : super(key: key);


  @override
  State<message> createState() => _MessageState();
}

class _MessageState extends State<message> {

  //-------------------------------------------------------------------------------
  ApiManager apiManager = ApiManager().getApiManager();

  late String message_content = " ";
  late int sender_Id ;
  late int receiver_Id;
  late DateTime sentAt;

// 화면을 갱신하는 메서드
  void _updateScreen() {
    // setState()를 호출하여 상태를 변경하고 화면을 다시 그림
    setState(() {
      //myData = '갱신된 값';
    });
  }

  Future<void> GetMessage(String endpoint) async {
    try {
      final response = await apiManager.Get(endpoint); // 실제 API 엔드포인트로 대체

      // 요청 응답 받기
      final value = response['content']; // 키를 통해 value를 받아오기
      print('content: $value');
      message_content = value;

      //title = response['title'];
    } catch (e) {
      print('Error: $e');
    }
    // 보낸 쪽지
    try {
      final response = await apiManager.Get(endpoint); // 실제 API 엔드포인트로 대체

      // 요청 응답 받기
      final value = response['senderId']; // 키를 통해 value를 받아오기
      print('senderId: $value');
      sender_Id = value;

      //title = response['title'];
    } catch (e) {
      print('Error: $e');
    }
    //받은 쪽지
    try {
      final response = await apiManager.Get(endpoint); // 실제 API 엔드포인트로 대체

      // 요청 응답 받기
      final value = response['receiverId']; // 키를 통해 value를 받아오기
      print('receiverId: $value');
      receiver_Id = value;

      //title = response['title'];
    } catch (e) {
      print('Error: $e');
    }

    // 보낸 시간
    try {
      final response = await apiManager.Get(endpoint); // 실제 API 엔드포인트로 대체

      // 요청 응답 받기
      final value = response['sentAt']; // 키를 통해 value를 받아오기
      print('sentAt: $value');
      sentAt = value;

      //title = response['title'];
    } catch (e) {
      print('Error: $e');
    }
  }

  /*Future<void> PostMyPage(String endpoint) async {
    ApiManager apiManager = ApiManager().getApiManager();

    try {
      final postData = {

      };

      print(postData);

      await apiManager.post(endpoint, postData); // 실제 API 엔드포인트로 대체
    } catch (e) {
      print('Error: $e');
    }
  }*/
  //-------------------------------------------------------------------------------


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
                  MaterialPageRoute(builder: (context) => message_write()
                  ),
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
              itemCount: widget.messages.length, // widget.messages의 길이를 사용하여 메시지 목록의 항목 수 나타내기
              itemBuilder: (context, index) {   // itmeBuilder는 아이템을 어떻게 생성을 할 지 정의하는 함수임
                var message = widget.messages[index]; // 그리고 여기서는  widget.messages에서 해당 인덱스에 해당하는 메시지를 가져와 CustomContainer 위젯으로 반환함
                return CustomContainer(

                  content: message['content'],  // 메세지 내용
                  sendtime: message['sendtime'], // 보낸 사람
                  receiverId: message['receiverId'], // 받은 쪽지
                  senderId: message['senderId'],//보낸 쪽지

                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
//------------------------------------------------------------------------------------
class CustomContainer extends StatefulWidget {
  final int senderId;   //보낸 아이디
  final int receiverId; //받은 아이디
  final String content; // 내용
  final DateTime sendtime;   //보낸 시간

  const CustomContainer({
    Key? key,
    required this.content,
    required this.receiverId,
    required this.senderId,
    required this.sendtime
  }) : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
//보낸 쪽지 시간
  String sendtime = DateFormat('MM/dd hh:mm').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    return Row(
      children: [
        Column(
          children: [
            Container(
              width: sizeX,
              child: Container(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              // 보낸 쪽지인지 받은 쪽지인지
                              Container(
                                width: 100,
                                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Text(
                                  // senderId와 receiverId를 비교하여 쪽지 유형 결정
                                      () {
                                    if (widget.senderId == widget.receiverId) {
                                      return "보낸 쪽지 ";
                                    } else {
                                      return "받은 쪽지";
                                    }
                                  }(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: () {
                                      if (widget.senderId == widget.receiverId) {
                                        return Colors.green; // 받은 쪽지
                                      } else {
                                        return Colors.blue; // 보낸 쪽지
                                      }
                                    }(),
                                  ),
                                ),
                              ),

                              Expanded(child: Container()),
                              // 시간
                              Container(
                                width: 100,
                                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Text(
                                  sendtime, // 보낸 쪽지든 받은 쪽지든 모두 시간 표시
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //채팅 내용
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                            child: Text(
                              widget.content,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            color: Color(0xFFCEC5BE),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
