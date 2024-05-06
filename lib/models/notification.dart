class notification {
  final int id;  //알림 번호
  final int targetUserId;
  final String title;
  final String body;
  final DateTime sentTime;

  notification({
    required this.id, //
    required this.targetUserId,
    required this.title,
    required this.body,
    required this.sentTime,
  });
}
