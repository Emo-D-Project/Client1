class Diary {
  DateTime date;
  String content;
  String emotion;
  List<String> imagePath;
  String diaryImage;
  String voice;
  int favoriteCount;
  bool favoriteColor;
  int userId;

  Diary({
    required this.date,
    required this.content,
    required this.emotion,
    this.imagePath = const [],
    this.diaryImage = "",
    this.voice = "",
    this.favoriteCount = 0,
    this.favoriteColor = false,
    this.userId = 1,
  });
}
