import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:capston1/pieGraph/pieData.dart';

class MyPieChart extends StatelessWidget {
  final List emotioncount2;

  const MyPieChart({
    Key? key,
    required this.emotioncount2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PieData myPieData = PieData(
      smile: emotioncount2[0],
      flutter: emotioncount2[1],
      angry: emotioncount2[2],
      annoying: emotioncount2[3],
      tired: emotioncount2[4],
      sad: emotioncount2[5],
      calmness: emotioncount2[6],
    );
    myPieData.initializePieData();

    return PieChart(PieChartData(sections: [
      PieChartSectionData(
        color: Color(0xFF7D5A50),
        value: emotioncount2[0].toDouble(),
        radius: 40,
        title: '기쁨',
        titleStyle: TextStyle(
            fontFamily: 'soojin', fontSize: 15, color: Colors.black54),
      ),
      PieChartSectionData(
        color: Color(0xFFE9E7E5),
        value: emotioncount2[1].toDouble(),
        radius: 40,
        title: '슬픔',
        titleStyle: TextStyle(
            fontFamily: 'soojin', fontSize: 15, color: Colors.black54),
      ),
      PieChartSectionData(
        color: Color(0xFFEBE0DA),
        value: emotioncount2[2].toDouble(),
        radius: 40,
        title: '화남',
        titleStyle: TextStyle(
            fontFamily: 'soojin', fontSize: 15, color: Colors.black54),
      ),
      PieChartSectionData(
        color: Color(0xFFD2C6BC),
        value: emotioncount2[3].toDouble(),
        radius: 40,
        title: '짜증',
        titleStyle: TextStyle(
            fontFamily: 'soojin', fontSize: 15, color: Colors.black54),
      ),
      PieChartSectionData(
        color: Color(0xFFD1CBC2),
        value: emotioncount2[4].toDouble(),
        radius: 40,
        title: '평온',
        titleStyle: TextStyle(
            fontFamily: 'soojin', fontSize: 15, color: Colors.black54),
      ),
      PieChartSectionData(
        color: Color(0xFFF1DFDF),
        value: emotioncount2[5].toDouble(),
        radius: 40,
        title: '설렘',
        titleStyle: TextStyle(
            fontFamily: 'soojin', fontSize: 15, color: Colors.black54),
      ),
      PieChartSectionData(
        color: Color(0xFFF7F4EA),
        value: emotioncount2[6].toDouble(),
        radius: 40,
        title: '피곤',
        titleStyle: TextStyle(
            fontFamily: 'soojin', fontSize: 15, color: Colors.black54),
      ),
    ]));
  }
}
