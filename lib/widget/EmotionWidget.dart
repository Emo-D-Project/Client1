import 'package:flutter/material.dart';

class EmotionWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data;


  EmotionWidget(this.data);

  @override
  Widget build(BuildContext context) {
    print("이모션 위젯 실행");
    print("data: " + data.toString());
    return Row(
      children: data.map((entry) {
        String emotion = entry["emotion"];
        String imagePath = getEmotionImagePath(emotion);

        return GestureDetector(
          onTap: () {
            // 감정 아이콘을 눌렀을 때의 동작 추가
          },
          child: Image.asset(
            imagePath,
            width: 50,
            height: 50,
          ),
        );
      }).toList(),
    );
  }

  String getEmotionImagePath(String emotion) {
    switch (emotion) {
      case "angry":
        return 'images/emotion/angry.png';
      case "flutter":
        return 'images/emotion/2.gif';
      case "smile":
        return 'images/emotion/1.gif';
      case "annoying":
        return 'images/emotion/4.gif';
      case "sad":
        return 'images/emotion/6.gif';
      case "calmness":
        return 'images/emotion/7.gif';
      case "tired":
        return 'images/emotion/5.gif';
      default:
        return ''; // 감정에 해당하는 이미지가 없을 경우 빈 문자열 반환
    }
  }
}
