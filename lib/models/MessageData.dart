class MessageData {
  final String content;
  final String imagePath;
  bool isRead; // 읽음 여부를 보여줌

  MessageData({
    required this.content,
    required this.imagePath,
    this.isRead = false, // 기본값은 안읽음
  });
}
