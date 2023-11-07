import 'package:flutter/material.dart';
import 'statistics.dart';
import 'package:dotted_border/dotted_border.dart';

class fullStatistics extends StatefulWidget {
  const fullStatistics({super.key});

  @override
  State<fullStatistics> createState() => _fullStatisticsState();
}

class _fullStatisticsState extends State<fullStatistics> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "EMO:D",
          style: TextStyle(color: Color(0xFF968C83)),
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
        //.    padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                    width: 300,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.brown,
                                fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(text: '현재까지 쌓인 감정이에요 :D'),
                            ]))
                ),
              ],
            ),
          ),

          // 감정 통계
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                width: double.infinity,
                child: Column(
                  // 감정 그래프
                  children: [
                    DottedBorder(
                      borderType: BorderType.RRect,
                      color: Color(0xFF745A52),
                      strokeWidth: 2,
                      radius: Radius.circular(20),
                      dashPattern: [13, 13],
                      child: Container(
                        width: 380,
                        //padding: const EdgeInsets.all(8.0),
                        //margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          //color: Color(0xFFD2C6BC),
                          //borderRadius: BorderRadius.circular(15),

                        ),

                        //감정 그래프 (기둥같은거..)
                        child: Column(
                          children: [
                            Container(
                              width: 380,
                              height: 230,
                              color: Color(0xFFE1DED6),
                              margin: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                ],
                              ),
                            ),

                            //감정 이모션 사진
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/emotion/1.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/emotion/2.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),


                                   Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.fromLTRB(8, 0, 8, 7),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/emotion/3.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),


                              Container(
                                      width: 37,
                                      height: 37,
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/emotion/4.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),

                              Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/emotion/5.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),

                                 Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/emotion/6.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),


                                Container(
                                      width: 35,
                                      height: 35,
                                      padding: const EdgeInsets.all(8.0),
                                      margin: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage('images/emotion/7.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),

                                ),
                              //color: Color.fromRGBO(248, 245, 235, 100),
                                ],
                              ),
                            ), // 이 부분이 누락되어 있었습니다. 추가했습니다.
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),


                    // 작성된 일기 수
                    Container(
                        width: 380,
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFE1DED6),
                          borderRadius: BorderRadius.circular(
                              15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                //color: Colors.cyan,
                                width: 300,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.brown,
                                            fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(
                                            text: '2023.',
                                          ), //년도
                                          TextSpan(text: '7.'), //달
                                          TextSpan(text: '25 '), //일
                                          TextSpan(text: '부터 작성 된 일기 수 '),
                                        ]))),
                            Container(
                              //  color: Colors.pink,
                                width: 300,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.brown,
                                            fontWeight: FontWeight.w900),
                                        children: [
                                          TextSpan(text: '177'),
                                          TextSpan(text: '개'),
                                        ]))),
                          ],
                        )),

                    // 어느 시간대에 일기 가장 많이 쓴 지
                    Container(
                        width: 380,
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFDAD4CC),
                          borderRadius: BorderRadius.circular(
                              15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              //color: Colors.cyan,
                                width: 300,
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        children: [
                                          TextSpan(text: '수진',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.brown)), //닉네임
                                          TextSpan(text: ' 님은 ', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.brown)), //
                                          TextSpan(text: '밤(18~00) ',style: TextStyle(fontSize:25,fontWeight: FontWeight.w900,color: Colors.brown)), //시간
                                          TextSpan(text: '에',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.brown)),
                                        ]))),
                            Container(
                              //  color: Colors.pink,
                                width: 300,
                                height: 40,
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.brown,fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(text: '일기를 가장 많이 작성하였어요 :D'),
                                        ]))),
                          ],
                        )),

                    // 몇월에 일기 가장 많이 작성한지
                    Container(
                        width: 380,
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFDACFC4),
                          borderRadius: BorderRadius.circular(
                              15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // 위아래 중앙 정렬
                          children: [
                            Container(
                              //color: Colors.cyan,
                                width: 300,
                                height: 40,
                               padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(

                                        children: [
                                          TextSpan(text: '2023년 ',style: TextStyle(fontSize:25,fontWeight: FontWeight.w900,color: Colors.brown)),
                                          TextSpan(text: '9월 ',style: TextStyle(fontSize:25,fontWeight: FontWeight.w900,color: Colors.brown)),
                                          TextSpan(text: '에',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.brown)),
                                          TextSpan(text: ' 25개 ',style: TextStyle(fontSize:25,fontWeight: FontWeight.w900,color: Colors.brown)),
                                          TextSpan(text: '로',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18,color: Colors.brown)),
                                        ]))),
                            Container(
                              //  color: Colors.pink,
                                width: 300,
                                height: 40,
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(fontSize: 18, color: Colors.brown,fontWeight: FontWeight.w600),
                                        children: [
                                          TextSpan(text: '가장 많이 일기를 작성하였어요 :D'),
                                        ]))),
                          ],
                        )),

                    // 가장 많이 공감 받은 일기
                    Container(
                      width: 380,
                      height: 500,
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFD7D4CC),
                        borderRadius: BorderRadius.circular(
                            15),
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
