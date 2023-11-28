import 'package:capston1/main.dart';
import 'package:capston1/network/api_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' ;
import 'package:timer_builder/timer_builder.dart';
import 'package:intl/intl.dart';
import 'package:flutter_sound/flutter_sound.dart' as sound;
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path/path.dart' as p;

final String now = DateTime.now().toString();
String formattedDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());

class writediary extends StatefulWidget {
  const writediary({super.key, required this.emotion});

  final String emotion;

  @override
  State<writediary> createState() => _writediaryState();
}

var audioFile;

class _writediaryState extends State<writediary> {
  final picker = ImagePicker();
  List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
  List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

  ApiManager apiManager = ApiManager().getApiManager();

  DateTime dateTime = DateTime.now();
  late String content = _contentEditController.text;
  late String sendEmotion = widget.emotion;
  bool _isChecked = false;
  bool _isCheckedShare = false;


  Future<void> GetWriteDiary(String endpoint) async {
    try {
      final response = await apiManager.Get(endpoint); // 실제 API 엔드포인트로 대체

      // 요청 응답 받기
      final value = response['key']; // 키를 통해 value를 받아오기
      print('Data: $value');

      //title = response['title'];
    } catch (e) {
      print('Error: $e');
    }
  }

  // onpress():
  //      PostExample("/api/message");
  //
  // 다른버튼 onperss():
  //       PostExample("api/title");

  Future<void> PostWriteDiary(String endpoint) async {
    ApiManager apiManager = ApiManager().getApiManager();

    try {
      final postData = {
        'content': content,
        'emotion': sendEmotion,
        'is_share': _isCheckedShare,
        'is_comm': _isChecked,
        //오디오 전송
      };
      //print(postData);
      await apiManager.post(endpoint, postData); // 실제 API 엔드포인트로 대체
    } catch (e) {
      print('Error: $e');
    }
  }

  final _contentEditController = TextEditingController();

  //녹음에 필요한 것들
  final recorder = sound.FlutterSoundRecorder();
  bool isRecording = false;
  // late Record audioRecord;
  // late AudioPlayer audioPlayer;
  // bool isRecording = false;
  String audioPath = '';

  //재생에 필요한 것들
  final audioPlayer = AudioPlayer(); //오디오 파일을 재생하는 기능 제공
  bool isPlaying = false; //현재 재생중인지
  Duration duration = Duration.zero; //총 시간
  Duration position = Duration.zero; //진행중인 시간

  @override
  void initState() {
    // audioPlayer = AudioPlayer();
    // audioRecord = Record();

    super.initState();

    //오디오 설정, 재생모드를 설정하고 소스 URL을 지정
    //setAudio();
    playRecording();

    //마이크 권한 요청, 녹음 초기화
    initRecorder();

    //재생 상태가 변경될 때마다 상태를 감지하는 이벤트 핸들러
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
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
    });
  }

  // Future setAudio() async {
  //   //audioPlayer.setReleaseMode(ReleaseMode.loop);
  //
  //   String url = ' ';
  //   audioPlayer.setSourceUrl(url);
  //
  //   final result = await FilePicker.platform.pickFiles();
  //
  //   if(result !=null){
  //   final file = File(result.files.single.path!);
  //   audioPlayer.setSourceUrl(
  //     '/data/user/0/com.example.capston1/cache/audio',
  //   );
  //   }
  // }

  // Future setAudio() async{
  //   audioPlayer.setReleaseMode(ReleaseMode.loop);
  //   String url = audioPath;
  //   audioPlayer.setSourceUrl(url);
  //   print('Playing audio: $url');
  // }

  @override
  void dispose() {
    recorder.closeRecorder();
    audioPlayer.dispose();

    // audioRecord.dispose();
    // audioPlayer.dispose();

    super.dispose();
  }

  Future<void> playRecording() async {
    try {
      Source urlSource = UrlSource(audioPath);
      print("audioUrl: $urlSource");
      await audioPlayer.play(urlSource);
    } catch (e) {
      print("Error playing Recording : $e");
    }
  }


  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'Microphone permission not granted';
    }

    await recorder.openRecorder();

    isRecording = true;
    recorder.setSubscriptionDuration(
      const Duration(milliseconds: 500),
    );
  }

  //녹음 시작
  Future record() async {
    if (!isRecording) return;
    await recorder.startRecorder(toFile: 'audio');
  }


  Future<String> saveRecordingLocally() async {
    if (audioPath.isEmpty) return ''; // 녹음된 오디오 경로가 비어있으면 빈 문자열 반환

    final audioFile = File(audioPath);
    if (!audioFile.existsSync()) return ''; // 파일이 존재하지 않으면 빈 문자열 반환

    try {
      final directory = await getApplicationDocumentsDirectory();
      final newPath = p.join(directory.path, 'recordings'); // recordings 디렉터리 생성
      final newFile = File(p.join(newPath, 'audio.mp3')); // 여기서 'audio.mp3'는 파일명을 나타냅니다. 필요에 따라 변경 가능

      if (!(await newFile.parent.exists())) {
        await newFile.parent.create(recursive: true); // recordings 디렉터리가 없으면 생성
      }

      await audioFile.copy(newFile.path); // 기존 파일을 새로운 위치로 복사

      print('Complete Saving recording: ${newFile.path}');

      return newFile.path; // 새로운 파일의 경로 반환
    } catch (e) {
      print('Error saving recording: $e');
      return ''; // 오류 발생 시 빈 문자열 반환
    }
  }

