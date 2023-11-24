import 'package:capston1/main.dart';
import 'package:capston1/screens/ChatRoomScreen.dart';
import 'package:capston1/writediary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'message.dart';
import 'message_write.dart';
import 'models/ChatRoom.dart';
import 'network/api_manager.dart';

//알람 좋아요 텍스트 형태
Widget A_good = Row(
  children: [
    Column(
      children: [
        Container(
          //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image.asset(
            'images/send/heart.png',
            width: 16,
          ),
        ),
      ],
    ),
    SizedBox(width: 5),
    Text(
      "누군가 회원님의 일기에 공감햡니다.",
      style: TextStyle(fontFamily: 'soojin', fontSize: 13),
    ),
    SizedBox(
      height: 25,
    )
  ],
);

//---------------------------------------------------------------------------------------

final DateTime smonth = DateTime(DateTime.now().month, 3);  // ~월의 감정 통지서

class shareData {
  final DateTime smonth;

  shareData({
    required this.smonth,
  });
}

//알람 - 이모디 새소식
class A_Emod extends StatefulWidget {
  final DateTime stitle;

  const A_Emod({super.key,
    required this.stitle,
  });

  @override
  State<A_Emod> createState() => _A_EmodState();
}

class _A_EmodState extends State<A_Emod> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 11),
              child: Image.asset(
                'images/send/cat_real_image.png',
                width: 16,
              ),
            ),
          ],
        ),
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "EMO:D 가 새 소식을 보냈습니다.",
              style: TextStyle(
                fontFamily: 'soojin',
                fontSize: 13,
              ),
            ),
            Text(
             '${smonth.month}월의 감정 통지서가 도착했습니다!' ,
              style: TextStyle(fontFamily: 'soojin', fontSize: 13),
            ),
          ],
        ),
        SizedBox(
          height: 45,
        )
      ],
    );
    ;
  }
}
//---------------------------------------------------------------------------------------

//알람 - 댓글 알람
Widget A_Chat = Row(
  children: [
    Column(
      children: [
        Container(
          child: Image.asset(
            'images/send/real_chat.png',
            width: 15,
          ),
        ),
      ],
    ),
    SizedBox(width: 5),
    Text(
      "새로운 댓글이 달렸습니다",
      style: TextStyle(fontFamily: 'soojin', fontSize: 13),
    ),
    SizedBox(
      height: 10,
    )
  ],
);

//알람 - 문의내역 알람
Widget A_Question = Row(
  children: [
    Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 28),
          child: Image.asset(
            'images/send/question.png',
            width: 15,
          ),
        ),
      ],
    ),
    SizedBox(width: 5), // 아이콘과 텍스트 사이의 간격 조절
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "문의 내역",
          style: TextStyle(
            fontFamily: 'soojin',
            fontSize: 13,
          ),
        ),
        Text(
          "남겨주신 문의에 답변이 등록 되었어요.\nEMO:D : '문의 주셔서 감사합...'",
          style: TextStyle(fontFamily: 'soojin', fontSize: 13),
        ),
      ],
    ),
    SizedBox(
      height: 50,
    )
  ],
);

//---------------------------------------------------------------------------------------

//알람- 쪽지 알람
Widget A_Message = Row(
  children: [
    Column(
      children: [
        Container(
          child: Image.asset(
            'images/send/mail.png',
            width: 15,
          ),
        ),
      ],
    ),
    SizedBox(width: 5),
    Text(
      "쪽지가 왔습니다!",
      style: TextStyle(fontFamily: 'soojin', fontSize: 13),
    ),
    SizedBox(
      height: 30,
    )
  ],
);


//---------------------------------------------------------------------------------------

class alrampage extends StatelessWidget {
  const alrampage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xFFF8F5EB),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(
              "EMO:D",
              style: TextStyle(
                  color: Color(0xFF968C83), fontFamily: 'kim', fontSize: 30),
            ),
            bottom: TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.brown,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  text: "ALRAM",
                ),
                Tab(
                  text: "MESSAGE",
                )
              ],
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(), // 스와이프 비활성화
            children: [
              FirstScreen(),
              SecondScreen(),
            ],
          ),
        ));
  }
}

//---------------------------------------------------------------------------------------

