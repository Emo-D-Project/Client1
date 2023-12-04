import 'package:capston1/bar%20graph/bar_graph.dart';
import 'package:flutter/material.dart';
import 'models/Diary.dart';
import 'statistics.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:audioplayers/audioplayers.dart';
import 'network/api_manager.dart';
import 'models/TotalData.dart';

final String imagepath = 'images/emotion/smile.gif';
final List<String> diaryimage = [
  'images/send/sj1.jpg',
  'images/send/sj3.jpg',
  'images/send/sj2.jpg',
  'images/send/sj1.jpg'
];

class fullStatistics extends StatefulWidget {
  const fullStatistics({super.key});

  @override
  State<fullStatistics> createState() => _fullStatisticsState();
}

class _fullStatisticsState extends State<fullStatistics> {
  ApiManager apiManager = ApiManager().getApiManager();

  TotalData? totalDatas;
  List<Diary> diaries = [];
  Diary? mostLikedDiary;

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getTSatisData();
      setState(() {
        totalDatas = data;
      });
        } catch (error) {
      // 오류 처리
      print('Error getting TS list: $error');
    }
  }

  Future<void> fetchDataFromServerDiary() async {
    try {
      final data = await apiManager.getDiaryShareData();

      setState(() {
        diaries = data; // 데이터가 null인 경우 빈 리스트로 초기화

        // totalDatas에서 가장 많은 좋아요를 받은 일기의 아이디
        int? mostLikedDiaryId = totalDatas?.mostViewed;

        // 해당 아이디를 가진 일기만 필터링하여 받아옴
        mostLikedDiary = diaries.firstWhere(
              (diary) => diary.diaryId == mostLikedDiaryId,
          orElse: () => Diary(
            date: DateTime.now(),
            content: '',
            emotion: 'calmness', // 기본 감정 설정
          ),
        );
        print("diaryID : ${mostLikedDiary?.diaryId}");
      });
    } catch (error) {
      // 에러 처리
      print('Error getting share diaries list: $error');
    }
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
    playAudio();
    fetchDataFromServer();

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

      await audioPlayer.setSourceDeviceFile(mostLikedDiary!.voice);
      print("duration: $duration" );
      await Future.delayed(Duration(seconds: 2));
      print("after wait duration: $duration" );

      setState(() {
        duration = duration;
        isPlaying = true;
      });

      audioPlayer.play;

      print('오디오 재생 시작: ${mostLikedDiary?.voice}');
      print("duration: $duration");
    } catch (e) {
      print("audioPath : ${mostLikedDiary?.voice}");
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
      body: SizedBox(
        child: totalDatas != null
            ? Column(
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
                                  child: totalDatas != null
                                      ? MyBarGraph(
                                      emotioncount: totalDatas!.emotions)
                                      : Container(),
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
                                              'images/emotion/smile.gif',
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 33,
                                        height: 33,
                                        margin: const EdgeInsets.all(6.5),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/emotion/flutter.gif'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
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
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 33,
                                        height: 33,
                                        margin: const EdgeInsets.all(6.5),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/emotion/annoying.gif'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 33,
                                        height: 33,
                                        margin: const EdgeInsets.all(6.5),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/emotion/tired.gif'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 33,
                                        height: 33,
                                        margin: const EdgeInsets.all(6.5),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/emotion/sad.gif'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        width: 33,
                                        height: 33,
                                        margin: const EdgeInsets.all(6.5),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/emotion/calmness.gif'),
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
                                              text: totalDatas != null
                                                  ? '${totalDatas!.firstDate.year}년 ${totalDatas!.firstDate.month}월 ${totalDatas!.firstDate.day}일'
                                                  : "",
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
                                            TextSpan(
                                                text: totalDatas != null
                                                    ? '${totalDatas!.nums}'
                                                    : ""),
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
                                            text: '수진',
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
                                            text: totalDatas != null
                                                ? '${totalDatas!.mostWritten}'
                                                : "",
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
                                            text: totalDatas != null
                                                ? '${totalDatas!.mostYearMonth.year}년 ${totalDatas!.mostYearMonth.month}월'
                                                : "",
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
                                            text: totalDatas != null
                                                ? '${totalDatas!.mostNums}'
                                                : "",
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
                                                TextSpan(text: '수진'),
                                                //닉네임
                                                TextSpan(text: '님의 공유된 일기 중'),
                                                //일
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
                            SingleChildScrollView(
                              child: Container(
                                  width: 300,
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
                                        child: Text(
                                          '${totalDatas?.mostYearMonth.year}년 ${totalDatas?.mostYearMonth.month}월 ${totalDatas?.mostYearMonth.day}일',
                                          style: TextStyle(
                                            fontFamily: 'soojin',
                                            fontSize: 20,
                                          ),
                                        ),
                                      ), //날짜
                                      Expanded(
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Container(
                                                  child: (() {
                                                    if (mostLikedDiary!.imagePath.isNotEmpty) {
                                                      return SingleChildScrollView(
                                                        child: SizedBox(
                                                            width: 200,
                                                            height: 150, // 이미지 높이 조절
                                                            child: PageView.builder(
                                                              scrollDirection: Axis.horizontal,
                                                              itemCount:
                                                              mostLikedDiary!.imagePath.length > 3
                                                                  ? 3
                                                                  : mostLikedDiary!.imagePath.length,
                                                              // 최대 3장까지만 허용
                                                              itemBuilder: (context, index) {
                                                                return Center(
                                                                  child: Image.asset(
                                                                      mostLikedDiary!.imagePath[index]),
                                                                );
                                                              },
                                                            )),
                                                      );
                                                    }
                                                    else{return Container();}

                                                  }())),
                                              SizedBox(
                                                  child: ((){
                                                    if(mostLikedDiary!.voice.isNotEmpty){
                                                      return Container(
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
                                                                    position = Duration(
                                                                        seconds: value.toInt());
                                                                  });
                                                                  await audioPlayer.seek(position);
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
                                                                    formatTime(position),
                                                                    style:
                                                                    TextStyle(color: Colors.brown),
                                                                  ),
                                                                  SizedBox(width: 20),
                                                                  CircleAvatar(
                                                                    radius: 15,
                                                                    backgroundColor: Colors.transparent,
                                                                    child: IconButton(
                                                                      padding:
                                                                      EdgeInsets.only(bottom: 50),
                                                                      icon: Icon(
                                                                        isPlaying
                                                                            ? Icons.pause
                                                                            : Icons.play_arrow,
                                                                        color: Colors.brown,
                                                                      ),
                                                                      iconSize: 25,
                                                                      onPressed: () async {
                                                                        print(
                                                                            "isplaying 전 : $isPlaying");

                                                                        if (isPlaying) {
                                                                          //재생중이면
                                                                          await audioPlayer
                                                                              .pause(); //멈춤고
                                                                          setState(() {
                                                                            isPlaying =
                                                                            false; //상태변경하기..?
                                                                          });
                                                                        } else {
                                                                          //멈춘 상태였으면
                                                                          await playAudio();
                                                                          await audioPlayer
                                                                              .resume(); // 녹음된 오디오 재생
                                                                        }
                                                                        print(
                                                                            "isplaying 후 : $isPlaying");
                                                                      },
                                                                    ),
                                                                  ),
                                                                  SizedBox(width: 20),
                                                                  Text(
                                                                    formatTime(duration),
                                                                    style:
                                                                    TextStyle(color: Colors.brown),
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                    else{return Container();}
                                                  }())
                                              ),
                                              Container(
                                                  width: 380,
                                                  padding:
                                                  const EdgeInsets.fromLTRB(35, 10, 35, 10),
                                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                                  color: Colors.white54,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        mostLikedDiary!.content,
                                                        style: TextStyle(
                                                            fontFamily: 'soojin', fontSize: 17),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ), //글
                                      //수정버튼
                                    ],
                                  )),
                            ),
                            // 가장 공감 많이 받은 일기 보여줌
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
                                          TextSpan(
                                              text: totalDatas != null
                                                  ? '${totalDatas!.mostViewedEmpathy}'
                                                  : ""),
                                          //댓글
                                          TextSpan(text: '개의 공감과 '),
                                          //일
                                          TextSpan(
                                              text: totalDatas != null
                                                  ? '${totalDatas!.mostViewedComments}'
                                                  : ""),
                                          //댓글
                                          TextSpan(text: '개의 댓글을 받았어요'),
                                          //일
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
            ),
          ],
        )
            : Container(),
      ),
    );
  }
}

