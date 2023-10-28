
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';





class calendar extends StatefulWidget {
  calendar({Key? key}) : super(key: key);

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar>{

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
<<<<<<< Updated upstream


      body: Center(
        child: Container(
          width: 358,
          height: 462,
          decoration: BoxDecoration(
            color: Color(0x4D968C83),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: TableCalendar(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2021),
            lastDay: DateTime.utc(2025),
            focusedDay: DateTime.now(),
          ),
        ),

=======
      body: Container(
        width: 380,
        height: 600,
        color: Color(0xFF7DA5),
>>>>>>> Stashed changes
      ),
    );
  }
}
