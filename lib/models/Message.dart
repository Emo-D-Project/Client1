import 'package:capston1/models/MessageData.dart';

class Message {

  final String content; // 내용
  final DateTime sendtime;
  final bool isMyMessage; // 내가 보낸 메시지 여부


  Message({required this.content, required this.sendtime, required this.isMyMessage});   //보낸 시간


}