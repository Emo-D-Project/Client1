class Comment {
  final int post_id;
  final String content;
  int id;
  int user_id;


  Comment({
    required this.post_id,
    required this.content,
    this.id = 0,
    this.user_id=0,
  });
}
