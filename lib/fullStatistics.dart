import 'package:capston1/bar%20graph/bar_graph.dart';
import 'package:flutter/material.dart';
import 'statistics.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:math';
import 'package:intl/intl.dart';

final String start = DateTime.now().toString();
String formattedDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());

class fullStatistics extends StatefulWidget {
  const fullStatistics({super.key});

  @override
  State<fullStatistics> createState() => _fullStatisticsState();
}

class _fullStatisticsState extends State<fullStatistics> {
  List<double> emotioncount = [200, 190, 150, 80, 50, 40, 5];

  //사진
  String smile = 'images/emotion/1.gif';
  String flutter = 'images/emotion/2.gif';
  String angry = 'images/emotion/angry.png';
  String annoying = 'images/emotion/4.gif';
  String tired = 'images/emotion/5.gif';
  String sad = 'images/emotion/6.gif';
  String calmness = 'images/emotion/7.gif';

//enum으로 바꿔보기
  int num_comment = 25; // 공유된 일기 중 가장 많은 댓글 수
  int num_like = 3; // 공유된 일기 중 가장 많은 좋아요 수
  String name = '수진'; //닉네임

  // 가장 많이 일기를 작성한  시간대
  String Dawn = '새벽(00~06)';
  String morning = '아침(06~12)';
  String Am = '오전(12~18)';
  String Pm = '밤(18~00)';

  // 이때까지 몇개의 일기를 작성한지
  int count = 0; // 맨 처음 시작한 일기는 0으로 시작

  void writeDiary() {
    setState(() {
      count++; // 다음 일기를 작성하면 1 증가
    });
  }

