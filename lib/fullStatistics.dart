import 'package:capston1/bar%20graph/bar_graph.dart';
import 'package:flutter/material.dart';
import 'statistics.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';
import 'diaryshare.dart';
import 'package:audioplayers/audioplayers.dart';

final DateTime title = DateTime(2023, 3, 22); // 가장 많은 일기의 날짜
final DateTime start = DateTime(2023, 8, 25); //처음 시작한 날
final DateTime many = DateTime(2023, 6); // 몇년 몇월에 일기를 많이 작성한지

final String imagepath = 'images/emotion/1.gif';
final List<String> diaryimage = ['images/send/sj1.jpg','images/send/sj3.jpg','images/send/sj2.jpg','images/send/sj1.jpg'];
final String voice = "yes";
final comment = "오늘 하루 아주 만족스러운 날이다. 친구들이랑 맛있게 밥도 먹고 하늘도 너무 이뻤다!";

//final String start = DateTime.now().toString();
//String formattedDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());

class fullStatistics extends StatefulWidget {
  const fullStatistics({super.key});

  @override
  State<fullStatistics> createState() => _fullStatisticsState();
}

class _fullStatisticsState extends State<fullStatistics> {
  List<double> emotioncount = [159, 150, 100, 80, 50, 40, 5];

//enum으로 바꿔보기
  int num_comment = 25; // 공유된 일기 중 가장 많은 댓글 수
  int num_like = 3; // 공유된 일기 중 가장 많은 좋아요 수
  String name = '수진'; //닉네임

  // 가장 많이 일기를 작성한  시간대
  //
  String Dawn = '새벽(00~06)';
  String morning = '아침(06~12)';
  String Am = '오전(12~18)';
  String Pm = '밤(18~00)';

  // 이때까지 몇개의 일기를 작성한지
  int count = 0; // 맨 처음 시작한 일기는 0으로 시작

  /*
  void writeDiary() {
    setState(() {
      count++; // 다음 일기를 작성하면 1 증가
    });
  }*/

  // 몇월 - 몇개로 가장 많은 일기 수
  int w_diary = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "EMO:D",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'kim',
            color: Color(0xFF968C83),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => statistics()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                    width: 300,
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 7),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                                fontFamily: 'soojin',
                                fontSize: 19,
                                color: Colors.brown,
                                fontWeight: FontWeight.w700),
                            children: [
                              TextSpan(text: '현재까지 쌓인 감정이에요 :D'),
                            ]))),
              ],
            ),
          ),
          // 감정 통계
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        color: Color(0xFF745A52),
                        strokeWidth: 2,
                        radius: Radius.circular(20),
                        dashPattern: [13, 13],
                        child: SizedBox(
                          width: 400,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 250,
                                child: MyBarGraph(
                                  emotioncount: emotioncount,
                                ),
                              ),
                              //감정 이모션 사진
                              Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.3),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'images/emotion/1.gif',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/2.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/angry.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/4.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/5.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/6.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 33,
                                      height: 33,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/7.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    // 작성된 일기 수
                    Container(
                        width: 380,
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFE1DED6),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 300,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'soojin',
                                          fontSize: 18,
                                          color: Colors.brown,

                                        ),
                                        children: [
                                          TextSpan(
                                            text:
                                                '${start.year}년 ${start.month}월 ${start.day}일',
                                          ), //년도
                                          TextSpan(text: '부터 작성 된 일기 수 '),
                                        ]))),
                            Container(
                                width: 300,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'soojin',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.brown,
                                        ),
                                        children: [
                                          TextSpan(text: '$count'),
                                          TextSpan(text: '개'),
                                        ]))),
                          ],
                        )),
                    // 어느 시간대에 일기 가장 많이 쓴 지
                    Container(
                        width: 380,
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFDAD4CC),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                width: 300,
                                padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: name,
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              color: Colors.brown)), //닉네임
                                      TextSpan(
                                          text: ' 님은 ',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                             // fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: Colors.brown)), //
                                      TextSpan(
                                          text: Pm,
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.brown)), //시간
                                      TextSpan(
                                          text: '에',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                             // fontWeight: FontWeight.w500,
                                              fontSize: 18,
                                              color: Colors.brown)),
                                    ]))),
                            Container(
                                width: 300,
                                height: 40,
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'soojin',
                                          fontSize: 18,
                                          color: Colors.brown,
                                        ),
                                        children: [
                                          TextSpan(text: '일기를 가장 많이 작성하였어요 :D'),
                                        ]))),
                          ],
                        )),

                    // 몇월에 일기 가장 많이 작성한지
                    Container(
                        width: 380,
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFDACFC4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // 위아래 중앙 정렬
                          children: [
                            Container(
                                width: 300,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text: '${many.year}년 ${many.month}월',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.brown)),
                                      TextSpan(
                                          text: '에 ',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 18,
                                              color: Colors.brown)),
                                      TextSpan(
                                          text: '$w_diary',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.brown)),
                                      TextSpan(
                                          text: '개로',
                                          style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 18,
                                              color: Colors.brown)),
                                    ]))),
                            Container(
                                width: 300,
                                height: 40,
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        style: TextStyle(
                                          fontFamily: 'soojin',
                                          fontSize: 18,
                                          color: Colors.brown,
                                        ),
                                        children: [
                                          TextSpan(text: '가장 많이 일기를 작성하였어요 :D'),
                                        ]))),
                          ],
                        )),
                    // 가장 많이 공감 받은 일기
                    Container(
                      width: 380,
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFD7D4CC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          // ~ 님의 공유된 일기 중 가장 많은 공감을 얻은 일기에요~
                          Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                    width: 300,
                                    height: 40,
                                    padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                    child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                            children: [
                                              TextSpan(text: name), //닉네임
                                              TextSpan(text: '님의 공유된 일기 중'), //일
                                            ]))),
                                Container(
                                    width: 300,
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                    child: RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                            style: TextStyle(
                                              fontFamily: 'soojin',
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: '가장 많은 공감을 얻은 일기에요 :D'),
                                            ])))
                              ],
                            ),
                          ),

                          // 가장 공감 많이 받은 일기 보여줌
                          Container(
                            child: customWidget3(
                              stitle: title,
                              sdiaryImage: diaryimage[0],
                              simagePath: imagepath,
                              scomment: comment,
                              svoice: voice,
                            ),
                          ),


                          // ~개의 공감과 ~개의 댓글을 받았어요
                          Container(
                              width: 300,
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 10),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: TextStyle(
                                        fontFamily: 'soojin',
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                      children: [
                                        TextSpan(text: '$num_comment'), //댓글
                                        TextSpan(text: '개의 공감과 '), //일
                                        TextSpan(text: '$num_like'), //댓글
                                        TextSpan(text: '개의 댓글을 받았어요'), //일
                                      ]))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class shareData {
  final DateTime many;
  final DateTime start;
  final DateTime title;
  final String imagepath;
  final String diaryimage;
  final String comment;
  final String voice;

  shareData({
    required this.many,
    required this.start,
    required this.title,
    required this.imagepath,
    required this.diaryimage,
    required this.comment,
    required this.voice,
  });
}

