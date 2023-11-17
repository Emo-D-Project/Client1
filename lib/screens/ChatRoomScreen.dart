import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/ChatRoom.dart';

class ChatRoomScreen extends StatelessWidget {
  final ChatRoom chatRoom;

  ChatRoomScreen({required this.chatRoom});

  // 서버에서 가져온 가상의 대화 목록
  final List<String> messages = [
    "Hello!",
    "How are you?",
    // ... 다른 메시지들
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(chatRoom.name),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(messages[index]),
          );
        },
      ),
    );
  }
}
