import 'package:capston1/diaryshare.dart';
import 'package:capston1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'diaryUpdate.dart';
import 'models/Diary.dart';
import 'network/api_manager.dart';


String diaryimage = 'images/send/sj3.jpg';
String voice = "yes";
String diarycomment = '하 힘들다';
DateTime date = DateTime(2023,10,25);

final List<String> d_imagePaths = [
  'images/send/sj3.jpg',
  'images/send/sj1.jpg',
  //'images/send/sj2.jpg',
];

class DiaryEntry {
  final DateTime date;

  // Add other fields as needed

  DiaryEntry({required this.date /* Add other parameters */
      });
}

// final diarydate = DateTime(2023, 11, 24);
// final List<String> diaryimage = [
//   'images/send/sj3.jpg',
//   'images/send/sj1.jpg',
//   'images/send/sj2.jpg'
// ];
// final comment = "오늘 하루 아주 만족스러운 날이다. 친구들이랑 맛있게 밥도 먹고 하늘도 너무 이뻤다!";

class diaryReplay extends StatefulWidget {
  const diaryReplay({super.key, required this.date});

  final DateTime date;
  final String emotion = "smile";

  @override
  State<diaryReplay> createState() => _writediaryState();
}

/*
final picker = ImagePicker();
List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수
*/
class _writediaryState extends State<diaryReplay> {
  // ApiManager apiManager = ApiManager().getApiManager();
  //
  // late bool _isChecked = false;
  // late bool _isCheckedShare = false;
  // late DateTime day;
  //
  // List<Diary> _diaryEntries = [];
  //
  // Future<void> fetchDataFromServer() async {
  //   try {
  //     final diary_data = await apiManager.getDiaryData();
  //
  //     setState(() {
  //       _diaryEntries = diary_data!;
  //     });
  //   } catch (error) {
  //     print('Error fetching data: $error');
  //   }
  // }

  //재생에 필요한 것들
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

    //fetchDataFromServer();

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

  @override
  Widget build(BuildContext context) {
    //Diary diary = getDiaryForDate(DateTime(day.year, da));
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFFF8F5EB),
        title: Container(
          child: (() {
            switch (widget.emotion) {
              case 'smile':
                return Image.asset(
                  'images/emotion/1.gif',
                  height: 50,
                  width: 50,
                );
              case 'flutter':
                return Image.asset(
                  'images/emotion/2.gif',
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
                  'images/emotion/4.gif',
                  height: 50,
                  width: 50,
                );
              case 'tired':
                return Image.asset(
                  'images/emotion/5.gif',
                  height: 50,
                  width: 50,
                );
              case 'sad':
                return Image.asset(
                  'images/emotion/6.gif',
                  height: 50,
                  width: 50,
                );
              case 'calmness':
                return Image.asset(
                  'images/emotion/7.gif',
                  height: 50,
                  width: 50,
                );
            }
          })(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8F5EB),
        ),
        padding : EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Expanded(
          child: () {
                    if (diaryimage != "noimage" &&
                        voice == "no") {
                      return customWidget1(
                          sdate: date,
                          sdiaryImage: diaryimage,
                          scomment: diarycomment
                      );
                    } else if (diaryimage == "noimage" &&
                        voice == "no") {
                      return customWidget2(
                        sdate: date,
                        scomment: diarycomment,
                      );
                    } else if (diaryimage == "noimage" &&
                        voice == "yes") {
                      return customwidget3(
                        sdate: date,
                        scomment: diarycomment,
                        svoice: voice,
                      );
                    } else if (diaryimage != "noimage" &&
                        voice == "yes") {
                      return customwidget4(
                        sdate: date,
                        sdiaryImage: diaryimage,
                        scomment: diarycomment,
                        svoice: voice,
                      );
                    }
               else {
                // 선택된 이미지에 해당하는 일기가 없을 경우 빈 컨테이너 반환
                return Container();
              }
    }(),
    ),
      ),
    );
  }

  // Diary getDiaryForDate(DateTime date) {
  //   // 주어진 날짜의 연, 월, 일을 추출합니다
  //   int year = date.year;
  //   int month = date.month;
  //   int day = date.day;
  //   // 일치하는 날짜 구성 요소를 가진 일기 항목 찾기
  //   return _diaryEntries.firstWhere(
  //     (entry) =>
  //         entry.date.year == year &&
  //         entry.date.month == month &&
  //         entry.date.day == day,
  //     orElse: () => Diary(
  //         date: DateTime(year, month, day),
  //         content: '',
  //         emotion: ''), // 기본 값으로 빈 일기 생성
  //   );
  // }
}


//음성 데이터 추가해야함
class shareData {
  final DateTime date;
  final String diaryImage;
  final String diarycomment;
  final String voice;

  shareData({
    required this.date,
    required this.diaryImage,
    required this.diarycomment,
    required this.voice,
  });
}

// 일기 버전 1 - 텍스트 + 사진
class customWidget1 extends StatefulWidget {
  final DateTime sdate;
  final String sdiaryImage;
  final String scomment;

  const customWidget1({
    super.key,
    required this.sdate,
    required this.sdiaryImage,
    required this.scomment,
  });

  @override
  State<customWidget1> createState() => _customWidget1State();
}

