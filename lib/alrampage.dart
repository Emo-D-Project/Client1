import 'package:capston1/main.dart';
import 'package:capston1/MessageRoom.dart';
import 'package:capston1/models/notification.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'diaryshare.dart';
import 'models/ChatRoom.dart';
import 'network/api_manager.dart';
import 'package:capston1/otherMypage.dart';
import 'comment.dart';
import 'package:capston1/models/Comment.dart';
import 'models/Navigator.dart';

List<Comment> commentList = [];

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
      height: 40,
    )
  ],
);

//감정 통지서 텍스트 형태
Widget A_Emod = Row(
  children: [
    Column(
      children: [
        Container(
          //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image.asset(
            'images/send/cat_real_image.png',
            width: 16,
          ),
        ),
      ],
    ),
    SizedBox(width: 5),
    Text(
      "Emo:D가 이 달의 감정 통지서를 보냈습니다!",
      style: TextStyle(fontFamily: 'soojin', fontSize: 13),
    ),
    SizedBox(
      height: 35,
    )
  ],
);

//감정 통지서 텍스트 형태
Widget A_DEmod = Row(
  children: [
    Column(
      children: [
        Container(
          //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Image.asset(
            'images/send/cat_real_image.png',
            width: 16,
          ),
        ),
      ],
    ),
    SizedBox(width: 5),
    Text(
      "오늘 당신의 하루는 어땠나요?",
      style: TextStyle(fontFamily: 'soojin', fontSize: 13),
    ),
    SizedBox(
      height: 35,
    )
  ],
);

final DateTime smonth = DateTime(DateTime.now().month, 11); // ~월의 감정 통지서

class shareData {
  final DateTime smonth;

  shareData({
    required this.smonth,
  });
}

//알람 - 댓글 알람
class A_Chat extends StatelessWidget {
  final String latestComment;

  const A_Chat(this.latestComment);

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "새로운 댓글이 달렸습니다.",
              style: TextStyle(
                fontFamily: 'soojin',
                fontSize: 13,
              ),
            ),
            Text(
              latestComment,
              style: TextStyle(fontFamily: 'soojin', fontSize: 13),
            ),
          ],
        ),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}

//쪽지 알람
class A_Message extends StatelessWidget {
  final String latestMessage;

  const A_Message(this.latestMessage);

  @override
  Widget build(BuildContext context) {
    return Row(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "쪽지가 왔습니다!",
              style: TextStyle(fontFamily: 'soojin', fontSize: 13),
            ),
            Text(
              latestMessage,
              style: TextStyle(fontFamily: 'soojin', fontSize: 13),
            ),
          ],
        ),
        SizedBox(
          height: 40,
        )
      ],
    );
  }
}

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

//알람- 쪽지 알람
Widget A_Message = Row(
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
      "쪽지가 왔습니다!",
      style: TextStyle(fontFamily: 'soojin', fontSize: 13),
    ),
    SizedBox(
      height: 30,
    )
  ],
);

List<Item> itemList = [
  Item(title: '오늘', contentList: []),
];


