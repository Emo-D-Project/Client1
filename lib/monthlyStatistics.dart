import 'package:flutter/material.dart';
import 'bar graph/bar_graph_month.dart';
import 'statistics.dart';
import 'package:dotted_border/dotted_border.dart';
import 'statistics.dart';
import 'package:capston1/pieGraph/pie_chart.dart';
import 'package:capston1/bar%20graph/bar_graph.dart';

class ListData {
  final String title;

  ListData(this.title);
}

class monthlyStatistics extends StatefulWidget {
  const monthlyStatistics({super.key});

  @override
  State<monthlyStatistics> createState() => _monthlyStatisticsState();
}

class _monthlyStatisticsState extends State<monthlyStatistics> {
  final List<ListData> datas = [
    ListData('2023년 10월의 감정 통지서'),
    ListData('2023년 09월의 감정 통지서'),
    ListData('2023년 08월의 감정 통지서'),
  ];
  List<double> emotioncount = [10, 5, 2, 8, 1, 0, 2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "EMO:D",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'kim',
            color: Color(0xFF968C83),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => statistics()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: datas.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10), bottom: Radius.circular(10)),
              color: Colors.white,
            ),
            child: ExpansionTile(
              title: Text(
                datas[index].title,
                style: TextStyle(
                  fontFamily: "soojin",
                  fontSize: 25,
                  color: Color(0xFF968C83),
                ),
              ),
              initiallyExpanded: false,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(5),
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                        margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        width: double.infinity,
                        child: Column(
                          children: [
                            //원형그래프 + 감정
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
                                  height: 250,
                                  child: Row(
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 0, 0)),
                                      SizedBox(
                                        width: 180,
                                        child: MyPieChart(),
                                      ),
                                      Column(
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  130, 7, 0, 0)),
                                          Container(
                                            height: 120,
                                            width: 130,
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: [
                                                Text(
                                                  '가장 많았던 감정',
                                                  style: TextStyle(
                                                      fontFamily: 'soojin',
                                                      fontSize: 16),
                                                ),
                                                Image.asset(
                                                  'images/emotion/2.gif',
                                                  width: 90,
                                                  height: 90,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 120,
                                            width: 130,
                                            alignment: Alignment.center,
                                            child: Column(
                                              children: [
                                                Text(
                                                  '가장 많았던 감정',
                                                  style: TextStyle(
                                                      fontFamily: 'soojin',
                                                      fontSize: 16),
                                                ),
                                                Image.asset(
                                                  'images/emotion/5.gif',
                                                  width: 90,
                                                  height: 90,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            // 막대그래프
                            Center(
                              child: Container(
                                width: 380,
                                height: 210,
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFE1DED6),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 150,
                                      child: MyBarGraph_M(
                                        emotioncount: emotioncount,
                                      ),
                                    ),

                                    //감정 이모션 사진
                                    Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: 28,
                                            height: 28,
                                            margin: const EdgeInsets.all(6.5),
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
                                            width: 28,
                                            height: 28,
                                            margin: const EdgeInsets.all(6.5),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'images/emotion/2.gif'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 28,
                                            height: 28,
                                            margin: const EdgeInsets.fromLTRB(
                                                8, 0, 8, 7),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'images/emotion/3.gif'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 28,
                                            height: 28,
                                            margin: const EdgeInsets.all(6.5),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'images/emotion/4.gif'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 28,
                                            height: 28,
                                            margin: const EdgeInsets.all(6.5),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'images/emotion/5.gif'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 28,
                                            height: 28,
                                            margin: const EdgeInsets.all(6.5),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'images/emotion/6.gif'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 28,
                                            height: 28,
                                            margin: const EdgeInsets.all(6.5),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    'images/emotion/7.gif'),
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

                            // emod의 한마디
                            Container(
                                width: 380,
                                height: 600,
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 8, 0, 0),
                                        child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: '"EMO:D의 한마디"\n\n',
                                                  style: TextStyle(
                                                      fontFamily: 'soojin',
                                                      fontSize: 30,
                                                      color: Colors.brown)),
                                              TextSpan(
                                                  text:
                                                      '한 달 동안 어려운 순간들이 많았겠죠.'
                                                      '\n\n'
                                                      '그럴 때마다 어떤 상황에서도 당신의\n'
                                                      '강인함과 인내심을 발견할 수 있었을 거에요.\n'
                                                      '또한, 어떤 어려움이든 극복할 능력을\n'
                                                      '갖고 있다는 것을 기억해주세요.\n'
                                                      '\n'
                                                      '더 나은 날들이 올 거라 믿어요.\n',
                                                  style: TextStyle(
                                                      fontFamily: 'soojin',
                                                      fontSize: 16,
                                                      color: Colors.brown)),
                                            ]))),
                                    Container(
                                      color: Colors.black26,
                                      width: 250,
                                      height: 1,
                                    ),
                                    Container(
                                      width: 300,
                                      padding:
                                          EdgeInsets.fromLTRB(0, 15, 0, 0),
                                      child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text:
                                                    '혼자서 감정을 다스리기 어려울 수 있어요.\n'
                                                    '상담사와 이야기를 나눠보는 건 어떨까요?\n'
                                                    '\n'
                                                    '당신의 이야기를 듣고 함께 해결책을\n'
                                                    '찾아갈 수 있도록 최선을 다해 도와줄게요.\n',
                                                style: TextStyle(
                                                    fontFamily: 'soojin',
                                                    fontSize: 16,
                                                    color: Colors.brown)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        color: Color(0xFF745A52),
                                        strokeWidth: 2,
                                        radius: Radius.circular(20),
                                        dashPattern: [13, 13],
                                        child: SizedBox(
                                          width: 380,
                                          height: 150,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                  'images/main/free-icon-communication-3820107.png',
                                                  width: 40,
                                                  height: 40, color: Colors.brown),
                                              Column(
                                                children: [
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 5, 0, 0)),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 200,
                                                    height: 70,
                                                    child: (Text('정신건강 위기 상담전화\n(1577-0199)',style: TextStyle(fontSize: 16, fontFamily: 'soojin', color: Colors.brown),)),
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 200,
                                                    height: 70,
                                                    child: (Text('자살 상담전화(1393)',style: TextStyle(fontSize: 16, fontFamily: 'soojin', color: Colors.brown),)),

                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),

                            // 나의 n월은
                            Container(
                                width: 380,
                                height: 200,
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
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: '나의 10월은',  //n월로 변경해야함
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontFamily: 'soojin',
                                                      color: Colors.brown)),
                                            ]))),
                                    Container(
                                        color: Colors.black26,
                                        width: 250,
                                        height: 1,
                                    ),
                                    Padding(padding: EdgeInsets.fromLTRB(15, 10, 0, 0)),
                                    Container(
                                      width: 250,
                                        child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: '너무 힘들고 지쳤던 한달이었다.\n'
                                                      '다음 달에는 내가 행복할 수 있도록 노력해야겠다.\n'
                                                      '화이팅!!',  //n월로 변경해야함
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: 'soojin',
                                                      color: Colors.brown)),
                                            ]))
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(
          height: 10,
          color: Colors.white,
        ),
      ),
    );
  }
}
