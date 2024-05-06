import 'package:flutter/material.dart';
import 'network/api_manager.dart';
import 'package:capston1/models/Comment.dart';
import 'alrampage.dart';

final cat_image = 'images/send/cat_real_image.png';

List<Comment> commentList = [];

class comment extends StatefulWidget {
  final int postId;
  final int userid;

  const comment({
    super.key,
    required this.postId,
    required this.userid,
  });

  @override
  State<comment> createState() => _commentState(postId, userid);
}

List<Item> itemList = [];

class _commentState extends State<comment> {
  //알람 실행
  void _sendNotification(String title, String body) async {
    try {
      int targetUserId = userid;
      print(userid);

      apiManager.sendNotification(targetUserId, title, body);
      print('댓글 알람실행');

      setState(() {
        latestComment = body;
      });
    } catch (error) {
      print('Error sending comment notification : $error');
    }
  }

  TextEditingController _commentController = TextEditingController(); //댓글 저장 변수
  ApiManager apiManager = ApiManager().getApiManager();

  late int userid;

  late int postId;
  late String comment;
  int id = 0;

  int Myid = 0;

  final Map<int, List<int>> userTitle = {};
  final Map<int, List<Comment>> commentCount = {};

  Map<int, int> catCount = {};
  String latestComment = "";

  _commentState(this.postId, this.userid);

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
    fetchMyIDFromServer();
  }

  // 다이어리 아이디 카운트
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
        // 새로운 댓글이 추가될 때마다 latestComment 값을 업데이트
        if (commentList.isNotEmpty) {
          latestComment = commentList.last.content;
        }
      });
    } catch (error) {
      print('Error getting Comment list : $error');
    }
  }

  Future<void> fetchMyIDFromServer() async {
    try {
      final myid = await apiManager.GetMyId();

      setState(() {
        Myid = myid!;
      });
    } catch (error) {
      print('Error getting intro list: $error');
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
    try {
      final response = await apiManager.Get(endpoint);
      final value = response['id'];
      print('id: $value');
      id = value;
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
      // 댓글을 전송합니다.
      apiManager.sendComment(text, postId);
      print('포스트아이디:${postId}');
      _commentController.clear();

      String title = "누군가 댓글을 달았습니다";
      print("되나연");

      String body = text.length > 6 ? text.substring(0, 6) + "..." : text;

      if (Myid == userid) {
        _sendNotification(title, body);
        print(title);
        print(body);
      } else {
        print("알ㄹ미 실채");
      }

      // 댓글 목록을 다시 가져옵니다.
      await fetchDataFromServer();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: sizeY,
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
                          child: Row(
                            children: [
                              Column(
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
                                    width: 270,
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
                              //Padding(padding: EdgeInsets.fromLTRB(200, 0, 0, 0),),
                              Visibility(
                                visible: commentList[index].user_id == Myid,
                                child: IconButton(
                                  onPressed: () async {
                                    return showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: Text(' '),
                                        content: SizedBox(
                                            height: sizeY * 0.05,
                                            child: Center(
                                                child: Text(
                                              "정말 삭제 하시겠습니까?",
                                              style:
                                                  TextStyle(fontFamily: 'soojin'),
                                            ))),
                                        actions: [
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0.0,
                                                  backgroundColor:
                                                      Color(0x4D968C83),
                                                  minimumSize: Size(150, 30)),
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text('취소',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontFamily: 'soojin'))),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  elevation: 0.0,
                                                  backgroundColor:
                                                      Color(0xFF7D5A50),
                                                  minimumSize: Size(150, 30)),
                                              onPressed: () async {
                                                apiManager.RemoveComment(
                                                    commentList[index].id);
                                                await Future.delayed(
                                                    Duration(milliseconds: 500));

                                                fetchDataFromServer();
                                                Navigator.of(context).pop();

                                                print(
                                                    '댓글 아이디 : ${commentList[index].id}');
                                              },
                                              child: Text('확인',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20,
                                                      fontFamily: 'soojin'))),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: Image.asset(
                                    'images/main/trash.png',
                                    width: 20,
                                    height: 20,
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
                            print('  ${commentList.length}');
                            _sendComment();

                            fetchDataFromServer();
                            await Future.delayed(Duration(milliseconds: 500));
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
      ),
    );
  }
}