class alrampage extends StatefulWidget {
  const alrampage({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static void addToItemList(Widget widget) {
    itemList.add(Item(title: '', contentList: [widget]));
  }

  @override
  State<alrampage> createState() => _alrampageState();
}

class _alrampageState extends State<alrampage> {
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

// 언제 뭔 알람 온지
class Item {
  String title;
  List<Widget> contentList;

  Item({required this.title, required this.contentList});
}

//알람
class FirstScreen extends StatefulWidget {
  const FirstScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    alrampage();
    super.initState();
    print("알람 페이지 입장");
    fetchMyIDFromServer();
    fetchNotificationDataFromServer();
  }

  int Myid = 0;
  List<notification> notificationList = [];

  Future<void> fetchMyIDFromServer() async {
    try {
      final myid = await apiManager.GetMyId();

      print('나의 아이디는 ${Myid}');
      setState(() {
        Myid = myid!;
      });
    } catch (error) {
      print('Error getting intro list: $error');
    }
  }

// fetchNotificationDataFromServer 함수 내부에서 처리
  Future<void> fetchNotificationDataFromServer() async {
    try {
      fetchMyIDFromServer();
      print("지금은 누구의 아이디세연 ${Myid}");
      final data = await apiManager.getNotificationList();

      setState(() {
        notificationList = data!;
        print(notificationList);

        // 항목 초기화
        itemList.clear();

        // 오늘, 어제, 7일 전 항목 추가
        itemList.add(Item(title: '오늘', contentList: []));
        itemList.add(Item(title: '어제', contentList: []));
        itemList.add(Item(title: '7일 전', contentList: []));

        List<Widget> todayWidgets = [];
        List<Widget> yesterdayWidgets = [];
        List<Widget> sevenDaysAgoWidgets = [];

        // 알림을 날짜에 따라 분류하여 해당 항목의 리스트에 추가
        DateTime now = DateTime.now();
        for (final notification in notificationList) {
          // 알림을 받은 시간
          DateTime notificationTime = notification.sentTime;
          // 날짜에 따라 분류
          if (notificationTime.year == now.year &&
              notificationTime.month == now.month &&
              notificationTime.day == now.day) {
            // 오늘의 알림 위젯 생성
            late Widget todayWidget;
            // 알림 타입에 따라 적절한 위젯 생성
            switch (notification.title) {
              case "누군가가 당신의 일기에 좋아요를 눌렀습니다!":
                todayWidget = A_good;
                break;
              case "EMO:D가 이달의 감정 통지서를 보냈습니다!":
                todayWidget = A_Emod;
                break;
              case "누군가 댓글을 달았습니다":
                String body = notification.body;
                body = body.replaceAll(RegExp('보낸 시간 : .+'), '').trim();
                body = body.length > 6 ? body.substring(0, 6) + "..." : body;

                todayWidget = A_Chat(body);
                break;

              case "쪽지가 왔습니다!":
                String body = notification.body;
                body = body.replaceAll(RegExp('보낸 시간 : .+'), '').trim();
                body = body.length > 6 ? body.substring(0, 6) + "..." : body;

                todayWidget = A_Message(body);
                break;
              case "하루가 지나가요! 오늘을 공유해보세요":
                todayWidget = A_DEmod;
                break;
              default:
                continue;
            }
            todayWidgets.add(todayWidget);
          } else if (notificationTime.year == now.year &&
              notificationTime.month == now.month &&
              notificationTime.day == now.day - 1) {
            // 어제의 알림 위젯 생성
            late Widget yesterdayWidget;
            // 알림 타입에 따라 적절한 위젯 생성
            switch (notification.title) {
              case "누군가가 당신의 일기에 좋아요를 눌렀습니다!":
                yesterdayWidget = A_good;
                break;
              case "EMO:D가 이달의 감정 통지서를 보냈습니다!":
                yesterdayWidget = A_Emod;
                break;
              case "누군가 댓글을 달았습니다":
                String body = notification.body;
                body = body.replaceAll(RegExp('보낸 시간 : .+'), '').trim();
                body = body.length > 6 ? body.substring(0, 6) + "..." : body;

                yesterdayWidget = A_Chat(body); // 댓글 내용을 전달
                break;
              case "쪽지가 왔습니다!":
                String body = notification.body;
                body = body.replaceAll(RegExp('보낸 시간 : .+'), '').trim();
                body = body.length > 6 ? body.substring(0, 6) + "..." : body;

                yesterdayWidget = A_Message(body); // 댓글 내용을 전달
                break;
              case "하루가 지나가요! 오늘을 공유해보세요":
                yesterdayWidget = A_DEmod;
                break;
              default:
                continue;
            }
            yesterdayWidgets.add(yesterdayWidget);
          } else {
            // 7일 전의 알림 위젯 생성
            late Widget sevenDaysAgoWidget;
            // 알림 타입에 따라 적절한 위젯 생성
            switch (notification.title) {
              case "누군가가 당신의 일기에 좋아요를 눌렀습니다!":
                sevenDaysAgoWidget = A_good;
                break;
              case "EMO:D가 이달의 감정 통지서를 보냈습니다!":
                sevenDaysAgoWidget = A_Emod;
                break;
              case "누군가 댓글을 달았습니다":
                String body = notification.body;
                body = body.replaceAll(RegExp('보낸 시간 : .+'), '').trim();
                body = body.length > 6 ? body.substring(0, 6) + "..." : body;

                sevenDaysAgoWidget = A_Chat(body); // 댓글 내용을 전달
                break;
              case "쪽지가 왔습니다!":
                String body = notification.body;
                body = body.replaceAll(RegExp('보낸 시간 : .+'), '').trim();
                body = body.length > 6 ? body.substring(0, 6) + "..." : body;

                sevenDaysAgoWidget = A_Message(body); // 댓글 내용을 전달
                break;
              case "하루가 지나가요! 오늘을 공유해보세요":
                sevenDaysAgoWidget = A_DEmod;
                break;
              default:
                continue;
            }
            sevenDaysAgoWidgets.add(sevenDaysAgoWidget);
          }
        }
        // 각 항목의 알림 위젯들을 해당 항목의 contentList에 추가
        // 각 항목의 알림 위젯들을 해당 항목의 contentList에 추가
        itemList
            .firstWhere((item) => item.title == '오늘')
            .contentList
            .insertAll(0, todayWidgets.reversed.toList());
        itemList
            .firstWhere((item) => item.title == '어제')
            .contentList
            .insertAll(0, yesterdayWidgets.reversed.toList());
        itemList
            .firstWhere((item) => item.title == '7일 전')
            .contentList
            .insertAll(0, sevenDaysAgoWidgets.reversed.toList());
      });
    } catch (error) {
      print('Error getting MS list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

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
                height: 5,
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

////////////////////////

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

////////////////////////

// 메세지 파트
class SecondScreen extends StatefulWidget {
//  late final int otherUserId;
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  ApiManager apiManager = ApiManager().getApiManager();

  late String message_content = " ";
  late int sender_Id;
  late int receiver_Id;
  late DateTime sentAt;

  List<ChatRoom> chatRooms = [];

  @override
  void initState() {
    super.initState();
    print("message.dart입장 ");
    // 서버로부터 채팅방 목록 불러오기
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getChatList();
      setState(() {
        chatRooms = data! as List<ChatRoom>;
      });
    } catch (error) {
      // 에러 제어하는 부분
      print('Error getting chat list: $error');
    }
  }

/*  // 화면을 갱신하는 메서드
  void _updateScreen() {
    // setState()를 호출하여 상태를 변경하고 화면을 다시 그림
    setState(() {
      //myData = '갱신된 값';
    });
  }*/

  // 서버에서 가져온 가상의 채팅방 목록
  Future<void> GetMessage(String endpoint) async {
    try {
      final response = await apiManager.Get(endpoint); // 실제 API 엔드포인트로 대체

      // 요청 응답 받기
      final value = response['content']; // 키를 통해 value를 받아오기
      print('content: $value');
      message_content = value;
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
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: chatRooms.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MessageRoom(
                              otherUserId: (chatRooms[index].otherUserId),
                            )),
                  ).then((value) async {
                    await Future.delayed(Duration(
                        milliseconds: 500)); // 0.5초 대기 (500 milliseconds)
                    setState(() {
                      fetchDataFromServer();
                      chatRooms[index].isRead = true;
                      print("읽음 : ${chatRooms[index].isRead}");
                    });
                  });
                },
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 43,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => otherMypage(
                                userId: (chatRooms[index].otherUserId),
                              ),
                            ),
                          );
                        },
                        icon: Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Image.asset(
                            "images/send/cat_real_image.png",
                            fit: BoxFit.contain,
                          ),
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
                                "삼냥이",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text(
                                chatRooms[index].lastMessage,
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !chatRooms[index].isRead,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                          width: 20,
                          height: 20,
                          child: Icon(Icons.circle,
                              color: Colors.redAccent, size: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              height: 10,
              thickness: 1.0,
              color: Color(0xff7D5A50),
            ),
          ),
        ),
      ],
    );
  }
}
