import 'package:capston1/main.dart';
import 'package:flutter/material.dart';

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

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        children: [
          Expanded(child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              color: Colors.pink,
              child: Column(
                children: [
                  Container(
                    color: Colors.yellow,
                    width: 300,
                    height: 300,
                  ),
                  Container(
                    color: Colors.black,
                    width: 300,
                    height: 300,
                  )
                ],
              ),

            ),

          )),
          Container(
            width: double.infinity,
            height: 50,
            color: Colors.orange,
          ),
        ],

      ),

    );
  }
}

class SecondScreen extends StatelessWidget {

  final name = '삼냥이';
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      //댓글 1
                      Container(
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
                                      '난 오늘 너무 힘든 하루였어..',
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
                      SizedBox(
                        height: 10,
                      ),

                      //댓글 2
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              padding:
                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Image.asset(
                                'images/emotion/6.gif',
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
                                    width: 150,
                                    padding:
                                    EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Text(
                                      '우와 나 라멘 진짜 좋아하는데!! 저기 맛있겠다 저기는 어디야?'
                                          '하.. 갑자기 또 라멘 먹고싶네'
                                          ,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //댓글 3
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              padding:
                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Image.asset(
                                'images/emotion/7.gif',
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
                                    padding:
                                    EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Text(
                                      '난 오늘 일한다고 하늘을 한번도 못봤어ㅜ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //댓글 4
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              padding:
                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Image.asset(
                                'images/emotion/2.gif',
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
                                    padding:
                                    EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Text(
                                      '하늘 정말 이쁘다 그리고 너 사진 잘 찍는당'
                                          '. 휴대폰 기종이 뭐야? '
                                          '쪽지 보낼게!!',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //댓글 5
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              padding:
                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Image.asset(
                                'images/emotion/2.gif',
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
                                    padding:
                                    EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Text(
                                      '아 배고파 ..',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //댓글 6
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              padding:
                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Image.asset(
                                'images/emotion/4.gif',
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
                                    padding:
                                    EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Text(
                                      '나도 한식 잘 먹는데',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //댓글 7
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              padding:
                              EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Image.asset(
                                'images/emotion/3.gif',
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
                                    padding:
                                    EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Text(
                                      '나랑 같은 곳이였나보네 ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),


      ],



    );
  }
}