// 녹음 중지 & 녹음된 파일의 경로를 가져옴 및 저장
  Future<String> stop() async {
    if (!isRecording) return '';

    final path = await recorder.stopRecorder(); // 녹음 중지하고, 녹음된 오디오 파일의 경로를 얻음
    audioPath = path!;

    setState(() {
      isRecording = false;
    });

    final savedFilePath = await saveRecordingLocally(); // 녹음된 파일을 로컬에 저장

    if (savedFilePath.isNotEmpty) {
      final savedFile = File(savedFilePath);
      if (savedFile.existsSync()) {
        final fileContent = await savedFile.readAsString(); // 파일 내용 읽기
        print('Content of saved file: $fileContent'); // 파일 내용 출력
      } else {
        print('Error: File does not exist');
      }
      return savedFilePath; // 저장된 파일의 경로 반환
    } else {
      return ''; // 저장 실패 시 빈 문자열 반환
    }

  }


  //파일 서버에 보내기
    //run(audioFile as String);

  // Future<String> run(String audioUrl) async {
  //   String openApiURL = " ";
  //   String accessKey = " "; // 발급받은 API Key
  //   String languageCode = "korean"; // 언어 코드
  //   String audioFilePath = audioUrl; // 녹음된 음성 파일 경로
  //   String audioContents;
  //   var gson = JsonCodec();
  //
  //   Map<String, dynamic> request = {
  //     'argument': {'language_code': languageCode},
  //   };
  //
  //   try {
  //     var file = File(audioFilePath);
  //     var audioBytes = await file.readAsBytes();
  //     audioContents = base64.encode(audioBytes);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //  // request['argument']['audio'] = audioContents;
  //
  //   var url = Uri.parse(openApiURL);
  //   var responseCode;
  //   var responseBody;
  //
  //   try {
  //     var request = await HttpClient().postUrl(url);
  //     request.headers.set('Content-Type', 'application/json; charset=UTF-8');
  //     request.headers.set('Authorization', accessKey);
  //
  //     request.write(json.encode(request));
  //     var response = await request.close();
  //
  //     responseCode = response.statusCode;
  //     var contents = await utf8.decodeStream(response);
  //     responseBody = contents;
  //
  //     print('[responseCode] $responseCode');
  //     print('[responseBody]');
  //     print(responseBody);
  //
  //     return 'responseBody: $responseBody';
  //   } catch (e) {
  //     print(e.toString());
  //   }
  //
  //   return '';
  // }


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
                  height: 45,
                  width: 45,
                );
              case 'flutter':
                return Image.asset(
                  'images/emotion/2.gif',
                  height: 45,
                  width: 45,
                );
              case 'angry':
                return Image.asset(
                  'images/emotion/angry.png',
                  height: 45,
                  width: 45,
                );
              case 'annoying':
                return Image.asset(
                  'images/emotion/4.gif',
                  height: 45,
                  width: 45,
                );
              case 'tired':
                return Image.asset(
                  'images/emotion/5.gif',
                  height: 45,
                  width: 45,
                );
              case 'sad':
                return Image.asset(
                  'images/emotion/6.gif',
                  height: 45,
                  width: 45,
                );
              case 'calmness':
                return Image.asset(
                  'images/emotion/7.gif',
                  height: 45,
                  width: 45,
                );
            }
          })(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFF968C83),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()));
              print("PostExample 실행");
              PostWriteDiary("/api/diaries/create");
            },
            icon: Image.asset(
              "images/send/upload.png",
              width: 30,
              height: 30,
              color: Color(0xFF968C83),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8F5EB),
        ),
        child: Column(
          children: [
            Container(
                width: sizeX * 0.88,
                height: sizeY * 0.75,
                margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 120, 20),
                      child: Text(
                        formattedDate,
                        style: TextStyle(
                          color: Color(0xFF7D5A50),
                          fontSize: 20,
                          fontFamily: 'soojin',
                        ),
                      ), //날짜 변경 해야함
                    ), // 날짜
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                                margin: EdgeInsets.all(10),
                                //color: Colors.amber,
                                width: 200,
                                height: 150,
                                child: GridView.builder(
                                    padding: EdgeInsets.all(0),
                                    shrinkWrap: true,
                                    itemCount: images.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 1 / 1,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(
                                          "Image size: ${File(images[index]!.path).lengthSync()} bytes");
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: FileImage(
                                                File(images[index]!.path),
                                              ),
                                            )),
                                      );
                                    })),
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
                            ), //음성
                            // if(!isRecording && audioPath !=null)
                            // ElevatedButton(
                            //   onPressed: playRecording,
                            //   child: const Text(("play")),
                            // ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              child: TextField(
                                style: TextStyle(fontFamily: 'soojin'),
                                controller: _contentEditController,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ), //일기 내용
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 3, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: IconButton(
                              onPressed: () async {
                                multiImage = await picker.pickMultiImage();
                                setState(() {
                                  images.addAll(multiImage);
                                });
                              },
                              icon: Image.asset(
                                "images/main/gallery.png",
                                width: 35,
                                height: 35,
                                color: Color(0xFF968C83),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              /*StreamBuilder<sound.RecordingDisposition>(
                                stream: recorder.onProgress,
                                builder: (context,snapshot) {
                                  final duration = snapshot.hasData
                                      ? snapshot.data!.duration
                                      : Duration.zero;

                                  String twoDigits(int n) => n.toString().padLeft(10);
                                  final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
                                  final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

                                  return Text('$twoDigitMinutes:$twoDigitSeconds',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);
                                },
                            ),
                            const SizedBox(height: 5),
                              SizedBox(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Colors.red,
                                  minimumSize: Size(20, 30)
                                ),
                                child: Icon(recorder.isRecording ? Icons.stop : Icons.mic,size: 30,color: Colors.black,),
                                onPressed: ()async{
                                  if(recorder.isRecording){
                                    await stop();
                                  }else{
                                    await record();
                                  }

                                  setState(() {

                                  });
                                },
                              ),
                            ),*/
                              SizedBox(
                                child: IconButton(
                                  onPressed: () async {
                                    if (recorder.isRecording) {
                                      await stop();
                                    } else {
                                      await record();
                                    }
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    recorder.isRecording
                                        ? Icons.stop
                                        : Icons.mic,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              // if (isRecording) Text("Recording in Progress"),
                              // SizedBox(
                              //   child: IconButton(
                              //     onPressed: isRecording
                              //         ? stopRecording
                              //         : startRecording,
                              //     icon: Icon(
                              //       isRecording ? Icons.stop : Icons.mic,
                              //       size: 30,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ), // 사진 추가, 음성 녹음
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  width: sizeX * 0.4,
                  height: sizeY * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        child: Text(
                          "댓글 허용",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CupertinoSwitch(
                        value: _isChecked,
                        activeColor: CupertinoColors.activeGreen,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ), //댓글 허용 onoff
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  width: sizeX * 0.4,
                  height: sizeY * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Text(
                          "오늘 일기 공유",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      CupertinoSwitch(
                        value: _isCheckedShare,
                        activeColor: CupertinoColors.activeGreen,
                        onChanged: (bool? value) {
                          setState(() {
                            _isCheckedShare = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ), //오늘 일기 공유 onoff
              ],
            ),
          ],
        ),
      ),
    );
  }
}
