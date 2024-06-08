import 'package:capston1/main.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'alrampage.dart';
import 'comment.dart';
import 'diaryUpdate.dart';
import 'diaryshare.dart';
import 'models/Comment.dart';
import 'models/Diary.dart';

final cat_image = 'images/send/cat_real_image.png';

List<Comment> commentList = [];

class commentClick extends StatefulWidget {
  final Diary diary;
  final int postId;
  final int userid;

  const commentClick(
      {Key? key,
      required this.diary,
      required this.postId,
      required this.userid})
      : super(key: key);

  @override
  State<commentClick> createState() => _writediaryState(diary, postId, userid);
}

List<Diary> diariess = [];
List<Item> itemList = [];

class _writediaryState extends State<commentClick> {
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

  Diary? diaries;

  _writediaryState(Diary diary, int postId, int userid) {
    diaries = diary;
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromServer1();
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

  Future<void> fetchDataFromServer1() async {
    try {
      final data = await apiManager.getDiaryShareData();

      setState(() {
        diariess = data;
        for (Diary diary in diariess) {
          FavoriteCount favoriteCount = new FavoriteCount();

          apiManager.getFavoriteCount(diary.diaryId).then((int value) {
            favoriteCount.favoriteCount = value;
          });
        }
      });
    } catch (error) {
      // 에러 제어하는 부분
      print('Error getting share diaries list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    print("일기 정보 : ${diaries?.audio}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFFF8F5EB),
        title: Container(
          child: (() {
            switch (diaries?.emotion) {
              case 'smile':
                return Image.asset(
                  'images/emotion/smile.gif',
                  height: 50,
                  width: 50,
                );
              case 'flutter':
                return Image.asset(
                  'images/emotion/flutter.gif',
                  height: 50,
                  width: 50,
                );
              case 'angry':
                return Image.asset(
                  'images/emotion/angry.png',
                  height: 50,
                  width: 50,
                );
              case 'annoying':
                return Image.asset(
                  'images/emotion/annoying.gif',
                  height: 50,
                  width: 50,
                );
              case 'tired':
                return Image.asset(
                  'images/emotion/tired.gif',
                  height: 50,
                  width: 50,
                );
              case 'sad':
                return Image.asset(
                  'images/emotion/sad.gif',
                  height: 50,
                  width: 50,
                );
              case 'calmness':
                return Image.asset(
                  'images/emotion/calmness.gif',
                  height: 50,
                  width: 50,
                );
            }
          })(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) =>
                MyApp(),
            ));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
          width: sizeX,
          height: sizeY,
          decoration: BoxDecoration(
            color: Color(0xFFF8F5EB),
          ),
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                        child: diaries != null
                            ? Container(
                                child: (() {
                                  if (diaries!.imagePath!.isNotEmpty &&
                                      diaries!.audio == "") {
                                    return customWidget1(
                                      otherUserId: diaries!.userId,
                                      scomm: diaries!.is_comm,
                                      sdate: diaries!.date,
                                      sdiaryImage: diaries!.imagePath!,
                                      scomment: diaries!.content,
                                      diaryId: diaries!.diaryId,
                                      sfavoriteCount: diaries!.favoriteCount,
                                    );
                                  } else if (diaries!.imagePath!.isEmpty &&
                                      diaries!.audio == "") {
                                    return customWidget2(
                                      otherUserId: diaries!.userId,
                                      scomm: diaries!.is_comm,
                                      diaryId: diaries!.diaryId,
                                      sdate: diaries!.date,
                                      scomment: diaries!.content,
                                      sfavoriteCount: diaries!.favoriteCount,
                                    );
                                  } else if (diaries!.imagePath!.isEmpty &&
                                      diaries!.audio != "") {
                                    return customWidget3(
                                      otherUserId: diaries!.userId,
                                      scomm: diaries!.is_comm,
                                      sdate: diaries!.date,
                                      scomment: diaries!.content,
                                      svoice: diaries!.audio,
                                      diaryId: diaries!.diaryId,
                                      sfavoriteCount: diaries!.favoriteCount,
                                    );
                                  } else if (diaries!.imagePath!.isNotEmpty &&
                                      diaries!.audio != "") {
                                    return customWidget4(
                                      otherUserId: diaries!.userId,
                                      scomm: diaries!.is_comm,
                                      sdate: diaries!.date,
                                      diaryId: diaries!.diaryId,
                                      sdiaryImage: diaries!.imagePath!,
                                      scomment: diaries!.content,
                                      svoice: diaries!.audio,
                                      sfavoriteCount: diaries!.favoriteCount,
                                    );
                                  }
                                }()),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

//------------------------------------

// 일기 버전 1 - 텍스트 + 사진
class customWidget1 extends StatefulWidget {
  final DateTime sdate;
  final List<String> sdiaryImage;
  final String scomment;
  final int diaryId;
  final int sfavoriteCount;
  final bool scomm;
  final int otherUserId;

  const customWidget1({
    super.key,
    required this.sdate,
    required this.sdiaryImage,
    required this.scomment,
    required this.diaryId,
    required this.sfavoriteCount,
    required this.scomm,
    required this.otherUserId,

  });

  @override
  State<customWidget1> createState() => _customWidget1State(diaryId, scomm, otherUserId);
}

class _customWidget1State extends State<customWidget1> {
  int diaryId = 0;
  int favoriteCount = 0;

  ApiManager apiManager = ApiManager().getApiManager();
  final List<Comment> comments = [];
  bool scomm = true;
  int userId = 36;




  _customWidget1State(int diaryId, bool scomm, int otherUserId) {
    this.diaryId = diaryId;
    this.scomm = scomm;
    this.userId = otherUserId;
  }

  void initState() {
    super.initState();
    final favoriteCountFromMap = favoriteMap[diaryId];
    if (favoriteCountFromMap != null) {
      favoriteCount = favoriteCountFromMap.favoriteCount;
    } else {
      print('favorite Count From Map 오류 ');
    }
    fetchDataFromServer();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      plusDialog(context);
    });
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getDiaryShareData();

      setState(() {
        diaries = data;
        for (Diary diary in diaries) {
          FavoriteCount favoriteCount = new FavoriteCount();
          apiManager.getFavoriteCount(diary.diaryId).then((int value) {
            favoriteCount.favoriteCount = value;
          });

          apiManager
              .getCommentData(diary.diaryId)
              .then((List<Comment> commentList) {
            favoriteMap.addAll({diary.diaryId: favoriteCount});

            print(
                "diaryId: ${diary.diaryId} commentlist length: ${commentList.length}");
            // commentList의 길이에 접근
            int listLength = commentList.length;

            if (commentCount.containsKey(diary.diaryId)) {
              commentCount[diary.diaryId] = listLength;
            } else {
              commentCount.addAll({diary.diaryId: listLength});
            } // 원하는 작업 수행
            print(
                ("${diary.diaryId}commentCount 값: ${commentCount[diary.diaryId]}"));
          }).catchError((error) {
            print('Error getting commentList: $error');
          });
        }
      });
    } catch (error) {
      print('Error getting favorite count: $error');
    }
  }

  void plusDialog(BuildContext context) async {
    final sizeY = MediaQuery.of(context).size.height;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        print('다이어리 아이디 $diaryId');
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            height: sizeY * 0.8,
            color: Color(0xFF737373),
            child: comment(
              postId: diaryId,
              userid: userId,
            ),
          ),
        );
      },
    ).then((value) async {
      await fetchDataFromServer();

      await Future.delayed(Duration(milliseconds: 400));
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    fetchDataFromServer();
    return Center(
        child: Column(children: [
      Container(
        width: sizeX * 0.9,
        height: sizeY * 0.7,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                children: [
                  SizedBox(width: 30),
                  Text(
                    '${widget.sdate.year}년 ${widget.sdate.month}월 ${widget.sdate.day}일',
                    style: TextStyle(
                      fontFamily: 'soojin',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(width: 70),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DiaryUpdate(diaryId: diaryId)),
                      );
                    },
                    icon: Image.asset(
                      'images/main/pencil.png',
                      width: 25,
                      height: 25,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      return showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text(' '),
                          content: SizedBox(
                              height: sizeY * 0.05,
                              child: Center(
                                  child: Text(
                                "정말 삭제 하시겠습니까?",
                                style: TextStyle(fontFamily: 'soojin'),
                              ))),
                          actions: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: Color(0x4D968C83),
                                    minimumSize: Size(150, 30)),
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('취소',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontFamily: 'soojin'))),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0.0,
                                    backgroundColor: Color(0xFF7D5A50),
                                    minimumSize: Size(150, 30)),
                                onPressed: () async {
                                  apiManager.RemoveDiary(widget.diaryId);
                                  print('다이어리 아이디 : ${widget.diaryId}');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()));
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
                      width: 25,
                      height: 25,
                    ),
                  ),
                ],
              ),
            ), //날짜
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        width: 200,
                        height: 150, // 이미지 높이 조절
                        child: Container(
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.sdiaryImage.length > 3
                                ? 3
                                : widget.sdiaryImage.length,
                            // 최대 3장까지만 허용
                            itemBuilder: (context, index) {
                              print('일기 사진 : ${widget.sdiaryImage[index]}');
                              return Container(
                                child: Center(
                                  child:
                                      Image.network(widget.sdiaryImage[index]),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 380,
                      padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                      color: Colors.white54,
                      child: Column(
                        children: [
                          Text(
                            widget.scomment,
                            style:
                                TextStyle(fontFamily: 'soojin', fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Column(
              children: [
                Visibility(
                  visible: scomm,
                  child: GestureDetector(
                    onTap: () {
                      plusDialog(context);
                    },
                    child: Icon(Icons.chat_outlined, color: Colors.grey),
                  ),
                ),
                Visibility(
                  visible: scomm,
                  child: Text(
                    '${commentCount[diaryId]}',
                    style: TextStyle(fontSize: 11),
                  ),
                ),
              ],
            ),
          ),


    ]));
  }
}

//글만 있는 거
class customWidget2 extends StatefulWidget {
  final String scomment;
  final DateTime sdate;
  final int diaryId;
  final int sfavoriteCount;
  final bool scomm;
  final int otherUserId;

  const customWidget2({
    super.key,
    required this.scomment,
    required this.sdate,
    required this.diaryId,
    required this.sfavoriteCount,
    required this.scomm,
    required this.otherUserId,
  });

  @override
  State<customWidget2> createState() =>
      _customWidget2State(diaryId, scomm, otherUserId);
}

class _customWidget2State extends State<customWidget2> {
  int diaryId = 0;
  int userId = 36;

  int favoriteCount = 0;

  final List<Comment> comments = [];
  bool scomm = true;

  ApiManager apiManager = ApiManager().getApiManager();

  _customWidget2State(int diaryId, bool scomm, int otherUserId) {
    this.diaryId = diaryId;
    this.scomm = scomm;

    this.userId = otherUserId;
  }

  void initState() {
    super.initState();
    final favoriteCountFromMap = favoriteMap[diaryId];
    if (favoriteCountFromMap != null) {
      favoriteCount = favoriteCountFromMap.favoriteCount;
    } else {
      print('favorite Count From Map 오류 ');
    }
    fetchDataFromServer();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      plusDialog(context);
    });
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getDiaryShareData();

      setState(() {
        diaries = data;
        for (Diary diary in diaries) {
          FavoriteCount favoriteCount = new FavoriteCount();
          apiManager.getFavoriteCount(diary.diaryId).then((int value) {
            favoriteCount.favoriteCount = value;
          });

          apiManager
              .getCommentData(diary.diaryId)
              .then((List<Comment> commentList) {
            favoriteMap.addAll({diary.diaryId: favoriteCount});

            print(
                "diaryId: ${diary.diaryId} commentlist length: ${commentList.length}");
            // commentList의 길이에 접근
            int listLength = commentList.length;

            if (commentCount.containsKey(diary.diaryId)) {
              commentCount[diary.diaryId] = listLength;
            } else {
              commentCount.addAll({diary.diaryId: listLength});
            } // 원하는 작업 수행
            print(
                ("${diary.diaryId}commentCount 값: ${commentCount[diary.diaryId]}"));
          }).catchError((error) {
            print('Error getting commentList: $error');
          });
        }
      });
    } catch (error) {
      print('Error getting favorite count: $error');
    }
  }

  void plusDialog(BuildContext context) async {
    final sizeY = MediaQuery.of(context).size.height;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        print('다이어리 아이디 $diaryId');
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            height: sizeY * 0.8,
            color: Color(0xFF737373),
            child: comment(
              postId: diaryId,
              userid: userId,
            ),
          ),
        );
      },
    ).then((value) async {
      await fetchDataFromServer();

      await Future.delayed(Duration(milliseconds: 400));
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    fetchDataFromServer();
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Center(
        child: Column(children: [
      Container(
        width: sizeX * 0.9,
        height: sizeY * 0.7,
        margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(children: [
                SizedBox(
                  width: 30,
                ),
                Text(
                  '${widget.sdate.year}년 ${widget.sdate.month}월 ${widget.sdate.day}일',
                  style: TextStyle(
                    fontFamily: 'soojin',
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 70,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DiaryUpdate(diaryId: diaryId)),
                    );
                  },
                  icon: Image.asset(
                    'images/main/pencil.png',
                    width: 25,
                    height: 25,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(' '),
                        content: SizedBox(
                            height: sizeY * 0.05,
                            child: Center(
                                child: Text(
                              "정말 삭제 하시겠습니까?",
                              style: TextStyle(fontFamily: 'soojin'),
                            ))),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Color(0x4D968C83),
                                  minimumSize: Size(150, 30)),
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('취소',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'soojin'))),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Color(0xFF7D5A50),
                                  minimumSize: Size(150, 30)),
                              onPressed: () async {
                                apiManager.RemoveDiary(widget.diaryId);
                                print('다이어리 아이디 : ${widget.diaryId}');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()));
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
                    width: 25,
                    height: 25,
                  ),
                ),
              ]),
            ), //날짜
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                    width: 350,
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                    color: Colors.white54,
                    child: Column(
                      children: [
                        Text(
                          widget.scomment,
                          style: TextStyle(fontFamily: 'soojin', fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text(
                        '${favoriteCount}',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Column(
                    children: [
                      Visibility(
                        visible: scomm,
                        child: GestureDetector(
                          onTap: () {
                            plusDialog(context);
                          },
                          child: Icon(Icons.chat_outlined, color: Colors.grey),
                        ),
                      ),
                      Visibility(
                        visible: scomm,
                        child: Text(
                          '${commentCount[diaryId]}',
                          style: TextStyle(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ]));
  }
}

// 일기 버전 3 - 텍스트 + 음성
class customWidget3 extends StatefulWidget {
  final String scomment;
  final String svoice;
  final DateTime sdate;
  final int diaryId;
  final int sfavoriteCount;

  final bool scomm;
  final int otherUserId;

  const customWidget3({
    super.key,
    required this.scomment,
    required this.svoice,
    required this.sdate,
    required this.diaryId,
    required this.sfavoriteCount,
    required this.scomm,
    required this.otherUserId,
  });

  @override
  State<customWidget3> createState() => _customWidget3State(diaryId,scomm,otherUserId);
}

class _customWidget3State extends State<customWidget3> {
  int diaryId = 0;
  int favoriteCount = 0;

  final List<Comment> comments = [];
  bool scomm = true;
  int userId = 36;


  ApiManager apiManager = ApiManager().getApiManager();

  _customWidget3State(int diaryId, bool scomm, int otherUserId) {
    this.diaryId = diaryId;
    this.scomm = scomm;

    this.userId = otherUserId;
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getDiaryShareData();

      setState(() {
        diaries = data;
        for (Diary diary in diaries) {
          FavoriteCount favoriteCount = new FavoriteCount();
          apiManager.getFavoriteCount(diary.diaryId).then((int value) {
            favoriteCount.favoriteCount = value;
          });

          apiManager
              .getCommentData(diary.diaryId)
              .then((List<Comment> commentList) {
            favoriteMap.addAll({diary.diaryId: favoriteCount});

            print(
                "diaryId: ${diary.diaryId} commentlist length: ${commentList.length}");
            // commentList의 길이에 접근
            int listLength = commentList.length;

            if (commentCount.containsKey(diary.diaryId)) {
              commentCount[diary.diaryId] = listLength;
            } else {
              commentCount.addAll({diary.diaryId: listLength});
            } // 원하는 작업 수행
            print(
                ("${diary.diaryId}commentCount 값: ${commentCount[diary.diaryId]}"));
          }).catchError((error) {
            print('Error getting commentList: $error');
          });
        }
      });
    } catch (error) {
      print('Error getting favorite count: $error');
    }
  }

  void plusDialog(BuildContext context) async {
    final sizeY = MediaQuery.of(context).size.height;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        print('다이어리 아이디 $diaryId');
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            height: sizeY * 0.8,
            color: Color(0xFF737373),
            child: comment(
              postId: diaryId,
              userid: userId,
            ),
          ),
        );
      },
    ).then((value) async {
      await fetchDataFromServer();

      await Future.delayed(Duration(milliseconds: 400));
      setState(() {});
    });
  }


  //재생에 필요한 것들
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String imagePath = "";

  //String? playAudioPath = diary?.voice; //저장할때 받아올 변수 , 재생 시 필요

  @override
  void initState() {
    super.initState();
    playAudio();
    final favoriteCountFromMap = favoriteMap[diaryId];
    if (favoriteCountFromMap != null) {
      favoriteCount = favoriteCountFromMap.favoriteCount;
    } else {
      print('favorite Count From Map 오류 ');
    }
    fetchDataFromServer();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      plusDialog(context);
    });

    //재생 상태가 변경될 때마다 상태를 감지하는 이벤트 핸들러
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
      print("헨들러 isplaying : $isPlaying");
    });

    //재생 파일의 전체 길이를 감지하는 이벤트 핸들러
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    //재생 중인 파일의 현재 위치를 감지하는 이벤트 핸들러
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
      print('Current position: $position');
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio() async {
    try {
      if (isPlaying == PlayerState.playing) {
        await audioPlayer.stop(); // 이미 재생 중인 경우 정지시킵니다.
      }

      await audioPlayer.setSourceDeviceFile(widget.svoice);
      print("duration: $duration");
      await Future.delayed(Duration(seconds: 2));
      print("after wait duration: $duration");

      setState(() {
        duration = duration;
        isPlaying = true;
      });

      audioPlayer.play;

      print('오디오 재생 시작: ${widget.svoice}');
      print("duration: $duration");
    } catch (e) {
      print("audioPath : ${widget.svoice}");
      print("오디오 재생 중 오류 발생 : $e");
    }
  }

  String formatTime(Duration duration) {
    print("formatTime duration: $duration");

    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String result = '$minutes:${seconds.toString().padLeft(2, '0')}';

    print("formatTime result: $result");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    fetchDataFromServer();
    return Center(
      child: Column(
        children: [
          Container(
            width: sizeX * 0.9,
            height: sizeY * 0.7,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '${widget.sdate.year}년 ${widget.sdate.month}월 ${widget.sdate.day}일',
                      style: TextStyle(
                        fontFamily: 'soojin',
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DiaryUpdate(diaryId: diaryId)),
                        );
                      },
                      icon: Image.asset(
                        'images/main/pencil.png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        return showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(' '),
                            content: SizedBox(
                                height: sizeY * 0.05,
                                child: Center(
                                    child: Text(
                                  "정말 삭제 하시겠습니까?",
                                  style: TextStyle(fontFamily: 'soojin'),
                                ))),
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: Color(0x4D968C83),
                                      minimumSize: Size(150, 30)),
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('취소',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'soojin'))),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: Color(0xFF7D5A50),
                                      minimumSize: Size(150, 30)),
                                  onPressed: () async {
                                    apiManager.RemoveDiary(widget.diaryId);
                                    print('다이어리 아이디 : ${widget.diaryId}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()));
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
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ]),
                ), //날짜
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Column(
                          children: [
                            SliderTheme(
                              data: SliderThemeData(
                                inactiveTrackColor: Color(0xFFF8F5EB),
                              ),
                              child: Slider(
                                min: 0,
                                max: duration.inSeconds.toDouble(),
                                value: position.inSeconds.toDouble(),
                                onChanged: (value) async {
                                  setState(() {
                                    position = Duration(seconds: value.toInt());
                                  });
                                  await audioPlayer.seek(position);
                                  //await audioPlayer.resume();
                                },
                                activeColor: Color(0xFF968C83),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatTime(position),
                                    style: TextStyle(color: Colors.brown),
                                  ),
                                  SizedBox(width: 20),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                      padding: EdgeInsets.only(bottom: 50),
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.brown,
                                      ),
                                      iconSize: 25,
                                      onPressed: () async {
                                        print("isplaying 전 : $isPlaying");

                                        if (isPlaying) {
                                          //재생중이면
                                          await audioPlayer.pause(); //멈춤고
                                          setState(() {
                                            isPlaying = false; //상태변경하기..?
                                          });
                                        } else {
                                          //멈춘 상태였으면
                                          await playAudio();
                                          await audioPlayer
                                              .resume(); // 녹음된 오디오 재생
                                        }
                                        print("isplaying 후 : $isPlaying");
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    formatTime(duration),
                                    style: TextStyle(color: Colors.brown),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 380,
                        padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                        color: Colors.white54,
                        child: Column(
                          children: [
                            Text(
                              widget.scomment,
                              style:
                                  TextStyle(fontFamily: 'soojin', fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Column(
              children: [
                Visibility(
                  visible: scomm,
                  child: GestureDetector(
                    onTap: () {
                      plusDialog(context);
                    },
                    child: Icon(Icons.chat_outlined, color: Colors.grey),
                  ),
                ),
                Visibility(
                  visible: scomm,
                  child: Text(
                    '${commentCount[diaryId]}',
                    style: TextStyle(fontSize: 11),
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

// 일기 버전4 - 텍스트 + 음성 + 사진
class customWidget4 extends StatefulWidget {
  final List<String> sdiaryImage; // 다이어리 안에 이미지
  final String scomment; // 일기 내용
  final String svoice; // 녹음 기능
  final DateTime sdate;
  final int diaryId;
  final int sfavoriteCount;
  final bool scomm;
  final int otherUserId;

  const customWidget4({
    super.key,
    required this.sdiaryImage,
    required this.scomment,
    required this.svoice,
    required this.sdate,
    required this.diaryId,
    required this.sfavoriteCount,
    required this.scomm,
    required this.otherUserId,

  });

  @override
  State<customWidget4> createState() => _customWidget4State(diaryId,scomm,otherUserId);
}

class _customWidget4State extends State<customWidget4> {
  int diaryId = 0;
  int favoriteCount = 0;
  final List<Comment> comments = [];
  bool scomm = true;
  int userId = 36;

  ApiManager apiManager = ApiManager().getApiManager();

  _customWidget4State(int diaryId, bool scomm, int otherUserId) {
    this.diaryId = diaryId;
    this.scomm = scomm;
    this.userId = otherUserId;



  }

  //재생에 필요한 것들
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    final favoriteCountFromMap = favoriteMap[diaryId];
    if (favoriteCountFromMap != null) {
      favoriteCount = favoriteCountFromMap.favoriteCount;
    } else {
      print('favorite Count From Map 오류 ');
    }
    fetchDataFromServer();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      plusDialog(context);
    });


    playAudio();

    //재생 상태가 변경될 때마다 상태를 감지하는 이벤트 핸들러
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
      print("헨들러 isplaying : $isPlaying");
    });

    //재생 파일의 전체 길이를 감지하는 이벤트 핸들러
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    //재생 중인 파일의 현재 위치를 감지하는 이벤트 핸들러
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
      print('Current position: $position');
    });
  }



  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getDiaryShareData();

      setState(() {
        diaries = data;
        for (Diary diary in diaries) {
          FavoriteCount favoriteCount = new FavoriteCount();
          apiManager.getFavoriteCount(diary.diaryId).then((int value) {
            favoriteCount.favoriteCount = value;
          });

          apiManager
              .getCommentData(diary.diaryId)
              .then((List<Comment> commentList) {
            favoriteMap.addAll({diary.diaryId: favoriteCount});

            print(
                "diaryId: ${diary.diaryId} commentlist length: ${commentList.length}");
            // commentList의 길이에 접근
            int listLength = commentList.length;

            if (commentCount.containsKey(diary.diaryId)) {
              commentCount[diary.diaryId] = listLength;
            } else {
              commentCount.addAll({diary.diaryId: listLength});
            } // 원하는 작업 수행
            print(
                ("${diary.diaryId}commentCount 값: ${commentCount[diary.diaryId]}"));
          }).catchError((error) {
            print('Error getting commentList: $error');
          });
        }
      });
    } catch (error) {
      print('Error getting favorite count: $error');
    }
  }
  void plusDialog(BuildContext context) async {
    final sizeY = MediaQuery.of(context).size.height;
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        print('다이어리 아이디 $diaryId');
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            height: sizeY * 0.8,
            color: Color(0xFF737373),
            child: comment(
              postId: diaryId,
              userid: userId,
            ),
          ),
        );
      },
    ).then((value) async {
      await fetchDataFromServer();

      await Future.delayed(Duration(milliseconds: 400));
      setState(() {});
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> playAudio() async {
    try {
      if (isPlaying == PlayerState.playing) {
        await audioPlayer.stop(); // 이미 재생 중인 경우 정지시킵니다.
      }

      await audioPlayer.setSourceDeviceFile(widget.svoice);
      print("duration: $duration");
      await Future.delayed(Duration(seconds: 2));
      print("after wait duration: $duration");

      setState(() {
        duration = duration;
        isPlaying = true;
      });

      audioPlayer.play;

      print('오디오 재생 시작: ${widget.svoice}');
      print("duration: $duration");
    } catch (e) {
      print("audioPath : ${widget.svoice}");
      print("오디오 재생 중 오류 발생 : $e");
    }
  }

  String formatTime(Duration duration) {
    print("formatTime duration: $duration");

    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String result = '$minutes:${seconds.toString().padLeft(2, '0')}';

    print("formatTime result: $result");
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    fetchDataFromServer();
    return Center(
      child: Column(
        children: [
          Container(
            width: sizeX * 0.9,
            height: sizeY * 0.7,
            margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(children: [
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '${widget.sdate.year}년 ${widget.sdate.month}월 ${widget.sdate.day}일',
                      style: TextStyle(
                        fontFamily: 'soojin',
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 70,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DiaryUpdate(diaryId: diaryId)),
                        );
                      },
                      icon: Image.asset(
                        'images/main/pencil.png',
                        width: 25,
                        height: 25,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        return showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(' '),
                            content: SizedBox(
                                height: sizeY * 0.05,
                                child: Center(
                                    child: Text(
                                  "정말 삭제 하시겠습니까?",
                                  style: TextStyle(fontFamily: 'soojin'),
                                ))),
                            actions: [
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: Color(0x4D968C83),
                                      minimumSize: Size(150, 30)),
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('취소',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontFamily: 'soojin'))),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: Color(0xFF7D5A50),
                                      minimumSize: Size(150, 30)),
                                  onPressed: () async {
                                    apiManager.RemoveDiary(widget.diaryId);
                                    print('다이어리 아이디 : ${widget.diaryId}');
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()));
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
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ]),
                ), //날짜
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          width: 200,
                          height: 150, // 이미지 높이 조절
                          child: Container(
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.sdiaryImage.length > 3
                                  ? 3
                                  : widget.sdiaryImage.length,
                              // 최대 3장까지만 허용
                              itemBuilder: (context, index) {
                                print('일기 사진 : ${widget.sdiaryImage[index]}');
                                return Container(
                                  child: Center(
                                    child: Image.network(
                                        widget.sdiaryImage[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                        child: Column(
                          children: [
                            SliderTheme(
                              data: SliderThemeData(
                                inactiveTrackColor: Color(0xFFF8F5EB),
                              ),
                              child: Slider(
                                min: 0,
                                max: duration.inSeconds.toDouble(),
                                value: position.inSeconds.toDouble(),
                                onChanged: (value) async {
                                  setState(() {
                                    position = Duration(seconds: value.toInt());
                                  });
                                  await audioPlayer.seek(position);
                                  //await audioPlayer.resume();
                                },
                                activeColor: Color(0xFF968C83),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    formatTime(position),
                                    style: TextStyle(color: Colors.brown),
                                  ),
                                  SizedBox(width: 20),
                                  CircleAvatar(
                                    radius: 15,
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                      padding: EdgeInsets.only(bottom: 50),
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        color: Colors.brown,
                                      ),
                                      iconSize: 25,
                                      onPressed: () async {
                                        print("isplaying 전 : $isPlaying");

                                        if (isPlaying) {
                                          //재생중이면
                                          await audioPlayer.pause(); //멈춤고
                                          setState(() {
                                            isPlaying = false; //상태변경하기..?
                                          });
                                        } else {
                                          //멈춘 상태였으면
                                          await playAudio();
                                          await audioPlayer
                                              .resume(); // 녹음된 오디오 재생
                                        }
                                        print("isplaying 후 : $isPlaying");
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(
                                    formatTime(duration),
                                    style: TextStyle(color: Colors.brown),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 380,
                        padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                        color: Colors.white54,
                        child: Column(
                          children: [
                            Text(
                              widget.scomment,
                              style:
                                  TextStyle(fontFamily: 'soojin', fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Column(
              children: [
                Visibility(
                  visible: scomm,
                  child: GestureDetector(
                    onTap: () {
                      plusDialog(context);
                    },
                    child: Icon(Icons.chat_outlined, color: Colors.grey),
                  ),
                ),
                Visibility(
                  visible: scomm,
                  child: Text(
                    '${commentCount[diaryId]}',
                    style: TextStyle(fontSize: 11),
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
