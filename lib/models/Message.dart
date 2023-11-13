class Message {
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime dateTime;

  Message(this.senderId, this.receiverId, this.content, this.dateTime);
}