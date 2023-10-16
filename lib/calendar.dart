import 'package:flutter/material.dart';

class calendar extends StatefulWidget {
  calendar({Key? key}) : super(key: key);

  @override
  State<calendar> createState() => _calendarState();
}

class _calendarState extends State<calendar>{
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      body: Container(
        width: 380,
        height: 600,
        color: Color(0xFFB16409),
      ),
    );
  }
}
