import 'package:capston1/diaryReplay.dart';
import 'package:flutter/material.dart';
import 'statistics.dart';
import 'package:intl/intl.dart';

List<DateTime> title = [DateTime(2023, 10)];

List<String> content = ["1011","1025","1031","1025","1025","1025","1025","1025","1025"];

List<String> emo = [
  'images/emotion/1.gif',
  'images/emotion/2.gif',
  'images/emotion/1.gif',
  'images/emotion/2.gif',
  'images/emotion/2.gif',
  'images/emotion/2.gif',
  'images/emotion/2.gif',
  'images/emotion/2.gif',
  'images/emotion/2.gif',
];

class gatherEmotion extends StatefulWidget {
  const gatherEmotion({super.key});

  @override
  State<gatherEmotion> createState() => _gatherEmotionState();
}

final LayerLink _layerLink = LayerLink();

class _gatherEmotionState extends State<gatherEmotion> {
  List<String> items = ['기본', '기쁨', '슬픔', '화남', '짜증', '피곤', '설렘'];
  String? selectedItem = '기본';

  @override
  Widget build(BuildContext context) {
    final SizeX = MediaQuery.of(context).size.width;
    final SizeY = MediaQuery.of(context).size.height;

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
      body: SizedBox(
        child: Column(
          children: [
            Container(
              height: 50,
              //드롭박스
              color: Colors.blueGrey,
            ),
            Text("2023.10"),
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  //padding: const EdgeInsets.all(10),
                  itemCount: title.length,
                  itemBuilder: (BuildContext context, int index) {
                    return MyCustomContent(gtitle: title[index],gcontent: content, gemo: emo);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MonthlyData {
  final DateTime title;
  final List<String> content;
  final List<String> emo;

  MonthlyData({
    required this.title,
    required this.content,
    required this.emo,
  });
}

//커스텀 컨테이너
class MyCustomContent extends StatelessWidget {
  final DateTime gtitle;
  final List<String> gcontent;
  final List<String> gemo;

  MyCustomContent({
    super.key,
    required this.gtitle,
    required this.gcontent,
    required this.gemo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 100,
      child: Row(
        children: [
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  //shrinkWrap: true,
                  itemCount: gemo.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        IconButton(
                            iconSize: 40, onPressed: () {}, icon: Image.asset("${gemo[index]}")),
                        Text(gcontent[index])
                      ],
                    );
                  },
              )
          ),
        ],
      ),
    );
  }
}
