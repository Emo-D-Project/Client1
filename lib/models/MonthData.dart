class MonthData {
  final DateTime date;
  final List<double> emotions;
  final int mostEmotion;
  final int leastEmotion;
  final String comment;
  final int point;



  MonthData({
    required this.date,
    required this.emotions,
    required this.mostEmotion,
    required this.leastEmotion,
    required this.comment,
    required this.point,
  });
}
