import 'pieIN.dart';

class PieData {
  final double smile;
  final double flutter;
  final double angry;
  final double annoying;
  final double tired;
  final double sad;
  final double calmness;

  PieData({
    required this.smile,
    required this.flutter,
    required this.angry,
    required this.annoying,
    required this.tired,
    required this.sad,
    required this.calmness,
  });

  List<IndividualPie> pieData = [];

  void initializePieData() {
    pieData = [
      if (smile.isFinite && smile >= 0) IndividualPie(x: smile),
      if (flutter.isFinite && flutter >= 0) IndividualPie(x: flutter),
      if (angry.isFinite && angry >= 0) IndividualPie(x: angry),
      if (annoying.isFinite && annoying >= 0) IndividualPie(x: annoying),
      if (tired.isFinite && tired >= 0) IndividualPie(x: tired),
      if (sad.isFinite && sad >= 0) IndividualPie(x: sad),
      if (calmness.isFinite && calmness >= 0) IndividualPie(x: calmness),
    ];
  }
}
