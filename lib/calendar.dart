import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

enum Emotion{
  Angry, Flutter
}
class calendar extends StatefulWidget {
  calendar({Key? key}) : super(key: key);

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar> {
  DateTime? selectedDay;
  DateTime _focusedDay = DateTime.now();

  Map<DateTime,dynamic> eventSource = {
    DateTime(2023,11,3) : Emotion.Angry,
    DateTime(2023,11,5) : Emotion.Angry,
    };

  CalendarFormat _calendarFormat = CalendarFormat.month;

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
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: TableCalendar(
            rowHeight: 65,
            firstDay: DateTime.utc(2021),
            lastDay: DateTime.utc(2025),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            daysOfWeekHeight: 40,
            weekendDays: [DateTime.sunday],
            holidayPredicate: (day){
              return day.weekday >= 6;
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, _calendarState){
                // 특정 날짜 캐릭터 아이콘 넣어주기
                if(day.hashCode == DateTime(2023,11,3).hashCode){ // 데이트 타임 대신 Diary.DateTime
                  print("dateTimeCorrect");
                  String image;
                  switch(Emotion){
                    case Emotion.Angry:
                      image = 'images/emotion/3.gif'; // 앵그리 이거 아님 바꿔야됨
                      break;
                    case Emotion.Flutter:
                      image = 'images/emotion/2.gif';
                      break;
                  }
                  return IconButton(
                      iconSize: 40,
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context)=>writediary(emotion: 'smile',)
                        //     )
                        // );
                      }, icon: Image.asset('images/emotion/1.gif',width: 50,height: 50,));
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

              holidayDecoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/emotion/1.gif'))
              ),


              holidayTextStyle: TextStyle(color: Colors.transparent),
        ),
      ),
    ),
      ),
    );
  }
}
