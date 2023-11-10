import 'package:flutter/material.dart';
import 'package:capston1/main.dart';
import 'message_write.dart';
import 'package:intl/intl.dart';

final String start = DateTime.now().toString();
String formattedDate = DateFormat('MM/dd h:mm').format(DateTime.now());


class message extends StatefulWidget {
  const message({super.key});

 
  @override
  State<message> createState() => _messageState();
}

//채팅방
class _messageState extends State<message> {

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
                width: 30,  // 이미지 너비 조절
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
          customContainer(
            message: "안녕하세요!",
            isSent: true,



          ),
          customContainer(
            message: "안녕하세요!",
            isSent: false,
          ),
        ],
      ),
    );
  }
}


//컨테이너 만들었어요
class customContainer extends StatefulWidget {

  final String message;  // 내용
  final bool isSent;  // true - 보낸거 false - 받은거

  const customContainer({
    Key? key,
    required this.message,
    required this.isSent,
  }) : super(key: key);

  @override
  State<customContainer> createState() => _customContainerState();
}

class _customContainerState extends State<customContainer> {
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
                              Container(
                                width: 100,
                             //   color: Colors.cyan,
                                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Text(
                                  widget.isSent ? "보낸 쪽지" : "받은 쪽지",
                                  //이름은 고정
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: widget.isSent ? Colors.blue : Colors.green,
                                  //보낸 쪽지- blue 받은 쪽지 - green
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              Container(
                                width: 100,
                          //      color: Colors.cyan,
                                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Text(
                                  formattedDate, // 현재 날짜와 시간을 표시
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
                          Container(
                            width: double.infinity,
               //           color: Colors.lightGreen,
                            padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                            child: Text(
                              widget.message,
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SizedBox(height: 10,),
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
