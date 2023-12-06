import 'package:capston1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audioplayers.dart';
import 'models/Diary.dart';
import 'network/api_manager.dart';

class DiaryUpdate extends StatefulWidget {
  final Diary diary;

  const DiaryUpdate({Key? key, required this.diary}) : super(key: key);

  @override
  State<DiaryUpdate> createState() => _DiaryUpdateState(diary);
}

List<Diary> diaries = [];
TextEditingController? _diaryController;

class _DiaryUpdateState extends State<DiaryUpdate> {
  Diary? diary;

  ApiManager apiManager = ApiManager().getApiManager();

  //재생에 필요한 것들
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String imagePath = "";

  _DiaryUpdateState(Diary diary) {
    this.diary = diary;
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getDiaryShareData();
      setState(() {
        diaries = data;
      });
    } catch (error) {
      // 에러 제어하는 부분
      print('Error getting share diaries list: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    playAudio();
    fetchDataFromServer();

    _diaryController = TextEditingController(text: diary!.content);

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


  Future setAudio() async {
    String url = ' ';
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.setSourceUrl(url);
  }

  Future<void> playAudio() async {
    try {
      if (isPlaying == PlayerState.playing) {
        await audioPlayer.stop(); // 이미 재생 중인 경우 정지시킵니다.
      }

      await audioPlayer.setSourceDeviceFile(diary!.audio);
      print("duration: $duration" );
      await Future.delayed(Duration(seconds: 2));
      print("after wait duration: $duration" );

      setState(() {
        duration = duration;
        isPlaying = true;
      });

      audioPlayer.play;

      print('오디오 재생 시작: $diary!.voice');
      print("duration: $duration");
    } catch (e) {
      print("audioPath : $diary!.voice");
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

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Color(0xFFF8F5EB),
          title: Container(
            child: (() {
              switch (diary?.emotion) {
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
                  context, MaterialPageRoute(builder: (context) => MyApp()));
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                icon: Icon(Icons.upload))
          ],
        ),
      body: Container(
        width: sizeX,
        height: sizeY,
        decoration: BoxDecoration(
          color: Color(0xFFF8F5EB),
        ),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: SingleChildScrollView(
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
                        '${diary?.date.year}년 ${diary?.date.month}월 ${diary?.date.day}일',
                        style: TextStyle(
                          fontFamily: 'soojin',
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        width: 110,
                      ),
                      IconButton(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => diaryUpdate(
                          //             diary: diary)));
                        },
                        icon: Image.asset(
                          'images/main/pencil.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          apiManager.RemoveDiary(diary!.diaryId);
                          print('다이어리 아이디 : ${diary!.diaryId}');
                        },
                        icon: Image.asset(
                          'images/main/trash.png',
                          width: 30,
                          height: 30,
                        ),
                      ),
                    ]),
                  ), //날짜
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                              child: (() {
                                if (diary!.imagePath!.isNotEmpty) {
                                  return SingleChildScrollView(
                                    child: SizedBox(
                                        width: 200,
                                        height: 150, // 이미지 높이 조절
                                        child: PageView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                          diary!.imagePath!.length > 3
                                              ? 3
                                              : diary!.imagePath?.length,
                                          // 최대 3장까지만 허용
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: Image.asset(
                                                  diary!.imagePath![index]),
                                            );
                                          },
                                        )),
                                  );
                                }
                                else{return Container();}

                              }())),
                          SizedBox(
                              child: ((){
                                if(diary!.audio.isNotEmpty){
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
                                  TextFormField(
                                    style: TextStyle(fontFamily: 'soojin'),
                                    controller: _diaryController,
                                    maxLines: 30,
                                    decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                            ))),
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
      ),
    );
  }
}

