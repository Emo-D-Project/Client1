import 'dart:core';

import 'package:capston1/alrampage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:capston1/network/api_manager.dart';
import 'comment.dart';
import 'message_write.dart';
import 'package:audioplayers/audioplayers.dart';

import 'models/Comment.dart';
import 'models/Diary.dart';

final List<String> imagepath = [
  'images/emotion/1.gif',
  'images/emotion/7.gif',
  'images/emotion/7.gif',
  'images/emotion/2.gif',
  'images/emotion/4.gif'
];

//맨 위 상단 감정 7개
final List<String> imagePaths = [
  'images/emotion/7.gif',
  'images/emotion/1.gif',
  'images/emotion/2.gif',
  'images/emotion/angry.png',
  'images/emotion/4.gif',
  'images/emotion/5.gif',
  'images/emotion/6.gif',
];

final List<String> d_imagePaths = [
  'images/send/sj3.jpg',
  'images/send/sj1.jpg',
  //'images/send/sj2.jpg',
];
String selectedImagePath =
    'images/emotion/7.gif'; // 기본으로 'images/emotion/7.gif'를 선택

String dynamicText = '행복한 하루입니다람지 제가 잘하고 있는게 맞나요?';

final String start = DateTime.now().toString();
String formattedDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());

//----------------------------------------

class diaryshare extends StatefulWidget {
  diaryshare({Key? key}) : super(key: key);

  @override
  State<diaryshare> createState() => _diaryshareState();
}

class _diaryshareState extends State<diaryshare> {

  ApiManager apiManager = ApiManager().getApiManager();