  // 몇월 - 몇개로 가장 많은 일기 수
  int w_diary = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "EMO:D",
          style: TextStyle(fontSize: 30, fontFamily: 'kim',color: Color(0xFF968C83),),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => statistics()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                    width: 300,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'soojin',
                                fontSize: 19,
                                color: Colors.brown,
                                fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(text: '현재까지 쌓인 감정이에요 :D'),
                            ]
                        )
                    )
                ),
              ],
            ),
          ),
          // 감정 통계
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: Color(0xFF745A52),
                        strokeWidth: 2,
                        radius: Radius.circular(20),
                        dashPattern: [13, 13],
                        child: SizedBox(
                          width: 400,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 250,
                                child: MyBarGraph(
                                  emotioncount: emotioncount,
                                ),
                              ),
                              //감정 이모션 사진
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.3),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/1.gif',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/2.gif'
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/angry.png'
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/4.gif'
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/5.gif'
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/6.gif'
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/7.gif'
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // 작성된 일기 수
                    Container(
                        width: 380,
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFE1DED6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 300,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontFamily: 'soojin',
                                            fontSize: 18,
                                            color: Colors.brown,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '2023.7.25',
                                          ), //년도
                                          TextSpan(text: '부터 작성 된 일기 수 '),
                                        ]
                                    )
                                )
                            ),
                            Container(
                                width: 300,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontFamily: 'soojin',
                                            fontSize: 25,
                                            color: Colors.brown,
                                        ),
                                        children: [
                                          TextSpan(text: '$count'),
                                          TextSpan(text: '개'),
                                        ]
                                    )
                                )
                            ),
                          ],
                        )
                    ),
                    // 어느 시간대에 일기 가장 많이 쓴 지
                    Container(
                        width: 380,
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFDAD4CC),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 300,
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: name,
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.brown
                                          )
                                      ), //닉네임
                                      TextSpan(
                                          text: ' 님은 ',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.brown
                                          )
                                      ), //
                                      TextSpan(
                                          text: Pm,
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.brown
                                          )
                                      ), //시간
                                      TextSpan(
                                          text: '에',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color: Colors.brown
                                          )
                                      ),
                                    ]
                                    )
                                )
                            ),
                            Container(
                                width: 300,
                                height: 40,
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontFamily: 'soojin',
                                            fontSize: 18,
                                            color: Colors.brown,
                                          ),
                                        children: [
                                          TextSpan(text: '일기를 가장 많이 작성하였어요 :D'),
                                        ]
                                    )
                                )
                            ),
                          ],
                        )
                    ),
                    // 몇월에 일기 가장 많이 작성한지
                    Container(
                        width: 380,
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFDACFC4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // 위아래 중앙 정렬
                          children: [
                            Container(
                                width: 300,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: '2023년 9월',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 25,
                                              color: Colors.brown
                                          )
                                      ),
                                      TextSpan(
                                          text: '에 ',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 18,
                                              color: Colors.brown
                                          )
                                      ),
                                      TextSpan(
                                          text: '$w_diary',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 25,
                                              color: Colors.brown
                                          )
                                      ),
                                      TextSpan(
                                          text: '로',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 18,
                                              color: Colors.brown
                                          )
                                      ),
                                    ]
                                    )
                                )
                            ),
                            Container(
                                width: 300,
                                height: 40,
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontFamily: 'soojin',
                                            fontSize: 18,
                                            color: Colors.brown,
                                        ),
                                        children: [
                                          TextSpan(text: '가장 많이 일기를 작성하였어요 :D'),
                                        ]
                                    )
                                )
                            ),
                          ],
                        )
                    ),
                    // 가장 많이 공감 받은 일기
                    Container(
                      width: 380,
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFD7D4CC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          // ~ 님의 공유된 일기 중 가장 많은 공감을 얻은 일기에요~
                          Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                    width: 300,
                                    height: 40,
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            style: TextStyle(
                                                fontFamily: 'soojin',
                                                fontSize: 18,
                                                color: Colors.white,
                                            ),
                                            children: [
                                              TextSpan(text: name), //닉네임
                                              TextSpan(text: '님의 공유된 일기 중'), //일
                                            ]
                                        )
                                    )
                                ),
                                Container(
                                    width: 300,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            style: TextStyle(
                                                fontFamily: 'soojin',
                                                fontSize: 18,
                                                color: Colors.white,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: '가장 많은 공감을 얻은 일기에요 :D'),
                                            ]
                                        )
                                    )
                                )
                              ],
                            ),
                          ),
                          // 가장 공감 많이 받은 일기 보여줌
                          Container(
                            width: 380,
                            padding: const EdgeInsets.all(8.0),
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 380,
                                  color: Colors.white54,
                                  child: Column(
                                    children: [
                                      Container(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 10, 0, 10),
                                        child: Text(
                                          formattedDate,
                                          style: TextStyle(
                                            color: Color(0xFF7D5A50),
                                            fontSize: 17,
                                            fontFamily: 'soojin',
                                          ),
                                        ), //날짜
                                      ),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image:
                                                AssetImage(calmness),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                SingleChildScrollView(
                                  child: Container(
                                    width: 200,
                                    height: 150, // 이미지 높이 조절
                                    child: PageView(
                                      scrollDirection: Axis.horizontal,
                                      children: <Widget>[
                                        Container(
                                          child: Center(
                                              child: Image.asset(
                                                  'images/send/sj3.jpg'
                                              )
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                              child: Image.asset(
                                                  'images/send/sj1.jpg'
                                              )
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                              child: Image.asset(
                                                  'images/send/sj2.jpg'
                                              )
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // 텍스트 컨테이너
                                Container(
                                    width: 380,
                                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                                    color: Colors.white54,
                                    child: Column(
                                      children: [
                                        Text(
                                          '오늘 하루 아주 만족스러운 날이다. '
                                          '친구들이랑 맛있게 밥도 먹고'
                                          ' 하늘도 너무 이뻤다!',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'soojin'
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                          // ~개의 공감과 ~개의 댓글을 받았어요
                          Container(
                              width: 300,
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontFamily: 'soojin',
                                          fontSize: 18,
                                          color: Colors.white,
                                      ),
                                      children: [
                                        TextSpan(text: '$num_comment'), //댓글
                                        TextSpan(text: '개의 공감과 '), //일
                                        TextSpan(text: '$num_like'), //댓글
                                        TextSpan(text: '개의 댓글을 받았어요'), //일
                                      ]
                                  )
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
