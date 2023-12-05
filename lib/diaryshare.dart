import 'dart:core';
import 'dart:io';
import 'package:capston1/mypage.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'comment.dart';
import 'message_write.dart';
import 'package:audioplayers/audioplayers.dart';
import 'models/Comment.dart';
import 'models/Diary.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;
import 'package:capston1/models/Comment.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;
import 'package:capston1/otherMypage.dart';

//맨 위 상단 감정 7개
final List<String> imagePaths = [
  'images/emotion/calmness.gif',
  'images/emotion/smile.gif',
  'images/emotion/flutter.gif',
  'images/emotion/angry.png',
  'images/emotion/annoying.gif',
  'images/emotion/tired.gif',
  'images/emotion/sad.gif',
];

String formattedDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());
String selectedImageEmotion = ' '; // 기본으로 'images/emotion/calmness.gif'를 선택

class diaryshare extends StatefulWidget {
  diaryshare({Key? key}) : super(key: key);

  @override
  State<diaryshare> createState() => _diaryshareState();
}

List<Diary> diaries = [];
Map<int, int> commentCount = {};
Map<int, FavoriteCount> favoriteMap = {};

class FavoriteCount {
  bool favoriteColor = false;
  int favoriteCount = 0;
}

class _diaryshareState extends State<diaryshare> {
  ApiManager apiManager = ApiManager().getApiManager();

  List<Diary> selectedEmotionDiaries = [];
  int favoriteCounts = 0;
  String selectedValue = '최신순';
  DateTime selectedDate = DateTime.now();



  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getDiaryShareData();
      apiManager.getFavoriteCount(30);

