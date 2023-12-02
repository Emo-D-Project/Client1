import 'package:capston1/bar%20graph/bar_graph.dart';
import 'package:flutter/material.dart';
import 'statistics.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:intl/intl.dart';
import 'diaryshare.dart';
import 'package:audioplayers/audioplayers.dart';
import 'network/api_manager.dart';
import 'models/TotalData.dart';

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

  String name = '수진'; //닉네임



  ApiManager apiManager = ApiManager().getApiManager();

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  late int nums;
  late List<double> emotions;
  late String mostWritten;
  late DateTime firstDate;
  late DateTime mostYearMonth;
  late int mostNums;
  late int mostViewed;  // 일기의 아이디값
  late int mostViewedEmpathy;
  late int mostViewedComments;

  TotalData? totalDatas;

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getTSatisData();
      if(data != null) {
        setState(() {
          totalDatas = data;
        });
      }
    } catch (error) {
      // 오류 처리
      print('Error getting TS list: $error');
    }

  }

  Future<void> GetTStatis(String endpoint) async {
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['nums']; // 키를 통해 value를 받아오기
      print('nums: $value');
      nums = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['emotions']; // 키를 통해 value를 받아오기
      print('emotions: $value');
      emotions = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['mostWritten']; // 키를 통해 value를 받아오기
      print('mostWritten: $value');
      mostWritten = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['firstDate']; // 키를 통해 value를 받아오기
      print('firstDate: $value');
      firstDate = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['mostYearMonth']; // 키를 통해 value를 받아오기
      print('mostYearMonth: $value');
      mostYearMonth = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['mostNums']; // 키를 통해 value를 받아오기
      print('mostNums: $value');
      mostNums = value;

    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['mostViewed']; // 키를 통해 value를 받아오기
      print('mostViewed: $value');
      mostViewed = value;

    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['mostViewedEmpathy']; // 키를 통해 value를 받아오기
      print('mostViewedEmpathy: $value');
      mostViewedEmpathy = value;

    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['mostViewedComments']; // 키를 통해 value를 받아오기
      print('mostViewedComments: $value');
      mostViewedComments = value;

    } catch (e) {
      print('Error: $e');
    }
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
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context,index) {
                  return SingleChildScrollView(
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
                                        emotioncount: totalDatas!.emotions,
                                      ),
                                    ),
                                    //감정 이모션 사진
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center,
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
                                          SizedBox(width: 5,),
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
                                          SizedBox(width: 5,),
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
                                          SizedBox(width: 5,),
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
                                          SizedBox(width: 5,),
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
                                          SizedBox(width: 5,),
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
                                          SizedBox(width: 5,),
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
                                                  '${totalDatas!.firstDate
                                                      .year}년 ${totalDatas!
                                                      .firstDate
                                                      .month}월 ${totalDatas!
                                                      .firstDate.day}일',
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
                                                    text: '${totalDatas!
                                                        .nums}'),
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
                                                text: '${totalDatas!
                                                    .mostWritten}',
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
                                                TextSpan(
                                                    text: '일기를 가장 많이 작성하였어요 :D'),
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
                                                text: '${totalDatas!
                                                    .mostYearMonth
                                                    .year}년 ${totalDatas!
                                                    .mostYearMonth.month}월',
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
                                                text: '${totalDatas!
                                                    .mostNums}',
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
                                                TextSpan(
                                                    text: '가장 많이 일기를 작성하였어요 :D'),
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
                                          padding: EdgeInsets.fromLTRB(
                                              0, 12, 0, 0),
                                          child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: 'soojin',
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                  ),
                                                  children: [
                                                    TextSpan(text: name),
                                                    //닉네임
                                                    TextSpan(
                                                        text: '님의 공유된 일기 중'),
                                                    //일
                                                  ]))),
                                      Container(
                                          width: 300,
                                          padding: EdgeInsets.fromLTRB(
                                              0, 0, 0, 5),
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
                                              TextSpan(
                                                  text: '${totalDatas!
                                                      .mostViewedEmpathy}'),
                                              //댓글
                                              TextSpan(text: '개의 공감과 '),
                                              //일
                                              TextSpan(
                                                  text: '${totalDatas!
                                                      .mostViewedComments}'),
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
                  );
                }
              ),
            ),
        ],
      ),
    );
  }
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
