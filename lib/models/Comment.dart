class Comment {
  int post_id;
  final String content;
  int id;
  int user_id;


  Comment({
    this.post_id =0,   //다이어리 아이디
    required this.content,  //댓글 내용
    this.id = 0,
    this.user_id=0, //댓글 쓴 사람
  });
}