// 일기 버전 1 - 텍스트 + 사진
// class customWidget1 extends StatefulWidget {
//   final DateTime sdate;
//   final List<String> sdiaryImage;
//   final int diaryId;
//
//   const customWidget1({
//     super.key,
//     required this.sdate,
//     required this.sdiaryImage,
//     required this.diaryId,
//   });
//
//   @override
//   State<customWidget1> createState() => _customWidget1State(diaryId);
// }
//
// class _customWidget1State extends State<customWidget1> {
//
//   int diaryId = 0;
//
//   ApiManager apiManager = ApiManager().getApiManager();
//
//   _customWidget1State(int diaryId) {
//     this.diaryId = diaryId;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sizeX = MediaQuery.of(context).size.width;
//     final sizeY = MediaQuery.of(context).size.height;
//
//     Diary diary;
//     return SingleChildScrollView(
//       child: Center(
//         child: Container(
//             width: sizeX * 0.9,
//             height: sizeY * 0.8,
//             margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                   child: Row(children: [
//                     SizedBox(
//                       width: 30,
//                     ),
//                     Text(
//                       '${widget.sdate.year}년 ${widget.sdate.month}월 ${widget.sdate.day}일',
//                       style: TextStyle(
//                         fontFamily: 'soojin',
//                         fontSize: 20,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 90,
//                     ),
//                     IconButton(
//                         onPressed: () {
//                           // Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) => diaryUpdate(diary: diary,)));
//                         },
//                       icon: Image.asset('images/main/pencil.png', width: 30, height: 30,),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         apiManager.RemoveDiary(diaryId);
//                         print('다이어리 아이디 : ${diaryId}');
//                       },
//                       icon: Image.asset('images/main/trash.png', width: 30, height: 30,),
//                     ),
//                   ]),
//                 ), //날짜
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SingleChildScrollView(
//                           child: Container(
//                               width: 200,
//                               height: 150, // 이미지 높이 조절
//                               child: Container(
//                                 child: PageView.builder(
//                                   //listview로 하면 한장씩 안넘어가서 페이지뷰함
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: widget.sdiaryImage.length > 3
//                                       ? 3
//                                       : widget.sdiaryImage.length,
//                                   // 최대 3장까지만 허용
//                                   itemBuilder: (context, index) {
//                                     return Container(
//                                       child: Center(
//                                         child: Image.asset(
//                                             widget.sdiaryImage[index]),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               )),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(11, 10, 11, 10),
//                           color: Colors.white54,
//                           child: TextFormField(
//                             style: TextStyle(fontFamily: 'soojin'),
//                             controller: _diaryController,
//                             maxLines: 30,
//                             decoration: InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                               color: Colors.transparent,
//                             ))),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ), //글
//                 //수정버튼
//               ],
//             )),
//       ),
//     );
//   }
// }
//
// //글만 있는 거
// class customWidget2 extends StatefulWidget {
//   final DateTime sdate;
//   final int diaryId;
//
//   const customWidget2({
//     super.key,
//     required this.sdate,
//     required this.diaryId,
//   });
//
//   @override
//   State<customWidget2> createState() => _customWidget2State(diaryId);
// }
//
// class _customWidget2State extends State<customWidget2> {
//
//   int diaryId = 0;
//
//   ApiManager apiManager = ApiManager().getApiManager();
//
//   _customWidget2State(int diaryId) {
//     this.diaryId = diaryId;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sizeX = MediaQuery.of(context).size.width;
//     final sizeY = MediaQuery.of(context).size.height;
//
//     return SingleChildScrollView(
//       child: Center(
//         child: Container(
//             width: sizeX * 0.9,
//             height: sizeY * 0.8,
//             margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                   child: Row(children: [
//                     SizedBox(
//                       width: 30,
//                     ),
//                     Text(
//                       '${widget.sdate.year}년 ${widget.sdate.month}월 ${widget.sdate.day}일',
//                       style: TextStyle(
//                         fontFamily: 'soojin',
//                         fontSize: 20,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 90,
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => diaryUpdate(diary: diary,)));
//                       },
//                       icon: Image.asset('images/main/pencil.png', width: 30, height: 30,),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         apiManager.RemoveDiary(diaryId);
//                         print('다이어리 아이디 : ${diaryId}');
//                       },
//                       icon: Image.asset('images/main/trash.png', width: 30, height: 30,),
//                     ),
//                   ]),
//                 ), //날짜
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Container(
//                       margin: EdgeInsets.fromLTRB(11, 10, 11, 10),
//                       color: Colors.white54,
//                       child: TextFormField(
//                         style: TextStyle(fontFamily: 'soojin'),
//                         controller: _diaryController,
//                         maxLines: 30,
//                         decoration: InputDecoration(
//                             enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                           color: Colors.transparent,
//                         ))),
//                       ),
//                     ),
//                   ),
//                 ), //글
//                 //수정버튼
//               ],
//             )),
//       ),
//     );
//   }
// }
//
// // 일기 버전 3 - 텍스트 + 음성
// class customwidget3 extends StatefulWidget {
//   final String svoice;
//   final DateTime sdate;
//   final int diaryId;
//
//   const customwidget3({
//     super.key,
//     required this.svoice,
//     required this.sdate,
//     required this.diaryId,
//   });
//
//   @override
//   State<customwidget3> createState() => _customwidget3State(diaryId);
// }
//
// class _customwidget3State extends State<customwidget3> {
//
//   int diaryId = 0;
//
//   ApiManager apiManager = ApiManager().getApiManager();
//
//   _customwidget3State(int diaryId) {
//     this.diaryId = diaryId;
//   }
//   final recorder = sound.FlutterSoundRecorder();
//   bool isRecording = false; //녹음 상태
//   String audioPath = '';  //녹음중단 시 경로 받아올 변수
//   String playAudioPath = '';  //저장할때 받아올 변수 , 재생 시 필요
//
//
//   //재생에 필요한 것들
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   String imagePath = "";
//
//   @override
//   void initState() {
//     super.initState();
//     playAudio();
//     //마이크 권한 요청, 녹음 초기화
//     initRecorder();
//     setAudio();
//
//     audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         isPlaying = state == PlayerState.playing;
//       });
//       print("헨들러 isplaying : $isPlaying");
//     });
//
//     //재생 파일의 전체 길이를 감지하는 이벤트 핸들러
//     audioPlayer.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//     });
//
//     //재생 중인 파일의 현재 위치를 감지하는 이벤트 핸들러
//     audioPlayer.onPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//       print('Current position: $position');
//     });
//   }
//
//   @override
//   void dispose() {
//     recorder.closeRecorder();
//     audioPlayer.dispose();
//     super.dispose();
//   }
//
//
//   Future setAudio() async {
//     String url = ' ';
//     audioPlayer.setReleaseMode(ReleaseMode.loop);
//     audioPlayer.setSourceUrl(url);
//   }
//
//   Future<void> playAudio() async {
//     try {
//       if (isPlaying == PlayerState.playing) {
//         await audioPlayer.stop(); // 이미 재생 중인 경우 정지시킵니다.
//       }
//
//       await audioPlayer.setSourceDeviceFile(playAudioPath);
//       print("duration: $duration" );
//       await Future.delayed(Duration(seconds: 2));
//       print("after wait duration: $duration" );
//
//       setState(() {
//         duration = duration;
//         isPlaying = true;
//       });
//
//       audioPlayer.play;
//
//       print('오디오 재생 시작: $playAudioPath');
//       print("duration: $duration");
//     } catch (e) {
//       print("audioPath : $playAudioPath");
//       print("오디오 재생 중 오류 발생 : $e");
//     }
//   }
//
//   Future initRecorder() async {
//     final status = await Permission.microphone.request();
//
//     if (status != PermissionStatus.granted) {
//       throw 'Microphone permission not granted';
//     }
//
//     await recorder.openRecorder();
//
//     isRecording = true;
//     recorder.setSubscriptionDuration(
//       const Duration(milliseconds: 500),
//     );
//   }
//
//   //저장함수
//   Future<String> saveRecordingLocally() async {
//     if (audioPath.isEmpty) return ''; // 녹음된 오디오 경로가 비어있으면 빈 문자열 반환
//
//     final audioFile = File(audioPath);
//     if (!audioFile.existsSync()) return ''; // 파일이 존재하지 않으면 빈 문자열 반환
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final newPath =
//       p.join(directory.path, 'recordings'); // recordings 디렉터리 생성
//       final newFile = File(p.join(
//           newPath, 'audio.mp3')); // 여기서 'audio.mp3'는 파일명을 나타냅니다. 필요에 따라 변경 가능
//       if (!(await newFile.parent.exists())) {
//         await newFile.parent.create(recursive: true); // recordings 디렉터리가 없으면 생성
//       }
//
//       await audioFile.copy(newFile.path); // 기존 파일을 새로운 위치로 복사
//
//       print('Complete Saving recording: ${newFile.path}');
//       playAudioPath = newFile.path;
//
//       return newFile.path; // 새로운 파일의 경로 반환
//     } catch (e) {
//       print('Error saving recording: $e');
//       return ''; // 오류 발생 시 빈 문자열 반환
//     }
//   }
//
//   // 녹음 중지 & 녹음된 파일의 경로를 가져옴 및 저장
//   Future<void> stop() async {
//     final path = await recorder.stopRecorder(); // 녹음 중지하고, 녹음된 오디오 파일의 경로를 얻음
//     audioPath = path!;
//
//     setState(() {
//       isRecording = false;
//     });
//
//     final savedFilePath = await saveRecordingLocally(); // 녹음된 파일을 로컬에 저장
//     print("savedFilePath: $savedFilePath");
//
//   }
//
//   String formatTime(Duration duration) {
//     print("formatTime duration: $duration");
//
//     int minutes = duration.inMinutes.remainder(60);
//     int seconds = duration.inSeconds.remainder(60);
//
//     String result = '$minutes:${seconds.toString().padLeft(2, '0')}';
//
//     print("formatTime result: $result");
//     return result;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sizeX = MediaQuery.of(context).size.width;
//     final sizeY = MediaQuery.of(context).size.height;
//
//     return SingleChildScrollView(
//       child: Center(
//         child: Container(
//             width: sizeX * 0.9,
//             height: sizeY * 0.8,
//             margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                   child: Row(children: [
//                     SizedBox(
//                       width: 30,
//                     ),
//                     Text(
//                       '${widget.sdate.year}년 ${widget.sdate.month}월 ${widget.sdate.day}일',
//                       style: TextStyle(
//                         fontFamily: 'soojin',
//                         fontSize: 20,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 90,
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => diaryUpdate(diary: diary,)));
//                       },
//                       icon: Image.asset('images/main/pencil.png', width: 30, height: 30,),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         apiManager.RemoveDiary(diaryId);
//                         print('다이어리 아이디 : ${diaryId}');
//
//                       },
//                       icon: Image.asset('images/main/trash.png', width: 30, height: 30,),
//                     ),
//                   ]),
//                 ), //날짜
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
//                           child: Column(
//                             children: [
//                               SliderTheme(
//                                 data: SliderThemeData(
//                                   inactiveTrackColor: Color(0xFFF8F5EB),
//                                 ),
//                                 child: Slider(
//                                   min: 0,
//                                   max: duration.inSeconds.toDouble(),
//                                   value: position.inSeconds.toDouble(),
//                                   onChanged: (value) async {
//                                     setState(() {
//                                       position = Duration(seconds: value.toInt());
//                                     });
//                                     await audioPlayer.seek(position);
//                                     //await audioPlayer.resume();
//                                   },
//                                   activeColor: Color(0xFF968C83),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween,
//                                   children: [
//                                     Text(
//                                       formatTime(position),
//                                       style: TextStyle(color: Colors.brown),
//                                     ),
//                                     SizedBox(width: 20),
//                                     CircleAvatar(
//                                       radius: 15,
//                                       backgroundColor: Colors.transparent,
//                                       child: IconButton(
//                                         padding: EdgeInsets.only(
//                                             bottom: 50),
//                                         icon: Icon(
//                                           isPlaying ? Icons.pause : Icons
//                                               .play_arrow,
//                                           color: Colors.brown,
//                                         ),
//                                         iconSize: 25,
//                                         onPressed: () async {
//                                           print("isplaying 전 : $isPlaying");
//
//                                           if (isPlaying) {  //재생중이면
//                                             await audioPlayer.pause(); //멈춤고
//                                             setState(() {
//                                               isPlaying = false; //상태변경하기..?
//                                             });
//                                           } else { //멈춘 상태였으면
//                                             await playAudio();
//                                             await audioPlayer.resume();// 녹음된 오디오 재생
//                                           }
//                                           print("isplaying 후 : $isPlaying");
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(width: 20),
//                                     Text(
//                                       formatTime(duration),
//                                       style: TextStyle(color: Colors.brown),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(11, 10, 11, 10),
//                           color: Colors.white54,
//                           child: TextFormField(
//                             style: TextStyle(fontFamily: 'soojin'),
//                             controller: _diaryController,
//                             maxLines: 30,
//                             decoration: InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                               color: Colors.transparent,
//                             ))),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ), //글
//                 //수정버튼
//               ],
//             )),
//       ),
//     );
//   }
// }
//
// // 일기 버전4 - 텍스트 + 음성 + 사진
// class customwidget4 extends StatefulWidget {
//   final List<String> sdiaryImage; // 다이어리 안에 이미지
//   final String svoice; // 녹음 기능
//   final DateTime sdate;
//   final int diaryId;
//
//   const customwidget4({
//     super.key,
//     required this.sdiaryImage,
//     required this.svoice,
//     required this.sdate,
//     required this.diaryId,
//   });
//
//   @override
//   State<customwidget4> createState() => _customwidget4State(diaryId);
// }
//
// class _customwidget4State extends State<customwidget4> {
//
//   int diaryId = 0;
//
//   ApiManager apiManager = ApiManager().getApiManager();
//
//   _customwidget4State(int diaryId) {
//     this.diaryId = diaryId;
//   }
//
//   final recorder = sound.FlutterSoundRecorder();
//   bool isRecording = false; //녹음 상태
//   String audioPath = '';  //녹음중단 시 경로 받아올 변수
//   String playAudioPath = '';  //저장할때 받아올 변수 , 재생 시 필요
//
//
//   //재생에 필요한 것들
//   final audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   Duration duration = Duration.zero;
//   Duration position = Duration.zero;
//   String imagePath = "";
//
//   @override
//   void initState() {
//     super.initState();
//     playAudio();
//     //마이크 권한 요청, 녹음 초기화
//     initRecorder();
//     setAudio();
//
//     //재생 상태가 변경될 때마다 상태를 감지하는 이벤트 핸들러
//     audioPlayer.onPlayerStateChanged.listen((state) {
//       setState(() {
//         isPlaying = state == PlayerState.playing;
//       });
//       print("헨들러 isplaying : $isPlaying");
//     });
//
//     //재생 파일의 전체 길이를 감지하는 이벤트 핸들러
//     audioPlayer.onDurationChanged.listen((newDuration) {
//       setState(() {
//         duration = newDuration;
//       });
//     });
//
//     //재생 중인 파일의 현재 위치를 감지하는 이벤트 핸들러
//     audioPlayer.onPositionChanged.listen((newPosition) {
//       setState(() {
//         position = newPosition;
//       });
//       print('Current position: $position');
//     });
//   }
//
//   @override
//   void dispose() {
//     recorder.closeRecorder();
//     audioPlayer.dispose();
//     super.dispose();
//   }
//
//
//   Future setAudio() async {
//     String url = ' ';
//     audioPlayer.setReleaseMode(ReleaseMode.loop);
//     audioPlayer.setSourceUrl(url);
//   }
//
//   Future<void> playAudio() async {
//     try {
//       if (isPlaying == PlayerState.playing) {
//         await audioPlayer.stop(); // 이미 재생 중인 경우 정지시킵니다.
//       }
//
//       await audioPlayer.setSourceDeviceFile(playAudioPath);
//       print("duration: $duration" );
//       await Future.delayed(Duration(seconds: 2));
//       print("after wait duration: $duration" );
//
//       setState(() {
//         duration = duration;
//         isPlaying = true;
//       });
//
//       audioPlayer.play;
//
//       print('오디오 재생 시작: $playAudioPath');
//       print("duration: $duration");
//     } catch (e) {
//       print("audioPath : $playAudioPath");
//       print("오디오 재생 중 오류 발생 : $e");
//     }
//   }
//
//   Future initRecorder() async {
//     final status = await Permission.microphone.request();
//
//     if (status != PermissionStatus.granted) {
//       throw 'Microphone permission not granted';
//     }
//
//     await recorder.openRecorder();
//
//     isRecording = true;
//     recorder.setSubscriptionDuration(
//       const Duration(milliseconds: 500),
//     );
//   }
//
//   //저장함수
//   Future<String> saveRecordingLocally() async {
//     if (audioPath.isEmpty) return ''; // 녹음된 오디오 경로가 비어있으면 빈 문자열 반환
//
//     final audioFile = File(audioPath);
//     if (!audioFile.existsSync()) return ''; // 파일이 존재하지 않으면 빈 문자열 반환
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final newPath =
//       p.join(directory.path, 'recordings'); // recordings 디렉터리 생성
//       final newFile = File(p.join(
//           newPath, 'audio.mp3')); // 여기서 'audio.mp3'는 파일명을 나타냅니다. 필요에 따라 변경 가능
//       if (!(await newFile.parent.exists())) {
//         await newFile.parent.create(recursive: true); // recordings 디렉터리가 없으면 생성
//       }
//
//       await audioFile.copy(newFile.path); // 기존 파일을 새로운 위치로 복사
//
//       print('Complete Saving recording: ${newFile.path}');
//       playAudioPath = newFile.path;
//
//       return newFile.path; // 새로운 파일의 경로 반환
//     } catch (e) {
//       print('Error saving recording: $e');
//       return ''; // 오류 발생 시 빈 문자열 반환
//     }
//   }
//
//   // 녹음 중지 & 녹음된 파일의 경로를 가져옴 및 저장
//   Future<void> stop() async {
//     final path = await recorder.stopRecorder(); // 녹음 중지하고, 녹음된 오디오 파일의 경로를 얻음
//     audioPath = path!;
//
//     setState(() {
//       isRecording = false;
//     });
//
//     final savedFilePath = await saveRecordingLocally(); // 녹음된 파일을 로컬에 저장
//     print("savedFilePath: $savedFilePath");
//
//   }
//
//   String formatTime(Duration duration) {
//     print("formatTime duration: $duration");
//
//     int minutes = duration.inMinutes.remainder(60);
//     int seconds = duration.inSeconds.remainder(60);
//
//     String result = '$minutes:${seconds.toString().padLeft(2, '0')}';
//
//     print("formatTime result: $result");
//     return result;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final sizeX = MediaQuery.of(context).size.width;
//     final sizeY = MediaQuery.of(context).size.height;
//
//     return SingleChildScrollView(
//       child: Center(
//         child: Container(
//             width: sizeX * 0.9,
//             height: sizeY * 0.8,
//             margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(10)),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                   child: Row(children: [
//                     SizedBox(
//                       width: 30,
//                     ),
//                     Text(
//                       '${widget.sdate.year}년 ${widget.sdate.month}월 ${widget.sdate.day}일',
//                       style: TextStyle(
//                         fontFamily: 'soojin',
//                         fontSize: 20,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 90,
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (context) => diaryUpdate(diary: diary,)));
//                       },
//                       icon: Image.asset('images/main/pencil.png', width: 30, height: 30,),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         apiManager.RemoveDiary(diaryId);
//                         print('다이어리 아이디 : ${diaryId}');
//                       },
//                       icon: Image.asset('images/main/trash.png', width: 30, height: 30,),
//                     ),
//                   ]),
//                 ), //날짜
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         SingleChildScrollView(
//                           child: Container(
//                               width: 200,
//                               height: 150, // 이미지 높이 조절
//                               child: Container(
//                                 child: PageView.builder(
//                                   //listview로 하면 한장씩 안넘어가서 페이지뷰함
//                                   scrollDirection: Axis.horizontal,
//                                   itemCount: widget.sdiaryImage.length > 3
//                                       ? 3
//                                       : widget.sdiaryImage.length,
//                                   // 최대 3장까지만 허용
//                                   itemBuilder: (context, index) {
//                                     return Container(
//                                       child: Center(
//                                         child: Image.asset(
//                                             widget.sdiaryImage[index]),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               )),
//                         ),
//                         Container(
//                           padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
//                           child: Column(
//                             children: [
//                               SliderTheme(
//                                 data: SliderThemeData(
//                                   inactiveTrackColor: Color(0xFFF8F5EB),
//                                 ),
//                                 child: Slider(
//                                   min: 0,
//                                   max: duration.inSeconds.toDouble(),
//                                   value: position.inSeconds.toDouble(),
//                                   onChanged: (value) async {
//                                     setState(() {
//                                       position = Duration(seconds: value.toInt());
//                                     });
//                                     await audioPlayer.seek(position);
//                                     //await audioPlayer.resume();
//                                   },
//                                   activeColor: Color(0xFF968C83),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 16),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment
//                                       .spaceBetween,
//                                   children: [
//                                     Text(
//                                       formatTime(position),
//                                       style: TextStyle(color: Colors.brown),
//                                     ),
//                                     SizedBox(width: 20),
//                                     CircleAvatar(
//                                       radius: 15,
//                                       backgroundColor: Colors.transparent,
//                                       child: IconButton(
//                                         padding: EdgeInsets.only(
//                                             bottom: 50),
//                                         icon: Icon(
//                                           isPlaying ? Icons.pause : Icons
//                                               .play_arrow,
//                                           color: Colors.brown,
//                                         ),
//                                         iconSize: 25,
//                                         onPressed: () async {
//                                           print("isplaying 전 : $isPlaying");
//
//                                           if (isPlaying) {  //재생중이면
//                                             await audioPlayer.pause(); //멈춤고
//                                             setState(() {
//                                               isPlaying = false; //상태변경하기..?
//                                             });
//                                           } else { //멈춘 상태였으면
//                                             await playAudio();
//                                             await audioPlayer.resume();// 녹음된 오디오 재생
//                                           }
//                                           print("isplaying 후 : $isPlaying");
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(width: 20),
//                                     Text(
//                                       formatTime(duration),
//                                       style: TextStyle(color: Colors.brown),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Container(
//                           margin: EdgeInsets.fromLTRB(11, 10, 11, 10),
//                           color: Colors.white54,
//                           child: TextFormField(
//                             style: TextStyle(fontFamily: 'soojin'),
//                             controller: _diaryController,
//                             maxLines: 30,
//                             decoration: InputDecoration(
//                                 enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                               color: Colors.transparent,
//                             ))),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ), //글
//                 //수정버튼
//               ],
//             )),
//       ),
//     );
//   }
// }
