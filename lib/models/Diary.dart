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
  bool is_share;
  bool is_comm;



  Diary({
    required this.date,
    required this.content,
    required this.emotion,
    required this.imagePath,
    required this.is_comm,
    required this.is_share,
    this.diaryId = 0,
    this.audio = "",
    this.favoriteCount = 0,
    this.favoriteColor = false,
    this.userId = 1,
    this.scommentCount = 0,

  });
}
