import 'package:flutter/material.dart';
import 'statistics.dart';

class gatherEmotion extends StatefulWidget {
  const gatherEmotion({super.key});

  @override
  State<gatherEmotion> createState() => _gatherEmotionState();
}

class _gatherEmotionState extends State<gatherEmotion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("EMO:D",style: TextStyle(color: Color(0xFF968C83)),),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => statistics()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Text("감정별로 모아보기-예원"),
    );
  }
}
