import 'individual_bar.dart';

class BarData{
  final double smail;
  final double flutter;
  final double angry;
  final double annoying;
  final double tired;
  final double sad;
  final double calmness;

  BarData({
    required this.smail,
    required this.flutter,
    required this.angry,
    required this.annoying,
    required this.tired,
    required this.sad,
    required this.calmness,
  });

  List<IndividualBar> barData = [];
  void initializeBarData(){
    barData = [
      IndividualBar(x: 0, y: smail),
      IndividualBar(x: 1, y: flutter),
      IndividualBar(x: 2, y: angry),
      IndividualBar(x: 3, y: annoying),
      IndividualBar(x: 4, y: tired),
      IndividualBar(x: 5, y: sad),
      IndividualBar(x: 6, y: calmness),
    ];
  }

}