// 언제 뭔 알람 온지
class Item {
  String title;
  List<Widget> contentList;

  Item({required this.title, required this.contentList});
}

//알람
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    List<Item> itemList = [
      Item(title: '오늘', contentList: [A_good, A_good, A_Emod(stitle: smonth), A_Question]),
      Item(title: '어제', contentList: [A_Chat, A_Message]),
      Item(title: '5일전', contentList: [A_Question, A_good, A_good]),
    ];

    return Center(
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: itemList.length,
              itemBuilder: (BuildContext context, int index) {
                Item item = itemList[index];
                return Container(
                  width: sizeX * 0.9,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: Text(
                          item.title,
                          style: TextStyle(
                            fontFamily: 'soojin',
                            fontSize: 17,
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 6,
                            ),
                            Column(
                              children: item.contentList,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 10,
                thickness: 1.0,
                color: Color(0xFFCEC5BE),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                height: 1,
                color: Color(0xFFCEC5BE),
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: Center(
                  child: Text(
                    "알림은 30일 이후 순차적으로 지워집니다",
                    style: TextStyle(
                      fontFamily: 'soojin',
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


//---------------------------------------------------------------------------------------

// 메세지 파트
class SecondScreen extends StatefulWidget {

  static String smile = 'images/emotion/1.gif';
  static String flutter = 'images/emotion/2.gif';
  static String angry = 'images/emotion/angry.png';
  static String annoying = 'images/emotion/4.gif';
  static String tired = 'images/emotion/5.gif';
  static String sad = 'images/emotion/6.gif';
  static String calmness = 'images/emotion/7.gif';

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  //-------------------------------------------------------------------------------
  ApiManager apiManager = ApiManager().getApiManager();

  late String message_content = " ";
  late int sender_Id ;
  late int receiver_Id;
  late DateTime sentAt;

  List<ChatRoom> chatRooms = [
    //ChatRoom(id: "2", name: "Room 2"),
    // ... 다른 채팅방들
  ];

  @override
  void initState() {
    super.initState();
    print("message.dart입장 ");
    // 서버로부터 채팅방 목록 불러오기
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try{
      final data = await apiManager.getChatList();
      setState(() {
        chatRooms = data! as List<ChatRoom>;
      });
    }
    catch (error) {
      // 에러 제어하는 부분
      print('Error getting chat list: $error');
    }

  }

  // 화면을 갱신하는 메서드
  void _updateScreen() {
    // setState()를 호출하여 상태를 변경하고 화면을 다시 그림
    setState(() {
      //myData = '갱신된 값';
    });
  }

  // 서버에서 가져온 가상의 채팅방 목록



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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF8F5EB),

      body: ListView.builder(
        itemCount: chatRooms.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chatRooms[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(chatRooms[index].lastMessage),
                Text(
                  DateFormat('yyyy-MM-dd HH:mm').format(chatRooms[index].lastMessageSentAt),
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
            onTap: () {
              // 선택한 채팅방으로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoomScreen(chatRoom: chatRooms[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MessageData {
  final String content;
  final String imagePath;
  bool isRead; // 읽음 여부를 보여줌

  MessageData({
    required this.content,
    required this.imagePath,
    this.isRead = false, // 기본값은 안읽음
  });
}

class CustomContainer extends StatefulWidget {
  final String name;
  final String content;
  final String imagePath;
  final MessageData isRead;

  CustomContainer({
    required this.name,
    required this.content,
    required this.imagePath,
    required this.isRead,
  });

  @override
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    // 메세지를 누르면 읽음으로 표시가 됨
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const message(
                      messages: [],
                    )));
        //MaterialPageRoute(builder: (context) => YourChatScreen(),
        setState(() {
          widget.isRead.isRead = true;
        });
      },
      child: Container(
        width: sizeX * 0.9,
        child: Container(
          width: double.infinity,
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Text(
                        widget.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                      child: Text(
                        widget.content,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),

              // 빨간색 아이콘 (읽으면 없어지고 안읽으면 있음)
              Visibility(
                visible: !widget.isRead.isRead,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  width: 20,
                  height: 20,
                  child: Icon(Icons.circle, color: Colors.redAccent, size: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