  List<Diary> diaries = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }


  // 서버로부터 데이터를 가져오는 함수
  Future<void> fetchDataFromServer() async {
    try{
      // 상대방과의 대화나눈 메시지 가져오기
      final data = await apiManager.getDiaryShareData();

      setState(() {
        diaries = data!;
      });
    }
    catch (error) {
      // 에러 제어하는 부분
      print('Error getting share diaries list: $error');
    }
  }


  String selectedValue = '최신순';

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xFFF8F5EB),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 드롭박스
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  value: selectedValue,
                  // 현재 선택된 값
                  items: <String>['최신순', '추천순'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value!; // 선택된 값 업데이트
                    });
                  },
                  underline: Container(
                    height: 2,
                    color: Colors.brown,
                  ),
                  dropdownColor: Color(0xFFF8F5EB),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.brown),
                  style: TextStyle(color: Colors.black,fontFamily: 'soojin'),
                ),
                SizedBox(width: 25),
              ],
            ),
          ),

          //날짜
          Container(
            //   margin: EdgeInsets.fromLTRB(0, 20, 120, 20),
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
                int imagePathIndex = entry.key;
                String imagePath = entry.value;

                // 해당 이미지에 대한 일기 내용을 찾기
                int diaryIndex = imagepath.indexWhere(
                    (diaryImagePath) => diaryImagePath == imagePath);
                return Padding(
                  padding: EdgeInsets.all(3),
                  child: IconButton(
                    icon: Image.asset(
                      imagePath,
                      width: 50,
                      height: 50,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedImagePath = imagePath; // 선택된 이미지의 경로 업데이트
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
              itemCount: imagepath.length,
              itemBuilder: (BuildContext context, int index) {
                // 'images/emotion/7.gif'를 기본으로 선택한 경우 해당 일기 표시
                if (selectedImagePath == imagepath[index]) {
                  return SizedBox(
                    child: (() {
                      if (diaryimage[index] != "noimage" &&
                          voice[index] == "no") {
                        return customWidget1(
                            simagePath: imagepath[index],
                            sdiaryImage: diaryimage[index],
                            scomment: diarycomment[index],
                            sfavoritColor: favoritcolor[index],
                            sfavoritCount: favoritcount[index]);
                      } else if (diaryimage[index] == "noimage" &&
                          voice[index] == "no") {
                        return customWidget2(
                          scomment: diarycomment[index],
                          sfavoritColor: favoritcolor[index],
                          sfavoritCount: favoritcount[index],
                          simagePath: imagepath[index],
                        );
                      } else if (diaryimage[index] == "noimage" &&
                          voice[index] == "yes") {
                        return customwidget3(
                          scomment: diarycomment[index],
                          sfavoritColor: favoritcolor[index],
                          sfavoritCount: favoritcount[index],
                          simagePath: imagepath[index],
                          svoice: voice[index],
                        );
                      } else if (diaryimage[index] != "noimage" &&
                          voice[index] == "yes") {
                        return customwidget4(
                          sdiaryImage: diaryimage[index],
                          scomment: diarycomment[index],
                          sfavoritColor: favoritcolor[index],
                          sfavoritCount: favoritcount[index],
                          simagePath: imagepath[index],
                          svoice: voice[index],
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

class shareData {
  final String imagePath;
  final String diaryImage;
  final String diarycomment;
  final int favoritCount;
  final bool favoritColor;
  final String voice;

  shareData({
    required this.imagePath,
    required this.diaryImage,
    required this.diarycomment,
    required this.favoritColor,
    required this.favoritCount,
    required this.voice,
  });
}

// 일기 버전 1 - 텍스트 + 사진
class customWidget1 extends StatefulWidget {
  final String simagePath;
  final String sdiaryImage;
  final String scomment;
  final int sfavoritCount;
  final bool sfavoritColor;

  const customWidget1({
    super.key,
    required this.simagePath,
    required this.sdiaryImage,
    required this.scomment,
    required this.sfavoritColor,
    required this.sfavoritCount,
  });

  @override
  State<customWidget1> createState() => _customWidget1State();
}

class _customWidget1State extends State<customWidget1> {
  late int sfavoritCount; // 추가된 부분
  late bool sfavoritColor; // 추가된 부분

  void initState() {
    super.initState();
    sfavoritCount = widget.sfavoritCount;
    sfavoritColor = widget.sfavoritColor;
  }

  final List<Comment> comments = []; // 댓글을 관리하는 리스트

  // TextEditingController _commentController = TextEditingController();

  // 댓글 추가 기능 댓글이 쌓이면 숫자 증가함
  int _commentCount = 1;

  void addComment(String name, String text) {
    setState(() {
      comments.add(Comment(
        name: '$name $_commentCount',
        text: text,
      ));
      _commentCount++;
    });
    print('보낸 사람: $name $_commentCount, 전송 메세지: $text');
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
            child: comment(), // 수정이 필요한 부분
          ),
        );
      },
    );
  }

//-----------------------
  @override
  Widget build(BuildContext context) {
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
                      )),
                      /*IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => message_write(otherUserId: ),
                          );
                        },
                        icon: Image.asset(
                          'images/send/real_send.png',
                          height: 50, // 이미지 높이 조절
                          width: 30, // 이미지 너비 조절
                        ),
                      ),*/
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
                          //listview로 하면 한장씩 안넘어가서 페이지뷰함
                          scrollDirection: Axis.horizontal,
                          itemCount: d_imagePaths.length > 3
                              ? 3
                              : d_imagePaths.length, // 최대 3장까지만 허용
                          itemBuilder: (context, index) {
                            return Container(
                              child: Center(
                                child: Image.asset(d_imagePaths[index]),
                              ),
                            );
                          },
                        ),
                      )),
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
                          onTap: () {
                            setState(() {
                              // 좋아요 누를 때 색 변경 및 count 증가
                              if (sfavoritColor) {
                                sfavoritCount--;
                              } else {
                                sfavoritCount++;
                              }
                              sfavoritColor = !sfavoritColor;
                            });
                          },
                          onLongPress: () {},
                          child: Icon(
                            Icons.favorite,
                            color: sfavoritColor ? Colors.red : Colors.grey,
                          ),
                        ),
                        Text(
                          '$sfavoritCount',
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
                    //댓글 숫자
                    Text(
                      '6', //
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

  const customWidget2({
    super.key,
    required this.simagePath,
    required this.scomment,
    required this.sfavoritColor,
    required this.sfavoritCount,
  });

  @override
  State<customWidget2> createState() => _customWidget2State();
}

class _customWidget2State extends State<customWidget2> {
  late int sfavoritCount; // 추가된 부분
  late bool sfavoritColor; // 추가된 부분
  final List<Comment> comments = []; // 댓글을 관리하는 리스트

  TextEditingController _commentController = TextEditingController();

  // 댓글 추가 기능

  // 댓글 추가 기능 댓글이 쌓이면 숫자 증가함
  int _commentCount = 1;

  void addComment(String name, String text) {
    setState(() {
      comments.add(Comment(
        name: '$name $_commentCount',
        text: text,
      ));
      _commentCount++;
    });
    print('보낸 사람: $name $_commentCount, 전송 메세지: $text');
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
            child: comment(),
          ),
        );
      },
    );
  }
  void initState() {
    super.initState();
    sfavoritCount = widget.sfavoritCount; // 초기화
    sfavoritColor = widget.sfavoritColor; // 초기화
  }

  @override
  Widget build(BuildContext context) {
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
                      )),
                    /*  IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => message_write()),
                          );
                        },
                        icon: Image.asset(
                          'images/send/real_send.png',
                          height: 50, // 이미지 높이 조절
                          width: 30, // 이미지 너비 조절
                        ),
                      ),*/
                    ],
                  ),
                ),
                //텍스트
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
                          onTap: () {
                            setState(() {
                              // 좋아요 누를 때 색 변경 및 count 증가
                              if (sfavoritColor) {
                                sfavoritCount--;
                              } else {
                                sfavoritCount++;
                              }
                              sfavoritColor = !sfavoritColor;
                            });
                          },
                          onLongPress: () {},
                          child: Icon(
                            Icons.favorite,
                            color: sfavoritColor ? Colors.red : Colors.grey,
                          ),
                        ),
                        Text(
                          '$sfavoritCount',
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
                    //댓글 숫자
                    Text(
                      '6', //
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

  const customwidget3({
    super.key,
    required this.simagePath,
    required this.scomment,
    required this.sfavoritColor,
    required this.sfavoritCount,
    required this.svoice,
  });

  @override
  State<customwidget3> createState() => _customwidget3State();
}

class _customwidget3State extends State<customwidget3> {
  final List<Comment> comments = []; // 댓글을 관리하는 리스트

  TextEditingController _commentController = TextEditingController();

  late int sfavoritCount; // 추가된 부분
  late bool sfavoritColor; // 추가된 부분


  // 댓글 추가 기능 댓글이 쌓이면 숫자 증가함
  int _commentCount = 1;

  void addComment(String name, String text) {
    setState(() {
      comments.add(Comment(
        name: '$name $_commentCount',
        text: text,
      ));
      _commentCount++;
    });
    print('보낸 사람: $name $_commentCount, 전송 메세지: $text');
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
            child: comment(),
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
    sfavoritCount = widget.sfavoritCount; // 초기화
    sfavoritColor = widget.sfavoritColor; // 초기화

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == (PlayerState.playing);
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    String url = ' ';
    audioPlayer.setSourceUrl(url);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inMinutes.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

//-----------------------
  @override
  Widget build(BuildContext context) {
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
                      )),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'images/send/real_send.png',
                          height: 50, // 이미지 높이 조절
                          width: 30, // 이미지 너비 조절
                        ),
                      ),
                    ],
                  ),
                ),
                //녹음
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Column(
                    children: [
                      Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) async {
                          final position = Duration(seconds: value.toInt());
                          await audioPlayer.seek(position);
                          await audioPlayer.resume();
                        },
                        activeColor: Color(0xFFF8F5EB),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatTime(position), // 진행중인 시간
                              style: TextStyle(
                                  color:
                                      Colors.brown), // Set text color to black
                            ),
                            SizedBox(
                              width: 20,
                            ),
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
                                  if (isPlaying) {
                                    await audioPlayer.pause();
                                  } else {
                                    await audioPlayer.resume();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              formatTime(duration), //총 시간
                              style: TextStyle(
                                color: Colors.brown,
                              ), // Set text color to black
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
                          dynamicText,
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
                          onTap: () {
                            setState(() {
                              // 좋아요 누를 때 색 변경 및 count 증가
                              if (sfavoritColor) {
                                sfavoritCount--;
                              } else {
                                sfavoritCount++;
                              }
                              sfavoritColor = !sfavoritColor;
                            });
                          },
                          onLongPress: () {},
                          child: Icon(
                            Icons.favorite,
                            color: sfavoritColor ? Colors.red : Colors.grey,
                          ),
                        ),
                        Text(
                          '$sfavoritCount',
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
                    //댓글 숫자
                    Text(
                      '6', //
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
  final String sdiaryImage; // 다이어리 안에 이미지
  final String simagePath; // 감정 이모지 사진
  final String scomment; // 일기 내용
  final int sfavoritCount; // 좋아요 수
  final bool sfavoritColor; // 좋아요 색 변하는 거
  final String svoice; // 녹음 기능

  const customwidget4({
    super.key,
    required this.sdiaryImage,
    required this.simagePath,
    required this.scomment,
    required this.sfavoritColor,
    required this.sfavoritCount,
    required this.svoice,
  });

  @override
  State<customwidget4> createState() => _customwidget4State();
}

class _customwidget4State extends State<customwidget4> {
  late int sfavoritCount;
  late bool sfavoritColor; // 추가된 부분

  final List<Comment> comments = []; // 댓글을 관리하는 리스트

  TextEditingController _commentController = TextEditingController();

  // 댓글 추가 기능

  // 댓글 추가 기능 댓글이 쌓이면 숫자 증가함
  int _commentCount = 1;

  void addComment(String name, String text) {
    setState(() {
      comments.add(Comment(
        name: '$name $_commentCount',
        text: text,
      ));
      _commentCount++;
    });
    print('보낸 사람: $name $_commentCount, 전송 메세지: $text');
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
            child: comment(),
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
    sfavoritCount = widget.sfavoritCount; // 초기화
    sfavoritColor = widget.sfavoritColor; // 초기화

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == (PlayerState.playing);
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    String url = ' ';
    audioPlayer.setSourceUrl(url);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inMinutes.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

//-----------------------
  @override
  Widget build(BuildContext context) {
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
                      )),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'images/send/real_send.png',
                          height: 50, // 이미지 높이 조절
                          width: 30, // 이미지 너비 조절
                        ),
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
                          //listview로 하면 한장씩 안넘어가서 페이지뷰함
                          scrollDirection: Axis.horizontal,
                          itemCount: d_imagePaths.length > 3
                              ? 3
                              : d_imagePaths.length, // 최대 3장까지만 허용
                          itemBuilder: (context, index) {
                            return Container(
                              child: Center(
                                child: Image.asset(d_imagePaths[index]),
                              ),
                            );
                          },
                        ),
                      )),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Column(
                    children: [
                      Slider(
                        min: 0,
                        max: duration.inSeconds.toDouble(),
                        value: position.inSeconds.toDouble(),
                        onChanged: (value) async {
                          final position = Duration(seconds: value.toInt());
                          await audioPlayer.seek(position);
                          await audioPlayer.resume();
                        },
                        activeColor: Color(0xFFF8F5EB),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatTime(position), // 진행중인 시간
                              style: TextStyle(
                                  color:
                                      Colors.brown), // Set text color to black
                            ),
                            SizedBox(
                              width: 20,
                            ),
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
                                  if (isPlaying) {
                                    await audioPlayer.pause();
                                  } else {
                                    await audioPlayer.resume();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              formatTime(duration), //총 시간
                              style: TextStyle(
                                color: Colors.brown,
                              ), // Set text color to black
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
                          dynamicText,
                          style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ],
            ),
          ),

          //좋아요,댓글
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
                          onTap: () {
                            setState(() {
                              // 좋아요 누를 때 색 변경 및 count 증가
                              if (sfavoritColor) {
                                sfavoritCount--;
                              } else {
                                sfavoritCount++;
                              }
                              sfavoritColor = !sfavoritColor;
                            });
                          },
                          onLongPress: () {},
                          child: Icon(
                            Icons.favorite,
                            color: sfavoritColor ? Colors.red : Colors.grey,
                          ),
                        ),
                        Text(
                          '$sfavoritCount',
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
                    //댓글 숫자
                    Text(
                      '6', //
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
