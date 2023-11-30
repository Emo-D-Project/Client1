import 'package:capston1/models/Diary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'network/api_manager.dart';
import 'package:capston1/models/Comment.dart';

final cat_image = 'images/send/cat_real_image.png';

List<Comment> commentList = [  ];

class comment extends StatefulWidget {
  final int postId;

  const comment({super.key, required this.postId});

  @override
  State<comment> createState() => _commentState(postId);
}

class _commentState extends State<comment> {
  TextEditingController _commentController = TextEditingController(); //댓글 저장 변수
  ApiManager apiManager = ApiManager().getApiManager();

  late int postId;
  late String comment;

  final Map<int, List<int>> userTitle = {};
  final Map<int,List<Comment>> commentCount={};

  Map<int, int> catCount = {};

  _commentState(this.postId);

  @override
  void initState() {
    super.initState();

    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getCommentData(postId);
      setState(() {
        commentList = data!;

        int count = 1;
        for (Comment c in commentList) {
          if (!catCount.containsKey(c.user_id)) {
            catCount.addAll({c.user_id: count});
            count++;
          }
        }

      });
    } catch (error) {
      print('Error getting Comment list : $error');
    }
  }

  Future<void> GetComment(String endpoint) async {
    try {
      final response = await apiManager.Get(endpoint);
      final value = response['post_id'];
      print('post_id: $value');
      postId = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      final value = response['comment'];
      print('comment: $value');
      comment = value;
    } catch (e) {
      print('Error: $e');
    }
  }

  void addComment(int user_id, String text) {
    setState(() {

      if (!userTitle.containsKey(user_id)) {
        userTitle[user_id] = [1];
      } else {
        userTitle[user_id]!.add(userTitle[user_id]!.length + 1); // 댓글 번호 추가
      }

      commentList.add(Comment(
        user_id: user_id,
        content: text,
      ));

      print('보낸 사람: $user_id , 전송 메세지: $text');
    });
  }

  void _sendComment() async {
    String text = _commentController.text.trim();
    print('sendcomment 실행');



    if (text.isNotEmpty) {
      apiManager.sendComment(text, postId);
      print('포스트아이디:${postId}');
      _commentController.clear();

      await fetchDataFromServer();
    }
  }

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
              itemCount: commentList.length,
              itemBuilder: (context, index) {
                //Comment comment = commentList[index];
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
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child: Text(
                                    '삼냥이 ${catCount[commentList[index].user_id]}',
                                    //null이 아니면 마지막 요소 반환하고, null이거나 비어있으면 1을 반환
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF7D5A50),
                                      fontFamily: 'soojin',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                              child: Text(
                                commentList[index].content,
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
                        onTap: () async {
                          print('dkdkdkdkdkdk:   ${commentList.length}');
                          _sendComment();
                          await Future.delayed(Duration(milliseconds: 100));
                          final data = await apiManager.getCommentData(postId);
                          setState(() {
                            commentList = data!;

                            int count = 1;
                            for (Comment c in commentList) {
                              if (!catCount.containsKey(c.user_id)) {
                                catCount.addAll({c.user_id: count});
                                count++;
                              }
                            }
                          });
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