// 일기 버전 1 - 텍스트 + 사진
class customWidget1 extends StatefulWidget {
  final DateTime stitle;
  final String simagePath;
  final String sdiaryImage;
  final String scomment;

  const customWidget1({
    super.key,
    required this.stitle,
    required this.simagePath,
    required this.sdiaryImage,
    required this.scomment,
  });

  @override
  State<customWidget1> createState() => _customWidget1State();
}

class _customWidget1State extends State<customWidget1> {
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    '${widget.stitle.year}년 ${widget.stitle.month}월 ${widget.stitle.day}일',
                    style: TextStyle(
                      fontFamily: "soojin",
                      fontSize: 20,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Container(
                  width: 35,
                  height: 55,
                  //  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.simagePath),
                      fit: BoxFit.contain,
                    ),
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
                          itemCount: diaryimage.length > 3
                              ? 3
                              : diaryimage.length, // 최대 3장까지만 허용
                          itemBuilder: (context, index) {
                            return Container(
                              child: Center(
                                child: Image.asset(diaryimage[index]),
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
        ],
      ),
    );
  }
}

// 일기 버전 2 - 텍스트
class customWidget2 extends StatefulWidget {
  final DateTime stitle;
  final String simagePath;
  final String scomment;

  const customWidget2({
    super.key,
    required this.stitle,
    required this.simagePath,
    required this.scomment,
  });

  @override
  State<customWidget2> createState() => _customWidget2State();
}

class _customWidget2State extends State<customWidget2> {
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    '${widget.stitle.year}년 ${widget.stitle.month}월 ${widget.stitle.day}일',
                    style: TextStyle(
                      fontFamily: "soojin",
                      fontSize: 20,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Container(
                  width: 35,
                  height: 55,
                  //  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.simagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                //텍스트
                Container(
                    width: 380,
                    padding: const EdgeInsets.fromLTRB(35, 0, 35, 10),
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
        ],
      ),
    );
  }
}

// 일기 버전 3 - 텍스트 + 음성 + 사진
class customWidget3 extends StatefulWidget {
  final DateTime stitle;
  final String simagePath;
  final String sdiaryImage;
  final String scomment;
  final String svoice;

  const customWidget3({
    super.key,
    required this.stitle,
    required this.simagePath,
    required this.sdiaryImage,
    required this.scomment,
    required this.svoice,
  });

  @override
  State<customWidget3> createState() => _customWidget3State();
}

class _customWidget3State extends State<customWidget3> {
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    '${widget.stitle.year}년 ${widget.stitle.month}월 ${widget.stitle.day}일',
                    style: TextStyle(
                      fontFamily: "soojin",
                      fontSize: 20,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Container(
                  width: 35,
                  height: 55,
                  //  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.simagePath),
                      fit: BoxFit.contain,
                    ),
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
                          itemCount: diaryimage.length > 3
                              ? 3
                              : diaryimage.length, // 최대 3장까지만 허용
                          itemBuilder: (context, index) {
                            return Container(
                              child: Center(
                                child: Image.asset(diaryimage[index]),
                              ),
                            );
                          },
                        ),
                      )),
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
                          widget.scomment,
                          style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 일기 버전 4 - 텍스트 + 음성
class customWidget4 extends StatefulWidget {
  final DateTime stitle;
  final String simagePath;
  final String scomment;
  final String svoice;

  const customWidget4({
    super.key,
    required this.stitle,
    required this.simagePath,
    required this.scomment,
    required this.svoice,
  });

  @override
  State<customWidget4> createState() => _customWidget4State();
}

class _customWidget4State extends State<customWidget4> {
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
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    '${widget.stitle.year}년 ${widget.stitle.month}월 ${widget.stitle.day}일',
                    style: TextStyle(
                      fontFamily: "soojin",
                      fontSize: 20,
                      color: Colors.brown,
                    ),
                  ),
                ),
                Container(
                  width: 35,
                  height: 55,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.simagePath),
                      fit: BoxFit.contain,
                    ),
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
                          widget.scomment,
                          style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
