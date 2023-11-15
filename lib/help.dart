import 'category.dart';
import 'package:flutter/material.dart';

class help extends StatelessWidget {
  const help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "자주 하는 질문",
          style: TextStyle(
              color: Color(0xFF968C83), fontFamily: 'kim', fontSize: 30
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => category()));
          },
          icon: Icon(Icons.arrow_back_ios,color: Color(0xFF968C83),),
        ),
      ),
      body: Center(
          child: Text('자주 하는 질문', style: TextStyle(fontFamily: 'soojin', fontSize: 40, color: Colors.brown),)
      ),
    );
  }
}