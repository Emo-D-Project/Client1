import 'package:flutter/material.dart';
import 'diaryReplay.dart';
import 'models/Diary.dart';
import 'network/api_manager.dart';
import 'statistics.dart';
import 'package:intl/intl.dart';


class gatherEmotion extends StatefulWidget {
  const gatherEmotion({super.key});

  @override
  State<gatherEmotion> createState() => _gatherEmotionState();
}

class DiaryEntry {
  final DateTime date;
  DiaryEntry({required this.date});
}


class _gatherEmotionState extends State<gatherEmotion> {
  ApiManager apiManager = ApiManager().getApiManager();

  Map<DateTime, String> _events =
      {}; // map.getkey를 해서 10월에 맞는 날짜를 추출해서 리스트로 만들고 쓰기

  List<Diary> _diaryEntries = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }


  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getCalendarData();
      final diary_data = await apiManager.getDiaryData();

      setState(() {
        _events = data!;
        _diaryEntries = diary_data!;
      });
    } catch (error) {
      print('Error fetching data: ${error.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<DateTime, String> sortedMap = Map.fromEntries(
        _events.entries.toList()..sort((e1, e2) => e2.key.compareTo(e1.key)));

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

    List<DateTime> reversedYearMonthList = yearMonthList.reversed.toList();

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
            DateTime currentMonth = reversedYearMonthList[index];
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
                              GestureDetector(
                                onTap: () {
                                  Diary? diary;
                                  for(Diary d in _diaryEntries){
                                    if(d.date.year == currentDate.year && d.date.month == currentDate.month && d.date.day == currentDate.day){
                                      diary = d;
                                      print("매칭되는 다이어리 발견");
                                    }
                                  }
                                  // 선택한 날짜에 대한 일기 항목이 있는지 확인
                                  if (diary != null) {
                                    // 사용자에게 일기 내용 표시
                                    print("매칭되는 다이어리의 id ${diary.diaryId}");
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DiaryReplay(
                                              diary: diary!,
                                            )));
                                  }
                                  // 이 컨테이너가 눌렸을 때 실행될 코드를 여기에 추가
                                  // 예: 특정 날짜에 연결된 이벤트를 가져와서 처리
                                  String event = _events[currentDate] ?? '';
                                  print('Event for $currentDate: $event');
                                },
                                child: (() {
                                  String emotion = valueList[dateIndex];
                                  switch (emotion) {
                                    case "smile":
                                      return Image.asset(
                                        'images/bung/01.png',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "flutter":
                                      return Image.asset(
                                        'images/bung/02.png',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "angry":
                                      return Image.asset(
                                        'images/bung/03.png',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "annoying":
                                      return Image.asset(
                                        'images/bung/04.png',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "tired":
                                      return Image.asset(
                                        'images/bung/05.png',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "sad":
                                      return Image.asset(
                                        'images/bung/06.png',
                                        width: 40,
                                        height: 40,
                                      );
                                    case "calmness":
                                      return Image.asset(
                                        'images/bung/07.png',
                                        width: 40,
                                        height: 40,
                                      );
                                  }

                                  Diary diary;
                                  _diaryEntries.forEach((element) {
                                    if (element.date.day == currentDate.day &&
                                        element.date.month == currentDate.month &&
                                        element.date.year == currentDate.year) {
                                      diary = element;
                                    }
                                  });
                                })(),
                              ),

                              Text(
                                '${currentDate.month}/${currentDate.day}',
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
