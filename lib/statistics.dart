import 'package:capston1/main.dart';
import 'package:flutter/material.dart';
import 'fullStatistics.dart';
import 'monthlyStatistics.dart';
import 'gatherEmotion.dart';

class statistics extends StatelessWidget {
  const statistics({super.key});

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
              color: Color(0xFF968C83), fontFamily: 'kim', fontSize: 30
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
          icon: Icon(Icons.arrow_back_ios,color: Color(0xFF968C83),),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 100, 70),
              child: Column(
                children: [
                  Ink(
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      color: Colors.white,
                    ),
                    child: IconButton(
                        iconSize: 60,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => monthlyStatistics()));
                        },
                        icon: Image.asset(
                          'images/emotion/footprint.png',
                        )
                    ),
                  ),
                  Text("이달의 감정")
                ],
              ),
            ), //감정통지서(달별)
            Container(
                margin: EdgeInsets.fromLTRB(100, 0, 0, 0),
                child: Column(
                  children: [
                    Ink(
                      decoration: const ShapeDecoration(
                        shape: CircleBorder(),
                        color: Colors.white,
                      ),
                      child: IconButton(
                          iconSize: 60,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => gatherEmotion()));
                          },
                          icon: Image.asset(
                            'images/emotion/footprint.png',
                          )
                      ),
                    ),
                    Text("감정 모아보기")
                  ],
                )
            ), //감정별 모아보기
            Container(
              margin: EdgeInsets.fromLTRB(0, 70, 100, 40),
              child: Column(
                children: [
                  Ink(
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(),
                      color: Colors.white,
                    ),
                    child: IconButton(
                        iconSize: 60,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => fullStatistics()
                              )
                          );
                        },
                        icon: Image.asset(
                          'images/emotion/footprint.png',
                        )
                    ),
                  ),
                  Text("감정 누적")
                ],
              ),
            ), //전체 감정 통계(누적)
          ],
        ),
      ),
    );
  }
}