import 'package:flutter/material.dart';
import 'network/api_manager.dart';
import 'statistics.dart';
import 'package:intl/intl.dart';

class gatherEmotion extends StatefulWidget {
  const gatherEmotion({super.key});

  @override
  State<gatherEmotion> createState() => _gatherEmotionState();
}

class _gatherEmotionState extends State<gatherEmotion> {
  ApiManager apiManager = ApiManager().getApiManager();

  Map<DateTime, String> _events =
      {}; // map.getkey를 해서 10월에 맞는 날짜를 추출해서 리스트로 만들고 쓰기

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getCalendarData();

      setState(() {
        _events = data!;
      });
    } catch (error) {
      print('Error fetching data: ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, String> sortedMap = Map.fromEntries(
        _events.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    List<DateTime> dateList = sortedMap.keys.toList();
    List<String> valueList = sortedMap.values.toList();

    List<DateTime> yearMonthList = [];
    _events.forEach((key, value) {
      bool isCheck = false;

      yearMonthList.forEach((element) {
        if (element.year == key.year && element.month == key.month) {
          isCheck = true;
        }
      });
      // 겹치는 값이 없으면
      if (isCheck == false) {
        yearMonthList.add(key);
      }
    });

    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "EMO:D",
          style: TextStyle(
              color: Color(0xFF968C83), fontFamily: 'kim', fontSize: 30),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => statistics()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.builder(
          itemCount: yearMonthList.length,
          itemBuilder: (BuildContext context, int index) {
            DateTime currentMonth = yearMonthList[index];
            List<DateTime> monthDates = dateList
                .where((date) =>
                    date.year == currentMonth.year &&
                    date.month == currentMonth.month)
                .toList();
            return Container(
              margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('yyyy.MM').format(currentMonth),
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'soojin',
                      color: Colors.brown,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: monthDates.length,
                      itemBuilder: (BuildContext context, int subIndex) {
                        DateTime currentDate = monthDates[subIndex];
                        int dateIndex = dateList.indexOf(currentDate);
                        return Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Column(
                            children: [
                              Container(
                                child: (() {
                                  String emotion = valueList[dateIndex];
                                  switch (emotion) {
                                    case "smile":
                                      return Image.asset(
                                        'images/emotion/smile.gif',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "flutter":
                                      return Image.asset(
                                        'images/emotion/flutter.gif',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "angry":
                                      return Image.asset(
                                        'images/emotion/angry.png',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "annoying":
                                      return Image.asset(
                                        'images/emotion/annoying.gif',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "tired":
                                      return Image.asset(
                                        'images/emotion/tired.gif',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "sad":
                                      return Image.asset(
                                        'images/emotion/sad.gif',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "calmness":
                                      return Image.asset(
                                        'images/emotion/calmness.gif',
                                        width: 40,
                                        height: 40,
                                      );
                                  }
                                })(),
                              ),
                              Text(
                                '${currentDate.month}${currentDate.day}',
                                style: TextStyle(
                                    fontFamily: 'soojin',
                                    fontSize: 15,
                                    color: Colors.brown),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
