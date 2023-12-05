class Message {
  final String content; // 내용
  final DateTime sendtime;
  final bool isMyMessage; // 내가 보낸 메시지 여부
  final int senderId;
  final int receiverId;

  Message({
    required this.receiverId,
    required this.senderId,
    required this.content,
    required this.sendtime,
    required this.isMyMessage,
  }); //보낸 시간
}
