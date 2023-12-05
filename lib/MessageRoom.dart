import 'package:flutter/material.dart';
import 'message_write.dart';
import 'package:intl/intl.dart';
import 'models/Message.dart';
import 'network/api_manager.dart';

class MessageRoom extends StatefulWidget {
  final int otherUserId;

  const MessageRoom({super.key, required this.otherUserId});

  @override
  State<MessageRoom> createState() => _MessageRoomState(otherUserId);
}

class _MessageRoomState extends State<MessageRoom> {
//보낸 쪽지 시간
  String sendtime = DateFormat('MM/dd hh:mm').format(DateTime.now());
  final int otherUserId;

  // 상대방과의 대화 나눈 메시지 리스트
  List<Message> messageList = [];

  _MessageRoomState(this.otherUserId); // 생성자 수정

  ApiManager apiManager = ApiManager().getApiManager();

  @override
  void initState() {
    super.initState();
    print("메시지 목록 갱신 ");
    fetchDataFromServer();
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

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  MaterialPageRoute(
                    builder: (context) =>
                        message_write(otherUserId: otherUserId),
                  ),
                ).then((value) async {
                  // 이 부분은 message_write 화면이 닫힌 후에 실행됩니다.
                  // 여기서 MessageRoom 화면을 갱신하고 싶은 작업을 수행
                  await Future.delayed(Duration(seconds: 1)); // 1초 대기
                  fetchDataFromServer();
                });
              },
              icon: Image.asset(
                'images/send/real_send.png',
                height: 50, // 이미지 높이 조절
                width: 30, // 이미지 너비 조절
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: messageList.length,
        itemBuilder: (BuildContext context, int index) {
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
                                            () {
                                              if (messageList[index].receiverId == otherUserId) {
                                              return "보낸 쪽지";
                                            } else {
                                              // 만약 otherUserId가 아닌 다른 유저에게 보낸 쪽지라면
                                              return "받은 쪽지";
                                            }

                                        }(),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: () {
                                            if (messageList[index].receiverId == otherUserId) {
                                              return Colors.blue; // 보낸 쪽지
                                            } else {
                                              return Colors.green; // 받은 쪽지
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
                                        DateFormat('MM/dd hh:mm').format(
                                            messageList[index].sendtime),
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
                                // 채팅 내용
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.fromLTRB(10, 3, 0, 0),
                                  child: Text(
                                    messageList[index].content,
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
        },
      ),
    );
  }
}