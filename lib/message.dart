import 'package:flutter/material.dart';
import 'package:capston1/main.dart';
import 'message_write.dart';
import 'package:intl/intl.dart';

class message extends StatefulWidget {
  final List<Map<String, dynamic>> messages; // massages 변수 생성

  const message({Key? key, required this.messages}) : super(key: key);


  @override
  State<message> createState() => _MessageState();
}

class _MessageState extends State<message> {


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
                                      return "받은 쪽지";
                                    } else {
                                      return "보낸 쪽지";
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
