import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyPieChart extends StatelessWidget{
  const MyPieChart({super.key});

  @override
  Widget build(BuildContext context){
    return PieChart(
      PieChartData(
        sections:[
          PieChartSectionData(
            color: Color(0xFF7D5A50),
            value: 3,
            radius: 40,
            title:'기쁨',
            titleStyle: TextStyle(fontFamily: 'soojin', fontSize: 20, color: Colors.black54),
          ),
          PieChartSectionData(
            color: Color(0xFFE9E7E5),
            value: 10,
            radius: 40,
            title:'슬픔',
            titleStyle: TextStyle(fontFamily: 'soojin', fontSize: 20, color: Colors.black54),
          ),
          PieChartSectionData(
            color: Color(0xFFEBE0DA),
            value: 9,
            radius: 40,
            title:'화남',
            titleStyle: TextStyle(fontFamily: 'soojin', fontSize: 20, color: Colors.black54),
          ),
          PieChartSectionData(
            color: Color(0xFFD2C6BC),
            value: 2,
            radius: 40,
            title:'짜증',
            titleStyle: TextStyle(fontFamily: 'soojin', fontSize: 20, color: Colors.black54),
          ),
          PieChartSectionData(
            color: Color(0xFFD1CBC2),
            value: 0,
            radius: 40,
            title:'평온',
            titleStyle: TextStyle(fontFamily: 'soojin', fontSize: 20, color: Colors.black54),
          ),
          PieChartSectionData(
            color: Color(0xFF504F4F),
            value: 1,
            radius: 40,
            title:'설렘',
            titleStyle: TextStyle(fontFamily: 'soojin', fontSize: 20, color: Colors.black54),
          ),
        ]
      )

    );
  }
}