      setState(() {
        diaries = data;
        for (Diary diary in diaries) {
          FavoriteCount favoriteCount = new FavoriteCount();

          {
            bool favoriteColor = false;
            int favoriteCount = 0;
          }
          apiManager.getFavoriteCount(diary.diaryId).then((int value) {
            favoriteCount.favoriteCount = value;
          });

          apiManager.GetFavoriteColor(diary.diaryId).then((value) {
            favoriteCount.favoriteColor = value;
          });

          apiManager
              .getCommentData(diary.diaryId)
              .then((List<Comment> commentList) {
            favoriteMap.addAll({diary.diaryId: favoriteCount});
            // commentList의 길이에 접근
            int listLength = commentList.length;

            commentCount.addAll({diary.diaryId: listLength});
            // 원하는 작업 수행
          }).catchError((error) {
            print('Error getting commentList: $error');
          });
        }
        // formattedDate와 같은 날짜의 일기만 필터링
        selectedEmotionDiaries = diaries
            .where((diary) =>
                DateFormat('yyyy년 MM월 dd일').format(diary.date) == formattedDate)
            .toList();
      });
    } catch (error) {
      // 에러 제어하는 부분
      print('Error getting share diaries list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 5000));

    return Container(
      color: Color(0xFFF8F5EB),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
            child: Text(
              formattedDate,
              style: TextStyle(
                color: Color(0xFF7D5A50),
                fontSize: 17,
                fontWeight: FontWeight.w900,
                fontFamily: 'soojin',
              ),
            ), //날짜
          ),
          //감정 아이콘
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            child: Row(
              children: imagePaths.asMap().entries.map((entry) {
                String imagePath = entry.value;
                String emotion = "";
                switch (imagePath) {
                  case 'images/emotion/angry.png':
                    emotion = "angry";
                    break;
                  case "images/emotion/flutter.gif":
                    emotion = 'flutter';
                    break;
                  case "images/emotion/smile.gif":
                    emotion = 'smile';
                    break;
                  case "images/emotion/annoying.gif":
                    emotion = 'annoying';
                    break;
                  case "images/emotion/sad.gif":
                    emotion = 'sad';
                    break;
                  case "images/emotion/calmness.gif":
                    emotion = 'calmness';
                    break;
                  case "images/emotion/tired.gif":
                    emotion = 'tired';
                    break;
                  default:
                    emotion = 'flutter';
                    break;
                }
                return Padding(
                  padding: EdgeInsets.all(3),
                  child: IconButton(
                    icon: Image.asset(
                      imagePath,
                      width: 50,
                      height: 50,
                    ),
                    onPressed: () async {
                      await Future.delayed(Duration(seconds: 1), () {
                        // 이곳에 4초 후에 실행될 코드 작성
                        print("After 0.5 seconds");
                      });
                      setState(() {
                        // 해당 이미지에 대한 일기 내용을 찾기
                        List<Diary> diariesWithSelectedEmotion = diaries
                            .where((diary) => diary.emotion == emotion)
                            .toList();

                        selectedImageEmotion = emotion;
                        selectedEmotionDiaries = diariesWithSelectedEmotion;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(10),
              itemCount: selectedEmotionDiaries.length,
              itemBuilder: (BuildContext context, int index) {
                print(
                    "selectedEmotionDiaries length: ${selectedEmotionDiaries.length}");
                selectedEmotionDiaries.forEach((element) {
                  print("selected diaries emotion: ${element.emotion}");
                });

                DateTime formattedDateTime = selectedEmotionDiaries[index].date;

                String emotionImagePath;

                switch (selectedEmotionDiaries[index].emotion) {
                  case "angry":
                    emotionImagePath = 'images/emotion/angry.png';
                    break;
                  case "flutter":
                    emotionImagePath = 'images/emotion/flutter.gif';
                    break;
                  case "smile":
                    emotionImagePath = 'images/emotion/smile.gif';
                    break;
                  case "annoying":
                    emotionImagePath = 'images/emotion/annoying.gif';
                    break;
                  case "sad":
                    emotionImagePath = 'images/emotion/sad.gif';
                    break;
                  case "calmness":
                    emotionImagePath = 'images/emotion/calmness.gif';
                    break;
                  case "tired":
                    emotionImagePath = 'images/emotion/tired.gif';
                    break;
                  default:
                    emotionImagePath = 'images/emotion/flutter.gif';
                    break;
                }
                if (selectedImageEmotion ==
                        selectedEmotionDiaries[index].emotion &&
                    formattedDateTime.year == DateTime.now().year &&
                    formattedDateTime.month == DateTime.now().month &&
                    formattedDateTime.day == DateTime.now().day) {
                  return SizedBox(
                    child: (() {
                      if (selectedEmotionDiaries[index].imagePath!.isNotEmpty &&
                          selectedEmotionDiaries[index].voice.isEmpty) {
                        return customWidget1(
                          simagePath: selectedEmotionDiaries[index].emotion,
                          sdiaryImage: selectedEmotionDiaries[index].imagePath,
                          scomment: selectedEmotionDiaries[index].content,
                          sfavoritColor:
                              selectedEmotionDiaries[index].favoriteColor,
                          sfavoritCount:
                              selectedEmotionDiaries[index].favoriteCount,
                          otherUserId: selectedEmotionDiaries[index].userId,
                          diaryId: selectedEmotionDiaries[index].diaryId,
                          scommentCount:
                              selectedEmotionDiaries[index].scommentCount,
                        );

                      }
                      else if (selectedEmotionDiaries[index].imagePath!.isEmpty &&
                          selectedEmotionDiaries[index].voice.isEmpty) {
                        return customWidget2(
                          scomment: selectedEmotionDiaries[index].content,
                          sfavoritColor:
                              selectedEmotionDiaries[index].favoriteColor,
                          sfavoritCount:
                              selectedEmotionDiaries[index].favoriteCount,
                          simagePath: emotionImagePath,
                          otherUserId: selectedEmotionDiaries[index].userId,
                          diaryId: selectedEmotionDiaries[index].diaryId,
                          scommentCount:
                              selectedEmotionDiaries[index].scommentCount,
                        );

                      }
                      else if (selectedEmotionDiaries[index].imagePath!.isEmpty &&
                          selectedEmotionDiaries[index].voice.isNotEmpty) {
                        return customwidget3(
                          scomment: selectedEmotionDiaries[index].content,
                          sfavoritColor:
                              selectedEmotionDiaries[index].favoriteColor,
                          sfavoritCount:
                              selectedEmotionDiaries[index].favoriteCount,
                          simagePath: selectedEmotionDiaries[index].emotion,
                          svoice: selectedEmotionDiaries[index].voice,
                          otherUserId: selectedEmotionDiaries[index].userId,
                          diaryId: selectedEmotionDiaries[index].diaryId,
                          scommentCount:
                              selectedEmotionDiaries[index].scommentCount,
                        );

                      }
                      else if (selectedEmotionDiaries[index].imagePath!.isNotEmpty &&
                          selectedEmotionDiaries[index].voice.isNotEmpty) {
                        return customwidget4(
                          sdiaryImage: selectedEmotionDiaries[index].imagePath,
                          scomment: selectedEmotionDiaries[index].content,
                          sfavoritColor:
                              selectedEmotionDiaries[index].favoriteColor,
                          sfavoritCount:
                              selectedEmotionDiaries[index].favoriteCount,
                          simagePath: selectedEmotionDiaries[index].emotion,
                          svoice: selectedEmotionDiaries[index].voice,
                          otherUserId: selectedEmotionDiaries[index].userId,
                          diaryId: selectedEmotionDiaries[index].diaryId,
                          scommentCount:
                              selectedEmotionDiaries[index].scommentCount,
                        );
                      }
                    })(),
                  );
                } else {
                  // 선택된 이미지에 해당하는 일기가 없을 경우 빈 컨테이너 반환
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 일기 버전 1 - 텍스트 + 사진
class customWidget1 extends StatefulWidget {
  final String simagePath;
  final List<String>? sdiaryImage;
  final String scomment;
  final int sfavoritCount;
  final bool sfavoritColor;
  final int otherUserId;
  final int diaryId;
  final int scommentCount;

  const customWidget1({
    super.key,
    required this.simagePath,
    required this.sdiaryImage,
    required this.scomment,
    required this.sfavoritColor,
    required this.sfavoritCount,
    required this.otherUserId,
    required this.diaryId,
    required this.scommentCount,
  });

  @override
  State<customWidget1> createState() =>
      _customWidget1State(otherUserId, diaryId);
}

class _customWidget1State extends State<customWidget1> {
  late bool sfavoritColor; // 추가된 부분

  String imagePath = "";
  int userId = 36;
  int diaryId = 36;
  int favoriteCounts = 0;
  final List<Comment> comments = [];



  ApiManager apiManager = ApiManager().getApiManager();

  _customWidget1State(int otherUserId, int diaryId) {
    this.userId = otherUserId;
    this.diaryId = diaryId;
  }

  void initState() {
    super.initState();

    favoriteCounts = favoriteMap[diaryId]!.favoriteCount;
    sfavoritColor = favoriteMap[diaryId]!.favoriteColor;
    print("init state 좋아요 카운트: $favoriteCounts");


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
            child: comment(postId: diaryId),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("commentCount: ${commentCount[diaryId]}");

    print("otherUserId: ${userId}");

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 380,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Container(
                  width: 380,
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => otherMypage(
                                        userId: userId,
                                      ),
                                    ),
                                  );
                                  print('감정 탭하기');
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  margin: EdgeInsets.only(left: 50),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(imagePath),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ))),
                      IconButton(
                        onPressed: () {
                          if (userId !=  LoginedUserInfo.loginedUserInfo.id) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    message_write(otherUserId: userId),
                              ),
                            );
                          }
                        },
                        icon: userId !=  LoginedUserInfo.loginedUserInfo.id
                            ? Image.asset(
                                'images/send/real_send.png',
                                height: 50, // 이미지 높이 조절
                                width: 30, // 이미지 너비 조절
                              )
                            : Container(), // userId가 36이면 빈 컨테이너 반환
                      ),
                    ],
                  ),
                ),
                //이미지
                SingleChildScrollView(
                  child: Container(
                    width: 200,
                    height: 150, // 이미지 높이 조절
                    child: Container(
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.sdiaryImage!.length > 3
                            ? 3
                            : widget.sdiaryImage?.length, // 최대 3장까지만 허용
                        itemBuilder: (context, index) {
                          print('일기 사진 : ${widget.sdiaryImage?[index]}');
                          return Container(
                            child: Center(
                              child: Image.network(widget.sdiaryImage![index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                //일기 내용
                Container(
                    width: 380,
                    padding: const EdgeInsets.fromLTRB(35, 20, 35, 10),
                    color: Colors.white54,
                    child: Column(
                      children: [
                        Text(
                          widget.scomment,
                          style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ],
            ),
          ),
          //좋아요,댓글

          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await apiManager.putFavoriteCount(diaryId);
                        print("좋아요 누름 :${diaryId}");
                        try {
                          setState(() {
                            if (sfavoritColor) {
                              favoriteCounts = favoriteCounts - 1;
                            } else {
                              favoriteCounts = favoriteCounts + 1;
                            }
                            sfavoritColor = !sfavoritColor;
                          });
                        } catch (error) {
                          print('Error updating favorite count: $error');
                        }
                      },
                      child: Icon(
                        Icons.favorite,
                        color: sfavoritColor ? Colors.red : Colors.grey,
                      ),
                    ),
                    Text(
                      '${favoriteCounts}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              //댓글
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        plusDialog(context);
                        Future.delayed(Duration(seconds: 4), () {
                          print(commentList.length);
                        });
                      },
                      child: Icon(Icons.chat_outlined, color: Colors.grey),
                    ),
                    Text(
                      '${commentCount[diaryId]}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

//글만 있는 거
class customWidget2 extends StatefulWidget {
  final String simagePath;
  final String scomment;
  final int sfavoritCount;
  final bool sfavoritColor;
  final int otherUserId;
  final int diaryId;
  final int scommentCount;

  const customWidget2({
    super.key,
    required this.simagePath,
    required this.scomment,
    required this.sfavoritColor,
    required this.sfavoritCount,
    required this.otherUserId,
    required this.diaryId,
    required this.scommentCount,
  });

  @override
  State<customWidget2> createState() => _customWidget2State(
        otherUserId,
        diaryId,
        simagePath,
      );
}

class _customWidget2State extends State<customWidget2> {
  bool sfavoritColor = false;
  int userId = 36;
  String imagePath = "";
  int diaryId = 36;

  List<Diary> selectedEmotionDiaries = [];


  //TextEditingController _commentController = TextEditingController();
  int favoriteCounts = 0;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    print("setState 호출됨 위젯2");
  }

  ApiManager apiManager = ApiManager().getApiManager();

  _customWidget2State(
    int otherUserId,
    int diaryId,
    String imagePath,
  ) {
    this.userId = otherUserId;
    this.diaryId = diaryId;
    this.imagePath = imagePath;
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
            child: comment(postId: diaryId),
          ),
        );
      },
    );
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getDiaryShareData();
      apiManager.getFavoriteCount(30);

      setState(() {
        diaries = data;
        for (Diary diary in diaries) {
          FavoriteCount favoriteCount = new FavoriteCount();

          {
            bool favoriteColor = false;
            int favoriteCount = 0;
          }
          apiManager.getFavoriteCount(diary.diaryId).then((int value) {
            favoriteCount.favoriteCount = value;
          });

          apiManager.GetFavoriteColor(diary.diaryId).then((value) {
            favoriteCount.favoriteColor = value;
          });

          apiManager
              .getCommentData(diary.diaryId)
              .then((List<Comment> commentList) {
            favoriteMap.addAll({diary.diaryId: favoriteCount});
            // commentList의 길이에 접근
            int listLength = commentList.length;

            commentCount.addAll({diary.diaryId: listLength});
            // 원하는 작업 수행
          }).catchError((error) {
            print('Error getting commentList: $error');
          });
        }
        // formattedDate와 같은 날짜의 일기만 필터링
        selectedEmotionDiaries = diaries
            .where((diary) =>
        DateFormat('yyyy년 MM월 dd일').format(diary.date) == formattedDate)
            .toList();
      });
    } catch (error) {
      // 에러 제어하는 부분
      print('Error getting share diaries list: $error');
    }
  }

  @override
  void initState() {
    super.initState();


    favoriteCounts = favoriteMap[diaryId]!.favoriteCount;
    sfavoritColor = favoriteMap[diaryId]!.favoriteColor;

    print("imagepath = ${imagePath}");
    print("init state 좋아요 카운트: $favoriteCounts");
  }



  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(microseconds: 500)); // Add a delay of 0.5 seconds
    print("commentCount: ${commentCount[diaryId]}");
    print("otherUserId: ${userId}");

    print("실행되는 감정 path: ${imagePath}");

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 380,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Container(
                  width: 380,
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  if (userId !=  LoginedUserInfo.loginedUserInfo.id) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => otherMypage(
                                          userId: userId,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => mypage(
                                          userId: userId,
                                        ),
                                      ),
                                    );
                                  }
                                  print('감정 탭하기');
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  margin: EdgeInsets.only(left: 50),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(widget.simagePath),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ))),
                      IconButton(
                        onPressed: () async {

                          if (userId !=  LoginedUserInfo.loginedUserInfo.id) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    message_write(otherUserId: userId),
                              ),
                            );
                          }
                        },
                        icon: userId !=  LoginedUserInfo.loginedUserInfo.id
                            ? Image.asset(
                                'images/send/real_send.png',
                                height: 50, // 이미지 높이 조절
                                width: 30, // 이미지 너비 조절
                              )
                            : Container(),
                      ),
                    ],
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
                          style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ],
            ),
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        fetchDataFromServer();
                        apiManager.putFavoriteCount(diaryId);
                        print("좋아요 누름 :${diaryId}");
                        try {
                          setState(() {
                            if (sfavoritColor) {
                              favoriteCounts = favoriteCounts - 1;
                            } else {
                              favoriteCounts = favoriteCounts + 1;
                            }
                            sfavoritColor = !sfavoritColor;
                          });
                        } catch (error) {
                          print('Error updating favorite count: $error');
                        }
                      },
                      child: Icon(
                        Icons.favorite,
                        color: sfavoritColor ? Colors.red : Colors.grey,
                      ),
                    ),
                    Text(
                      '${favoriteCounts}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),

              //댓글
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        plusDialog(context);
                      },
                      child: Icon(Icons.chat_outlined, color: Colors.grey),
                    ),
                    Text(
                      '${commentCount[diaryId]}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

// 일기 버전 3 - 텍스트 + 음성
class customwidget3 extends StatefulWidget {
  final String simagePath;
  final String scomment;
  final int sfavoritCount;
  final bool sfavoritColor;
  final String svoice;
  final int otherUserId;
  final int diaryId;
  final int scommentCount;

  const customwidget3({
    super.key,
    required this.simagePath,
    required this.scomment,
    required this.sfavoritColor,
    required this.sfavoritCount,
    required this.svoice,
    required this.otherUserId,
    required this.diaryId,
    required this.scommentCount,
  });

  @override
  State<customwidget3> createState() =>
      _customwidget3State(otherUserId, diaryId);
}

class _customwidget3State extends State<customwidget3> {
  final List<Comment> comments = []; // 댓글을 관리하는 리스트

  int favoriteCounts = 0; // 추가된 부분
  int otherUserId = 36;
  bool sfavoritColor = false;
  int userId = -1;
  String imagePath = "";
  int diaryId = 0;


  ApiManager apiManager = ApiManager().getApiManager();

  _customwidget3State(int otherUserId, int diaryId) {
    this.userId = otherUserId;
    this.diaryId = diaryId;
  }

  void plusDialog(BuildContext context) {
    final sizeY = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            height: sizeY * 0.8,
            color: Color(0xFF737373),
            //child: comment(),
          ),
        );
      },
    );
  }

  //재생에 필요한 것들
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;


  @override
  void initState() {
    super.initState();

    favoriteCounts = favoriteMap[diaryId]!.favoriteCount;
    sfavoritColor = favoriteMap[diaryId]!.favoriteColor;

    print("init state 좋아요 카운트: $favoriteCounts");

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

      print('오디오 재생 시작: $widget.svoice');
      print("duration: $duration");
    } catch (e) {
      print("audioPath : $widget.svoice");
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
    print("commentCount: ${commentCount[diaryId]}");

    print("otherUserId: ${userId}");

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 380,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Container(
                  width: 380,
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => otherMypage(
                                        userId: userId,
                                      ),
                                    ),
                                  );
                                  print('감정 탭하기');
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  margin: EdgeInsets.only(left: 50),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(imagePath),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ))),
                      IconButton(
                        onPressed: () {
                          if (userId != LoginedUserInfo.loginedUserInfo.id) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    message_write(otherUserId: userId),
                              ),
                            );
                          }
                        },
                        icon: userId != LoginedUserInfo.loginedUserInfo.id
                            ? Image.asset(
                                'images/send/real_send.png',
                                height: 50, // 이미지 높이 조절
                                width: 30, // 이미지 너비 조절
                              )
                            : Container(), // userId가 36이면 빈 컨테이너 반환
                      ),
                    ],
                  ),
                ),
                //녹음
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  isPlaying ? Icons.pause : Icons.play_arrow,
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
                                    await audioPlayer.resume(); // 녹음된 오디오 재생
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
                //텍스트
                Container(
                    width: 380,
                    padding: const EdgeInsets.fromLTRB(35, 20, 35, 10),
                    color: Colors.white54,
                    child: Column(
                      children: [
                        Text(
                          widget.scomment,
                          style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ],
            ),
          ),
          //좋아요,댓글
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        apiManager.putFavoriteCount(diaryId);
                        print("좋아요 누름 :${diaryId}");
                        try {
                          setState(() {
                            if (sfavoritColor) {
                              favoriteCounts = favoriteCounts - 1;
                            } else {
                              favoriteCounts = favoriteCounts + 1;
                            }
                            sfavoritColor = !sfavoritColor;
                          });
                        } catch (error) {
                          print('Error updating favorite count: $error');
                        }
                      },
                      child: Icon(
                        Icons.favorite,
                        color: sfavoritColor ? Colors.red : Colors.grey,
                      ),
                    ),
                    Text(
                      '${favoriteCounts}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),

              //댓글
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        plusDialog(context);
                        Future.delayed(Duration(seconds: 4), () {
                          print(commentList.length);
                        });
                      },
                      child: Icon(Icons.chat_outlined, color: Colors.grey),
                    ),
                    Text(
                      '${commentCount[diaryId]}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

// 일기 버전4 - 텍스트 + 음성 + 사진
class customwidget4 extends StatefulWidget {
  final List<String>? sdiaryImage; // 다이어리 안에 이미지
  final String simagePath; // 감정 이모지 사진
  final String scomment; // 일기 내용
  final int sfavoritCount; // 좋아요 수
  final bool sfavoritColor; // 좋아요 색 변하는 거
  final String svoice; // 녹음 기능
  final int otherUserId;
  final int diaryId;
  final int scommentCount;

  const customwidget4({
    super.key,
    required this.sdiaryImage,
    required this.simagePath,
    required this.scomment,
    required this.sfavoritColor,
    required this.sfavoritCount,
    required this.svoice,
    required this.otherUserId,
    required this.diaryId,
    required this.scommentCount,
  });

  @override
  State<customwidget4> createState() =>
      _customwidget4State(otherUserId, diaryId);
}

class _customwidget4State extends State<customwidget4> {
  int favoriteCounts = 0;
  bool sfavoritColor = false;
  int userId = -1;
  int otherUserId = 36;
  int diaryId = 0;


  ApiManager apiManager = ApiManager().getApiManager();

  _customwidget4State(int otherUserId, int diaryId) {
    this.otherUserId = otherUserId;
    this.userId = diaryId;
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
            child: comment(postId: diaryId),
          ),
        );
      },
    );
  }

  //재생에 필요한 것들
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String imagePath = "";

  @override
  void initState() {
    super.initState();

    favoriteCounts = favoriteMap[diaryId]!.favoriteCount;
    sfavoritColor = favoriteMap[diaryId]!.favoriteColor;

    print("init state 좋아요 카운트: $favoriteCounts");

    playAudio();
    //마이크 권한 요청, 녹음 초기화

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

      print('오디오 재생 시작: $widget.svoice');
      print("duration: $duration");
    } catch (e) {
      print("audioPath : $widget.svoice");
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
    print("commentCount: ${commentCount[diaryId]}");

    print("otherUserId: ${userId}");

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 380,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Container(
                  width: 380,
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                              alignment: Alignment.center,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => otherMypage(
                                        userId: userId,
                                      ),
                                    ),
                                  );
                                  print('감정 탭하기');
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  margin: EdgeInsets.only(left: 50),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(imagePath),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ))),
                      IconButton(
                        onPressed: () {
                          if (userId != LoginedUserInfo.loginedUserInfo.id) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    message_write(otherUserId: userId),
                              ),
                            );
                          }
                        },
                        icon: userId != LoginedUserInfo.loginedUserInfo.id
                            ? Image.asset(
                                'images/send/real_send.png',
                                height: 50, // 이미지 높이 조절
                                width: 30, // 이미지 너비 조절
                              )
                            : Container(), // userId가 36이면 빈 컨테이너 반환
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    width: 200,
                    height: 150, // 이미지 높이 조절
                    child: Container(
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.sdiaryImage!.length > 3
                            ? 3
                            : widget.sdiaryImage?.length, // 최대 3장까지만 허용
                        itemBuilder: (context, index) {
                          print('일기 사진 : ${widget.sdiaryImage?[index]}');
                          return Container(
                            child: Center(
                              child: Image.network(widget.sdiaryImage![index]),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  isPlaying ? Icons.pause : Icons.play_arrow,
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
                                    await audioPlayer.resume(); // 녹음된 오디오 재생
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
                //텍스트
                Container(
                    width: 380,
                    padding: const EdgeInsets.fromLTRB(35, 20, 35, 10),
                    color: Colors.white54,
                    child: Column(
                      children: [
                        Text(
                          widget.scomment,
                          style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ],
            ),
          ),
          //좋아요,댓글
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        apiManager.putFavoriteCount(diaryId);
                        print("좋아요 누름 :${diaryId}");
                        try {
                          setState(() {
                            if (sfavoritColor) {
                              favoriteCounts = favoriteCounts - 1;
                            } else {
                              favoriteCounts = favoriteCounts + 1;
                            }
                            sfavoritColor = !sfavoritColor;
                          });
                        } catch (error) {
                          print('Error updating favorite count: $error');
                        }
                      },
                      child: Icon(
                        Icons.favorite,
                        color: sfavoritColor ? Colors.red : Colors.grey,
                      ),
                    ),
                    Text(
                      '${favoriteCounts}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),

              //댓글
              Container(
                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        plusDialog(context);
                        Future.delayed(Duration(seconds: 4), () {
                          print(commentList.length);
                        });
                      },
                      child: Icon(Icons.chat_outlined, color: Colors.grey),
                    ),
                    Text(
                      '${commentCount[diaryId]}',
                      style: TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
