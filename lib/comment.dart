import 'package:flutter/material.dart';
import 'network/api_manager.dart';
import 'package:capston1/models/Comment.dart';

final cat_image = 'images/send/cat_real_image.png';


class comment extends StatefulWidget {
  const comment({super.key});

  @override
  State<comment> createState() => _commentState();
}

late String content;
late int post_id;
List<Comment> comments = []; // 댓글을 관리하는 리스트

class _commentState extends State<comment> {

  TextEditingController _commentController = TextEditingController();


  // 댓글 추가 기능 댓글이 쌓이면 숫자 증가함
  int _commentCount = 1;

  void addComment(String name, String imagePath, String text) {
    setState(() {
      comments.add(Comment(
        name: '$name $_commentCount',
        text: text,
      ));
      _commentCount++;
    });
    print('보낸 사람: $name $_commentCount, 전송 메세지: $text');
  }

  //==================================================
  ApiManager apiManager = ApiManager().getApiManager();


  //========================================

  @override
  Widget build(BuildContext context) {
    final sizeY = MediaQuery.of(context).size.height;
    return Container(
      height: sizeY * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 100,
              height: 5,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
              color: Color.fromRGBO(117, 117, 117, 100),
            ),
          ), // 맨위에 회색 줄

          //댓글 부분
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: comments.length,
              itemBuilder: (context, index) {
                Comment comment = comments[index];
                return Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Image.asset(
                          cat_image,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text(
                                comment.name,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF7D5A50),
                                  fontFamily: 'soojin',
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text(
                                comment.text,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'soojin',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          //댓글 달 수 있는 칸
          Container(
            height: 70,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 280,
                        height: 30,
                        padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                        child: TextField(
                          controller: _commentController,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'soojin',
                          ),
                          decoration: InputDecoration(
                            hintText: '내용을 입력해주세요',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          String commentText = _commentController.text;
                          if (commentText.isNotEmpty) {
                            // 댓글 추가 메서드 호출
                            addComment(
                                '삼냥이', 'images/emotion/1.gif', commentText);
                            // 텍스트 필드 비우기
                            _commentController.clear();
                          }
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/send/real_send.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
