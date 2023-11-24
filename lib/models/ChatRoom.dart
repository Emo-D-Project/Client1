class ChatRoom {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime lastMessageSentAt;

  ChatRoom({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastMessageSentAt,

    required this.isRead,
  });
}