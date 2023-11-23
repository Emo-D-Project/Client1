import 'package:capston1/network/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'models/Diary.dart';

class calendar extends StatefulWidget {
  calendar({Key? key}) : super(key: key);

  @override
  State<calendar> createState() => _calendarState();
}

class DiaryEntry {
  final DateTime date;
  // Add other fields as needed

  DiaryEntry({required this.date /* Add other parameters */});
}


class _calendarState extends State<calendar> {
  DateTime? selectedDay;
  DateTime _focusedDay = DateTime.now();

  ApiManager apiManager = ApiManager().getApiManager();

  Map<DateTime, String> _events = {
  };

  List<String> eventLoader(DateTime day) {
    // events 맵에서 해당 날짜에 대한 이벤트를 찾아 List로 반환합니다.
    return [_events[day] ?? '']; // 해당 날짜에 이벤트가 없으면 빈 문자열을 포함하는 리스트를 반환합니다.
  }

  // 일기 데이터를 불러와서 여기 저장한다. 이 데이터로 사용자의 일기를 보여줌
  List<Diary> _diaryEntries = [
  ];

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
      // Handle error
      print('Error fetching data: $error');
    }
  }

  /*Widget _buildEventIcon(List events) {
    return GestureDetector(
      onTap: () {
        // Add your logic for what happens when the event icon is tapped
        print('Event icon t-apped!');
        // You can navigate to a new screen, show a dialog, etc.
      },
      child: Container(
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.event,
            color: Colors.white,
            size: 12.0,
          ),
        ),
      ),
    );
  }*/


  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      body: Center(
        child: Container(
          width: 358,
          height: 530,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFFC5C4C4),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(4, 4),
              ),
            ],
            color: Color(0xFFD2C6BC),
            borderRadius: BorderRadius.all(Radius.circular(10)
            ),
          ),
          child: TableCalendar(
            rowHeight: 65,
            firstDay: DateTime.utc(2021),
            lastDay: DateTime.utc(2025),
            focusedDay: _focusedDay,
            daysOfWeekHeight: 40,
            //eventLoader: eventLoader,
            weekendDays: [DateTime.sunday],
            calendarBuilders: CalendarBuilders(

              // 사용자가 특별한 날 지정할 때 쓰는 뷸더
              prioritizedBuilder: (context, day, focusedDay) {
                // Check if the current day has events
                if (_events.containsKey(DateTime(day.year, day.month, day.day))) {
                  String image = "";

                  switch (_events[day]) {
                    case "angry":
                      image = 'images/emotion/angry.png';
                      break;
                    case "flutter":
                      image = 'images/emotion/2.gif';
                      break;
                    case "smile":
                      image = 'images/emotion/1.gif';
                      break;
                    case "annoying":
                      image = 'images/emotion/4.gif';
                      break;
                    case "sad":
                      image = 'images/emotion/6.gif';
                      break;
                    case "calmness":
                      image = 'images/emotion/7.gif';
                      break;
                    case "tired":
                      image = 'images/emotion/5.gif';
                      break;
                    default:
                      image = 'images/emotion/2.gif';
                      break;
                  }
                  // If there are events, highlight the cell with an image
                  return GestureDetector(
                    // 이벤트가 있는 날짜를 클릭 시 해당 일기 보여주는 부분
                    onTap: () {
                      // 선택한 날짜에 대한 일기 항목 가져오기
                      Diary diary = getDiaryForDate(DateTime(day.year, day.month, day.day));
                      // 선택한 날짜에 대한 일기 항목이 있는지 확인
                      if (diary != null) {
                        // 사용자에게 일기 내용 표시

                      }
                      // 이 컨테이너가 눌렸을 때 실행될 코드를 여기에 추가
                      // 예: 특정 날짜에 연결된 이벤트를 가져와서 처리
                      String event = _events[day] ?? '';
                      print('Event for $day: $event');
                    },
                    child: Center(
                      child: Image.asset(
                        image,
                        width: 40, // 이미지의 너비 조절
                        height: 40, // 이미지의 높이 조절
                      ),
                    ),
                  );
                } else{
                  return null;
                }

              },

              dowBuilder: (context, day) {
                switch (day.weekday) {
                  case 1:
                    return Center(
                      child: Text(
                        'M',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  case 2:
                    return Center(
                      child: Text(
                        'T',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  case 3:
                    return Center(
                      child: Text(
                        'W',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  case 4:
                    return Center(
                      child: Text(
                        'T',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  case 5:
                    return Center(
                      child: Text(
                        'F',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  case 6:
                    return Center(
                      child: Text(
                        'S',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  case 7:
                    return Center(
                      child: Text(
                        'S',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    );
                }
              },
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              rightChevronIcon: Icon(Icons.arrow_forward_ios_outlined,
                  color: Color(0xFF7D5A50)),
              leftChevronIcon: Icon(Icons.arrow_back_ios_new_outlined,
                  color: Color(0xFF7D5A50)),
              titleTextFormatter: (date, locale) =>
                  DateFormat.yMMM(locale).format(date).toUpperCase(),
              headerMargin: EdgeInsets.fromLTRB(50, 15, 50, 15),
              titleTextStyle: TextStyle(
                  color: Color(0xFF7C5A50),
                  fontWeight: FontWeight.w900,
                  fontSize: 25),
            ),
            calendarStyle: CalendarStyle(
              cellAlignment: Alignment.center,
              isTodayHighlighted: true,
              todayDecoration: BoxDecoration(color: Color(0xFFA67C7C), shape: BoxShape.circle),
              outsideDaysVisible: false,
              weekendTextStyle: const TextStyle(
                color: Colors.red,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              tableBorder: const TableBorder(
                horizontalInside: BorderSide(color: Colors.white),
              ),
              defaultTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Diary getDiaryForDate(DateTime date) {
    // 주어진 날짜의 연, 월, 일을 추출합니다
    int year = date.year;
    int month = date.month;
    int day = date.day;

    // 일치하는 날짜 구성 요소를 가진 일기 항목 찾기
    return _diaryEntries.firstWhere(
          (entry) =>
      entry.date.year == year &&
          entry.date.month == month &&
          entry.date.day == day,
      orElse: () => Diary( date: DateTime(year, month, day), content: '', emotion: ''), // 기본 값으로 빈 일기 생성
    );
  }
}
