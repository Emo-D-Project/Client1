import 'package:capston1/bar%20graph/bar_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyBarGraph extends StatelessWidget {
  final List emotioncount;

  const MyBarGraph({
    super.key,
    required this.emotioncount,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      smile: emotioncount[0],
      flutter: emotioncount[1],
      angry: emotioncount[2],
      annoying: emotioncount[3],
      tired: emotioncount[4],
      sad: emotioncount[5],
      calmness: emotioncount[6],
    );
    myBarData.initializeBarData();

    return BarChart(BarChartData(
      maxY: 250,
      minY: 0,
      gridData: FlGridData(show: false),
      borderData: FlBorderData(show: false),
      titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTitles))),
      barGroups: myBarData.barData
          .map((data) => BarChartGroupData(x: data.x, barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: Colors.grey[800],
                  width: 25,
                  borderRadius: BorderRadius.circular(4),
                ),
              ]))
          .toList(),
    ));
  }

  Widget getBottomTitles(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text("${emotioncount[0].toInt()}");
        break;
      case 1:
        text = Text("${emotioncount[1].toInt()}");
        break;
      case 2:
        text = Text("${emotioncount[2].toInt()}");
        break;
      case 3:
        text = Text("${emotioncount[3].toInt()}");
        break;
      case 4:
        text = Text("${emotioncount[4].toInt()}");
        break;
      case 5:
        text = Text("${emotioncount[5].toInt()}");
        break;
      case 6:
        text = Text("${emotioncount[6].toInt()}");
        break;
      default:
        text = Text(" ");
        break;
    }

    return SideTitleWidget(axisSide: meta.axisSide, child: text);
  }
}