// 일기 버전 1 - 텍스트 + 사진
// class customWidget1 extends StatefulWidget {
//   final DateTime stitle;
//   final String simagePath;
//   final String sdiaryImage;
//   final String scomment;
//
//   const customWidget1({
//     super.key,
//     required this.stitle,
//     required this.simagePath,
//     required this.sdiaryImage,
//     required this.scomment,
//   });
//
//   @override
//   State<customWidget1> createState() => _customWidget1State();
// }
//
// class _customWidget1State extends State<customWidget1> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             width: 380,
//             padding: const EdgeInsets.all(8.0),
//             margin: const EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                     '${widget.stitle.year}년 ${widget.stitle.month}월 ${widget.stitle.day}일',
//                     style: TextStyle(
//                       fontFamily: "soojin",
//                       fontSize: 20,
//                       color: Colors.brown,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 35,
//                   height: 55,
//                   //  padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(widget.simagePath),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 //이미지
//                 SingleChildScrollView(
//                   child: Container(
//                       width: 200,
//                       height: 150, // 이미지 높이 조절
//                       child: Container(
//                         child: PageView.builder(
//                           //listview로 하면 한장씩 안넘어가서 페이지뷰함
//                           scrollDirection: Axis.horizontal,
//                           itemCount: diaryimage.length > 3
//                               ? 3
//                               : diaryimage.length, // 최대 3장까지만 허용
//                           itemBuilder: (context, index) {
//                             return Container(
//                               child: Center(
//                                 child: Image.asset(diaryimage[index]),
//                               ),
//                             );
//                           },
//                         ),
//                       )),
//                 ),
//                 //텍스트
//                 Container(
//                     width: 380,
//                     padding: const EdgeInsets.fromLTRB(35, 20, 35, 10),
//                     color: Colors.white54,
//                     child: Column(
//                       children: [
//                         Text(
//                           widget.scomment,
//                           style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // 일기 버전 2 - 텍스트
// class customWidget2 extends StatefulWidget {
//   final DateTime stitle;
//   final String simagePath;
//   final String scomment;
//
//   const customWidget2({
//     super.key,
//     required this.stitle,
//     required this.simagePath,
//     required this.scomment,
//   });
//
//   @override
//   State<customWidget2> createState() => _customWidget2State();
// }
//
// class _customWidget2State extends State<customWidget2> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             width: 380,
//             padding: const EdgeInsets.all(8.0),
//             margin: const EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                     '${widget.stitle.year}년 ${widget.stitle.month}월 ${widget.stitle.day}일',
//                     style: TextStyle(
//                       fontFamily: "soojin",
//                       fontSize: 20,
//                       color: Colors.brown,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 35,
//                   height: 55,
//                   //  padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(widget.simagePath),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 //텍스트
//                 Container(
//                     width: 380,
//                     padding: const EdgeInsets.fromLTRB(35, 0, 35, 10),
//                     color: Colors.white54,
//                     child: Column(
//                       children: [
//                         Text(
//                           widget.scomment,
//                           style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // 일기 버전 3 - 텍스트 + 음성 + 사진
// class customWidget3 extends StatefulWidget {
//   final DateTime stitle;
//   final String simagePath;
//   final String sdiaryImage;
//   final String scomment;
//   final String svoice;
//
//   const customWidget3({
//     super.key,
//     required this.stitle,
//     required this.simagePath,
//     required this.sdiaryImage,
//     required this.scomment,
//     required this.svoice,
//   });
//
//   @override
//   State<customWidget3> createState() => _customWidget3State();
// }
//
// class _customWidget3State extends State<customWidget3> {
//   //재생에 필요한 것들
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//
//   @override
//   void initState() {
//     super.initState();
//     setAudio();
//
//     audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         isPlaying = state == (PlayerState.playing);
//       });
//     });
//
//     audioPlayer.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//     });
//
//     audioPlayer.onPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//     });
//   }
//
//   Future setAudio() async {
//     String url = ' ';
//     audioPlayer.setReleaseMode(ReleaseMode.loop);
//     audioPlayer.setSourceUrl(url);
//   }
//
//   String formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inMinutes.remainder(60));
//
//     return [
//       if (duration.inHours > 0) hours,
//       minutes,
//       seconds,
//     ].join(':');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             width: 380,
//             padding: const EdgeInsets.all(8.0),
//             margin: const EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                     '${widget.stitle.year}년 ${widget.stitle.month}월 ${widget.stitle.day}일',
//                     style: TextStyle(
//                       fontFamily: "soojin",
//                       fontSize: 20,
//                       color: Colors.brown,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 35,
//                   height: 55,
//                   //  padding: EdgeInsets.all(8.0),
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(widget.simagePath),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 //이미지
//                 SingleChildScrollView(
//                   child: Container(
//                       width: 200,
//                       height: 150, // 이미지 높이 조절
//                       child: Container(
//                         child: PageView.builder(
//                           //listview로 하면 한장씩 안넘어가서 페이지뷰함
//                           scrollDirection: Axis.horizontal,
//                           itemCount: diaryimage.length > 3
//                               ? 3
//                               : diaryimage.length, // 최대 3장까지만 허용
//                           itemBuilder: (context, index) {
//                             return Container(
//                               child: Center(
//                                 child: Image.asset(diaryimage[index]),
//                               ),
//                             );
//                           },
//                         ),
//                       )),
//                 ),
//                 //녹음
//                 Container(
//                   padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
//                   child: Column(
//                     children: [
//                       Slider(
//                         min: 0,
//                         max: duration.inSeconds.toDouble(),
//                         value: position.inSeconds.toDouble(),
//                         onChanged: (value) async {
//                           final position = Duration(seconds: value.toInt());
//                           await audioPlayer.seek(position);
//                           await audioPlayer.resume();
//                         },
//                         activeColor: Color(0xFFF8F5EB),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               formatTime(position), // 진행중인 시간
//                               style: TextStyle(
//                                   color:
//                                       Colors.brown), // Set text color to black
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             CircleAvatar(
//                               radius: 15,
//                               backgroundColor: Colors.transparent,
//                               child: IconButton(
//                                 padding: EdgeInsets.only(bottom: 50),
//                                 icon: Icon(
//                                   isPlaying ? Icons.pause : Icons.play_arrow,
//                                   color: Colors.brown,
//                                 ),
//                                 iconSize: 25,
//                                 onPressed: () async {
//                                   if (isPlaying) {
//                                     await audioPlayer.pause();
//                                   } else {
//                                     await audioPlayer.resume();
//                                   }
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               formatTime(duration), //총 시간
//                               style: TextStyle(
//                                 color: Colors.brown,
//                               ), // Set text color to black
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 //텍스트
//                 Container(
//                     width: 380,
//                     padding: const EdgeInsets.fromLTRB(35, 20, 35, 10),
//                     color: Colors.white54,
//                     child: Column(
//                       children: [
//                         Text(
//                           widget.scomment,
//                           style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // 일기 버전 4 - 텍스트 + 음성
// class customWidget4 extends StatefulWidget {
//   final DateTime stitle;
//   final String simagePath;
//   final String scomment;
//   final String svoice;
//
//   const customWidget4({
//     super.key,
//     required this.stitle,
//     required this.simagePath,
//     required this.scomment,
//     required this.svoice,
//   });
//
//   @override
//   State<customWidget4> createState() => _customWidget4State();
// }
//
// class _customWidget4State extends State<customWidget4> {
//   //재생에 필요한 것들
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//
//   @override
//   void initState() {
//     super.initState();
//     setAudio();
//
//     audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         isPlaying = state == (PlayerState.playing);
//       });
//     });
//
//     audioPlayer.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//     });
//
//     audioPlayer.onPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//     });
//   }
//
//   Future setAudio() async {
//     String url = ' ';
//     audioPlayer.setReleaseMode(ReleaseMode.loop);
//     audioPlayer.setSourceUrl(url);
//   }
//
//   String formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inMinutes.remainder(60));
//
//     return [
//       if (duration.inHours > 0) hours,
//       minutes,
//       seconds,
//     ].join(':');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Container(
//             width: 380,
//             padding: const EdgeInsets.all(8.0),
//             margin: const EdgeInsets.all(8.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   child: Text(
//                     '${widget.stitle.year}년 ${widget.stitle.month}월 ${widget.stitle.day}일',
//                     style: TextStyle(
//                       fontFamily: "soojin",
//                       fontSize: 20,
//                       color: Colors.brown,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 35,
//                   height: 55,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(
//                       image: AssetImage(widget.simagePath),
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//                 //녹음
//                 Container(
//                   padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
//                   child: Column(
//                     children: [
//                       Slider(
//                         min: 0,
//                         max: duration.inSeconds.toDouble(),
//                         value: position.inSeconds.toDouble(),
//                         onChanged: (value) async {
//                           final position = Duration(seconds: value.toInt());
//                           await audioPlayer.seek(position);
//                           await audioPlayer.resume();
//                         },
//                         activeColor: Color(0xFFF8F5EB),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               formatTime(position), // 진행중인 시간
//                               style: TextStyle(
//                                   color:
//                                       Colors.brown), // Set text color to black
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             CircleAvatar(
//                               radius: 15,
//                               backgroundColor: Colors.transparent,
//                               child: IconButton(
//                                 padding: EdgeInsets.only(bottom: 50),
//                                 icon: Icon(
//                                   isPlaying ? Icons.pause : Icons.play_arrow,
//                                   color: Colors.brown,
//                                 ),
//                                 iconSize: 25,
//                                 onPressed: () async {
//                                   if (isPlaying) {
//                                     await audioPlayer.pause();
//                                   } else {
//                                     await audioPlayer.resume();
//                                   }
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text(
//                               formatTime(duration), //총 시간
//                               style: TextStyle(
//                                 color: Colors.brown,
//                               ), // Set text color to black
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 //텍스트
//                 Container(
//                     width: 380,
//                     padding: const EdgeInsets.fromLTRB(35, 20, 35, 10),
//                     color: Colors.white54,
//                     child: Column(
//                       children: [
//                         Text(
//                           widget.scomment,
//                           style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     )),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
