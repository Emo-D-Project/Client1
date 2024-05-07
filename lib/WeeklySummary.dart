import 'package:flutter/material.dart';

import 'models/Weekly.dart';
import 'network/api_manager.dart';

class weeklySummary extends StatefulWidget {
  const weeklySummary({super.key});

  @override
  State<weeklySummary> createState() => _weeklySummaryState();
}

class _weeklySummaryState extends State<weeklySummary> {
  ApiManager apiManager = ApiManager().getApiManager();

  Weekly? weekly;

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getWeeklySummary();
      setState(() {
        weekly = data;
      });
    } catch (error) {
      // 에러 제어하는 부분
      print('Error getting chat list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF8F5EB),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          color: Color(0xFFF8F5EB),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: sizeX * 0.9,
                child: Text(
                  "이번주 요약",
                  style: TextStyle(
                      color: Color(0xFF7D5A50),
                      fontSize: 24,
                      fontFamily: 'kim',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: sizeX * 0.42,
                    height: sizeY * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(3, 13, 50, 20),
                          child: Text(
                            "가장 좋았던 일",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'kim',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(
                            weekly?.positiveEvent ?? ' ',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'kim',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: sizeX * 0.42,
                    height: sizeY * 0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(3, 13, 50, 20),
                          child: Text(
                            "가장 나빴던 일",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'kim',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Text(
                            weekly?.negativeEvent ?? ' ',
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'kim',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                width: sizeX * 0.9,
                height: sizeY * 0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(3, 13, 250, 20),
                      child: Text(
                        "이번주의 감정",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'kim',
                        ),
                      ),
                    ),
                    SizedBox(
                      width: sizeX * 0.3,
                      height: sizeY * 0.12,
                      child: (() {
                        switch (weekly?.emotion) {
                          case 'smile':
                            return Image.asset(
                              'images/emotion/smile.gif',
                              height: 45,
                              width: 45,
                            );
                          case 'flutter':
                            return Image.asset(
                              'images/emotion/flutter.gif',
                              height: 45,
                              width: 45,
                            );
                          case 'angry':
                            return Image.asset(
                              'images/emotion/angry.png',
                              height: 45,
                              width: 45,
                            );
                          case 'annoying':
                            return Image.asset(
                              'images/emotion/annoying.gif',
                              height: 45,
                              width: 45,
                            );
                          case 'tired':
                            return Image.asset(
                              'images/emotion/tired.gif',
                              height: 45,
                              width: 45,
                            );
                          case 'sad':
                            return Image.asset(
                              'images/emotion/sad.gif',
                              height: 45,
                              width: 45,
                            );
                          case 'calmness':
                            return Image.asset(
                              'images/emotion/calmness.gif',
                              height: 45,
                              width: 45,
                            );
                        }
                      })(),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                width: sizeX * 0.9,
                child: Text(
                  "요일별 요약",
                  style: TextStyle(
                      color: Color(0xFF7D5A50),
                      fontSize: 20,
                      fontFamily: 'kim',
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                width: sizeX * 0.9,
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: sizeX * 0.2,
                            child: Text("MON",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'kim',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: sizeX * 0.6,
                            child: Text(
                              weekly!.summary?[0] ?? ' ',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'kim',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: sizeX * 0.2,
                            child: Text("TUE",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'kim',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: sizeX * 0.6,
                            child: Text(
                              weekly!.summary?[1] ?? ' ',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'kim',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: sizeX * 0.2,
                            child: Text("WED",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'kim',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: sizeX * 0.6,
                            child: Text(
                              weekly!.summary?[2] ?? ' ',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'kim',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: sizeX * 0.2,
                            child: Text("THR",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'kim',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: sizeX * 0.6,
                            child: Text(
                              weekly!.summary?[3] ?? ' ',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'kim',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: sizeX * 0.2,
                            child: Text("FRI",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'kim',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: sizeX * 0.6,
                            child: Text(
                              weekly!.summary?[4] ?? ' ',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'kim',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: sizeX * 0.2,
                            child: Text("SAT",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'kim',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: sizeX * 0.6,
                            child: Text(
                              weekly!.summary?[5] ?? ' ',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'kim',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: sizeX * 0.2,
                            child: Text("SUN",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'kim',
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            width: sizeX * 0.6,
                            child: Text(
                              weekly!.summary?[6] ?? ' ',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'kim',
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
