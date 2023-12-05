class ChatRoom {
  final int otherUserId;
  final String name;
  final String lastMessage;
  final DateTime lastMessageSentAt;
  late final bool isRead;



  ChatRoom({
    required this.otherUserId,
    required this.name,
    required this.lastMessage,
    required this.lastMessageSentAt,
    required this.isRead,


  });
}