class _customWidget1State extends State<customWidget1> {

//-----------------------
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Center(
          child: Container(
              width: sizeX * 0.9,
              height: sizeY * 0.8,
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
                        width: 135,
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => diaryUpdate(
                      //                   date: DateTime(2023, 11, 24))));
                      //     },
                      //     icon: Icon(
                      //       Icons.edit,
                      //       size: 30,
                      //     )),
                    ]),
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
                              width: 380,
                              padding:
                              const EdgeInsets.fromLTRB(35, 10, 35, 10),
                              color: Colors.white54,
                              child: Column(
                                children: [
                                  Text(
                                    widget.scomment,
                                    style: TextStyle(
                                        fontFamily: 'soojin', fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ), //글
                  //수정버튼
                ],
              )),
        ),
    );
  }
}

//글만 있는 거
class customWidget2 extends StatefulWidget {
  final String scomment;
  final DateTime sdate;

  const customWidget2({
    super.key,
    required this.scomment,
    required this.sdate,
  });

  @override
  State<customWidget2> createState() => _customWidget2State();
}

class _customWidget2State extends State<customWidget2> {
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Center(
          child: Container(
              width: sizeX * 0.9,
              height: sizeY * 0.8,
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
                        width: 135,
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => diaryUpdate(
                      //                   date: DateTime(2023, 11, 24))));
                      //     },
                      //     icon: Icon(
                      //       Icons.edit,
                      //       size: 30,
                      //     )),
                    ]),
                  ), //날짜
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                              width: 380,
                              padding:
                              const EdgeInsets.fromLTRB(35, 10, 35, 10),
                              color: Colors.white54,
                              child: Column(
                                children: [
                                  Text(
                                    widget.scomment,
                                    style: TextStyle(
                                        fontFamily: 'soojin', fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),

                    ),
                  ), //글
                  //수정버튼
                ],
              )),
        ),
    );
  }
}

// 일기 버전 3 - 텍스트 + 음성
class customwidget3 extends StatefulWidget {
  final String scomment;
  final String svoice;
  final DateTime sdate;

  const customwidget3({
    super.key,
    required this.scomment,
    required this.svoice,
    required this.sdate,
  });

  @override
  State<customwidget3> createState() => _customwidget3State();
}

class _customwidget3State extends State<customwidget3> {

  //재생에 필요한 것들
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

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
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Center(
          child: Container(
              width: sizeX * 0.9,
              height: sizeY * 0.8,
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
                        width: 135,
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => diaryUpdate(
                      //                   date: DateTime(2023, 11, 24))));
                      //     },
                      //     icon: Icon(
                      //       Icons.edit,
                      //       size: 30,
                      //     )),
                    ]),
                  ), //날짜
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
                                      final position =
                                      Duration(seconds: value.toInt());
                                      await audioPlayer.seek(position);
                                      await audioPlayer.resume();
                                    },
                                    activeColor: Color(0xFF968C83),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatTime(position), // 진행중인 시간
                                        style: TextStyle(
                                            fontFamily: 'soojin',
                                            color: Colors
                                                .brown), // Set text color to black
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
                                            isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
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
                                          fontFamily: 'soojin',
                                          color: Colors.brown,
                                        ), // Set text color to black
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ), //음성
                          Container(
                              width: 380,
                              padding:
                              const EdgeInsets.fromLTRB(35, 10, 35, 10),
                              color: Colors.white54,
                              child: Column(
                                children: [
                                  Text(
                                    widget.scomment,
                                    style: TextStyle(
                                        fontFamily: 'soojin', fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ), //글
                  //수정버튼
                ],
              )),
        ),
    );
  }
}

// 일기 버전4 - 텍스트 + 음성 + 사진
class customwidget4 extends StatefulWidget {
  final String sdiaryImage; // 다이어리 안에 이미지
  final String scomment; // 일기 내용
  final String svoice; // 녹음 기능
  final DateTime sdate;

  const customwidget4({
    super.key,
    required this.sdiaryImage,
    required this.scomment,
    required this.svoice,
    required this.sdate,
  });

  @override
  State<customwidget4> createState() => _customwidget4State();
}

class _customwidget4State extends State<customwidget4> {
  //재생에 필요한 것들
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();

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
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Center(
          child: Container(
              width: sizeX * 0.9,
              height: sizeY * 0.8,
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
                        width: 135,
                      ),
                      // IconButton(
                      //     onPressed: () {
                      //       Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //               builder: (context) => diaryUpdate(
                      //                   date: DateTime(2023, 11, 24))));
                      //     },
                      //     icon: Icon(
                      //       Icons.edit,
                      //       size: 30,
                      //     )),
                    ]),
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
                                SliderTheme(
                                  data: SliderThemeData(
                                    inactiveTrackColor: Color(0xFFF8F5EB),
                                  ),
                                  child: Slider(
                                    min: 0,
                                    max: duration.inSeconds.toDouble(),
                                    value: position.inSeconds.toDouble(),
                                    onChanged: (value) async {
                                      final position =
                                      Duration(seconds: value.toInt());
                                      await audioPlayer.seek(position);
                                      await audioPlayer.resume();
                                    },
                                    activeColor: Color(0xFF968C83),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        formatTime(position), // 진행중인 시간
                                        style: TextStyle(
                                            fontFamily: 'soojin',
                                            color: Colors
                                                .brown), // Set text color to black
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
                                            isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
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
                                          fontFamily: 'soojin',
                                          color: Colors.brown,
                                        ), // Set text color to black
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ), //음성
                          Container(
                              width: 380,
                              padding:
                              const EdgeInsets.fromLTRB(35, 10, 35, 10),
                              color: Colors.white54,
                              child: Column(
                                children: [
                                  Text(
                                    widget.scomment,
                                    style: TextStyle(
                                        fontFamily: 'soojin', fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ), //글
                  //수정버튼
                ],
              )),
        ),
    );
  }
}