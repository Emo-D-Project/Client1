import 'package:flutter/material.dart';
import 'package:capston1/main.dart';
import 'message_write.dart';
import 'package:intl/intl.dart';

class message extends StatefulWidget {
  final List<Map<String, dynamic>> messages;

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
              itemCount: widget.messages.length,
              itemBuilder: (context, index) {
                var message = widget.messages[index];
                return CustomContainer(
                  message: message['message'],
                  isSent: message['isSent'],
                  sentTime: message['sentTime'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class CustomContainer extends StatefulWidget {
  final String message; // 내용
  final bool isSent; // true - 보낸거 false - 받은거
  final String sentTime;

  const CustomContainer({
    Key? key,
    required this.message,
    required this.isSent,
    required this.sentTime,
  }) : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
//보낸 쪽지 시간
  String sentTime = DateFormat('MM/dd hh:mm').format(DateTime.now());

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
                              //보낸 쪽지인지 받은 쪽지인지
                              Container(
                                width: 100,
                                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Text(
                                  widget.isSent ? "보낸 쪽지" : "받은 쪽지",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: widget.isSent
                                        ? Colors.blue //보낸 쪽지
                                        : Colors.green, //받은 쪽지
                                  ),
                                ),
                              ),
                              Expanded(child: Container()),
                              //시간
                              Container(
                                width: 100,
                                padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                child: Text(
                                  widget.isSent ? sentTime : '',
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
                              widget.message,
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
