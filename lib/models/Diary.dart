class Diary {
  DateTime date;
  String content;
  String emotion;
  List<String>? imagePath;
  String audio;
  int favoriteCount;
  bool favoriteColor;
  int userId;
  int diaryId;
  int scommentCount;



  Diary({
    required this.date,
    required this.content,
    required this.emotion,
    required this.imagePath,
    this.diaryId = 0,
    this.audio = "",
    this.favoriteCount = 0,
    this.favoriteColor = false,
    this.userId = 1,
    this.scommentCount = 0,
  });
}
