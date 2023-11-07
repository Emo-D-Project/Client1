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

TextEditingController _diaryController =
    TextEditingController(text: '오늘 하루 아주 만족스러운 날이다. '
        '친구들이랑 맛있게 밥도 먹고'
        ' 하늘도 너무 이뻤다!'
        ' 스크롤 보고싶은ㄷ에에ㅔ에에에에에에에에에에엥에에에에에에에에에에'
        ' 스크롤 보고싶은ㄷ에에ㅔ에에에에에에에에에에엥에에에에에에에에에에'
        ' 스크롤 보고싶은ㄷ에에ㅔ에에에에에에에에에에엥에에에에에에에에에에'
        ' 스크롤 보고싶은ㄷ에에ㅔ에에에에에에에에에에엥에에에에에에에에에에'
        ' 스크롤 보고싶은ㄷ에에ㅔ에에에에에에에에에에엥에에에에에에에에에에'
        ' 스크롤 보고싶은ㄷ에에ㅔ에에에에에에에에에에엥에에에에에에에에에에'
        ' 스크롤 보고싶은ㄷ에에ㅔ에에에에에에에에에에엥에에에에에에에에에에'
        ' 스크롤 보고싶은ㄷ에에ㅔ에에에에에에에에에에엥에에에에에에에에에에');

class diaryUpdate extends StatefulWidget {
  const diaryUpdate({super.key, required this.date});

  final String date;
  final String emotion = "smile";

  @override
  State<diaryUpdate> createState() => _diaryUpdateState();
}

class _diaryUpdateState extends State<diaryUpdate> {
  bool _isChecked = false;
  bool _isCheckedShare = false;

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

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFFF8F5EB),
        title: Container(
          //decoration: BoxDecoration(color: Colors.amber),
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
                  'images/emotion/3.gif',
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
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.upload))],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8F5EB),
        ),
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
                    margin: EdgeInsets.fromLTRB(0,11,250,10),
                    child: Text(
                      '     ${widget.date}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ), //날짜
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            child: SizedBox(
                              width: 200,
                              height: 150, // 이미지 높이 조절
                              child: PageView(
                                scrollDirection: Axis.horizontal, // 수평으로 스크롤
                                children: <Widget>[
                                  SizedBox(
                                    child: Center(
                                        child:
                                            Image.asset('images/send/sj3.jpg')),
                                  ),
                                  SizedBox(
                                    child: Center(
                                        child:
                                            Image.asset('images/send/sj1.jpg')),
                                  ),
                                  SizedBox(
                                    child: Center(
                                        child:
                                            Image.asset('images/send/sj2.jpg')),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                      icon: Icon(
                                        isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                      ),
                                      iconSize: 20,
                                      onPressed: () async {
                                        if (isPlaying) {
                                          await audioPlayer.pause();
                                        } else {
                                          await audioPlayer.resume();
                                        }
                                      },
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Slider(
                                        min: 0,
                                        max: duration.inSeconds.toDouble(),
                                        value: position.inSeconds.toDouble(),
                                        onChanged: (value) async {
                                          final position =
                                              Duration(seconds: value.toInt());
                                          await audioPlayer.seek(position);

                                          await audioPlayer.resume();
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(formatTime(position)),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(formatTime(
                                                duration - position)),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                          ), //음성
                          Container(
                            margin: EdgeInsets.fromLTRB(11, 10,11,10),
                              color: Colors.white54,
                              child: TextFormField(
                                controller: _diaryController,
                                maxLines: 30,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                        )
                                    )
                                ),
                              ),
                          ),
                        ],
                      ),
                    ),
                  ), //글
                  //수정버튼
                ],
              )),
        ),
      ),
    );
  }
}
