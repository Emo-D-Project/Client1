class Diary {
  DateTime date;
  String content;
  String emotion;
  List<String> imagePath;
  String voice;
  int favoriteCount;
  bool favoriteColor;
  int userId;
  int diaryId;
  int diaryComment;

  Diary({
    required this.date,
    required this.content,
    required this.emotion,
    this.diaryId = 0,
    this.imagePath = const [],
    this.voice = "",
    this.favoriteCount = 0,
    this.favoriteColor = false,
    this.userId = 1,
    this.diaryComment = 0,
  });
}
