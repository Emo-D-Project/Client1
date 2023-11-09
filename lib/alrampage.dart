import 'package:capston1/main.dart';
import 'package:capston1/writediary.dart';
import 'package:flutter/material.dart';

//알람 좋아요 텍스트 형태
Widget A_good= Row(
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
 //   SizedBox(height: 25,)
  ],
);


//알람 - 이모디 새소식
Widget A_Emod = Row(
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
          style: TextStyle(fontFamily: 'soojin', fontSize: 13,),
        ),

        Text(
          "9월의 감정 통지서가 도착했어요 !",
          style: TextStyle(fontFamily: 'soojin', fontSize: 13),
        ),
      ],
    ),
    SizedBox(height: 45,)
  ],
);


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
    SizedBox(height: 10,)
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
          style: TextStyle(fontFamily: 'soojin', fontSize: 13,),
        ),
        Text(
          "남겨주신 문의에 답변이 등록 되었어요.\nEMO:D : '문의 주셔서 감사합...'",
          style: TextStyle(fontFamily: 'soojin', fontSize: 13),
        ),
      ],
    ),
    SizedBox(height: 10,)
  ],
);


//알람- 쪽지 알람
Widget A_Message = Row(
  children: [
    Column(
      children: [
        Container(
          child: Image.asset(
            'images/send/real_send.png',
            width: 20,
          ),
        ),
      ],
    ),
    SizedBox(width: 5),
    Text(
      "쪽지가 왔습니다!",
      style: TextStyle(fontFamily: 'soojin', fontSize: 13),
    ),
    SizedBox(height: 30,)
  ],
);



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
            title: Text(""),
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

//알람
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;

    List<Item> itemList = [
      Item(title: '오늘', contentList: [A_good, A_Emod,A_Question]),
      Item(title: '어제', contentList: [A_Chat, A_Message]),
      Item(title: '5일전', contentList: [A_Question, A_good,A_good]),
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
                      SizedBox(height: 5,),
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
                      SizedBox(height: 5,),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6,),
                            Column(
                              children: item.contentList,
                            ),
                            SizedBox(height: 6,),
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

class Item {
  String title;
  List<Widget> contentList;

  Item({required this.title, required this.contentList});
}

// 메세지 파트
class SecondScreen extends StatelessWidget {
  final name = '삼냥이';
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: 7,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: sizeX * 0.9,
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        padding:
                        EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Image.asset(
                          'images/emotion/5.gif',
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                              EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text(
                                name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.brown),
                              ),
                            ),
                            Container(
                              width: 100,
                              padding:
                              EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text(
                                '쪽지 내용',
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 13),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
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