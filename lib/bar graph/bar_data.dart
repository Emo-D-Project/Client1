import 'individual_bar.dart';

class BarData{
  final double calmness;
  final double happy;
  final double tired;
  final double sad;
  final double angry;
  final double flutter;
  final double annoying;

  BarData({
    required this.angry,
    required this.annoying,
    required this.calmness,
    required this.flutter,
    required this.happy,
    required this.sad,
    required this.tired,
  });

  List<IndividualBar> barData = [];

  void initializeBarData(){
    barData = [
      IndividualBar(x: 0, y: calmness),
      IndividualBar(x: 0, y: tired),
      IndividualBar(x: 0, y: sad),
      IndividualBar(x: 0, y: happy),
      IndividualBar(x: 0, y: flutter),
      IndividualBar(x: 0, y: angry),
      IndividualBar(x: 0, y: annoying),
    ];
  }

}