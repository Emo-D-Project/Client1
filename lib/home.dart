import 'package:capston1/writediary.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'models/Diary.dart';
import 'network/api_manager.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';
import 'package:geolocator/geolocator.dart';
import 'WeeklySummary.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

DateTime now = DateTime.now();

class _homeState extends State<home> {
  ApiManager apiManager = ApiManager().getApiManager();
  List<Diary> diaries = [];
  String emotionToday = ''; // late 키워드를 사용해 초기화를 뒤로 미룸
  int lat=0;
  int lon=0;
  String weather='';
  String day = DateFormat.E('ko_KR').format(now);
  List<Diary> _diaryInfo = [];
  bool _myDiaryExists = false;

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
    checkMyDiaryExists();
  }

  Future<void> fetchMyDataFromServer() async {
    try {
      final diaryData = await apiManager.getDiaryData();

      setState(() {
        _diaryInfo = diaryData;
      });
    } catch (error) {
      print('Error fetching data: ${error.toString()}');
    }
  }

  //오늘 본인일기 있는지 확인
  Future<void> checkMyDiaryExists() async {
    try {
      await fetchMyDataFromServer();
      // 오늘 작성한 본인의 일기가 있는지 확인
      bool myDiaryExists = _diaryInfo.any((diary) =>
      DateFormat('yyyy년 MM월 dd일').format(diary.date) == formattedDate);

      setState(() {
        _myDiaryExists = myDiaryExists; // 필드 설정
      });

      if (_myDiaryExists) {
        print('home : 오늘 작성한 본인의 일기가 있습니다.');
      } else {
        print('home : 오늘 작성한 본인의 일기가 없습니다.');
      }
    } catch (error) {
      print('Error checking my diary existence: $error');
    }
  }

  String getTime() {
    int time = DateTime.now().hour; // 시간 값을 얻어옵니다.
    String timeValue = ''; // 시간 값을 저장할 변수를 선언합니다.

    if (time >= 1 && time <= 5) {
      timeValue = '새벽';
    } else if (time >= 6 && time <= 11) {
      timeValue = '아침';
    } else if (time >= 12 && time <= 16) {
      timeValue = '점심';
    } else if (time >= 17 && time <= 21) {
      timeValue = '저녁';
    } else if (time >= 22 || time == 0) {
      timeValue = '밤';
    }

    print("현재 시각 : $time");
    print("현재 시간대 : $timeValue");

    return timeValue; // 시간 값을 반환합니다.
  }

  String getBackgroundImage(String timeValue) {
    switch (timeValue) {
      case '새벽':
        return 'images/background/dawm.jpeg';
      case '아침':
        return 'images/background/morning.jpeg';
      case '점심':
        return 'images/background/lunch.jpeg';
      case '저녁':
        return 'images/background/evening.jpeg';
      case '밤':
        return 'images/background/midnight.jpeg';
      default:
        return 'images/background/morning.jpeg';
    }
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.latitude as int;
    lon = location.longitude as int;
    print(location.latitude);
    print(location.longitude);
  }

  String getWeatherImage(String weatherValue) {
    switch (weatherValue) {
      case '없음':
        return 'images/weather/transparency.png';
      case '눈':
        return 'images/weather/snow.gif';
      case '비':
        return 'images/weather/rain.gif';
      default:
        return 'images/weather/transparency.png';
    }
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getDiaryShareData();
      int myId = await ApiManager().getApiManager().GetMyId() as int;
      LoginedUserInfo.loginedUserInfo.id = myId;
      print("현재 내 아이 ${LoginedUserInfo.loginedUserInfo.id}");

      setState(() {
        diaries = data; // fetchDataFromServer()가 완료된 후에 감정을 설정함
        emotionToday = diaries
            .firstWhere(
              (diary) =>
                  diary.date.year == now.year &&
                  diary.date.month == now.month &&
                  diary.date.day == now.day &&
                  diary.userId == LoginedUserInfo.loginedUserInfo.id,
              orElse: () => Diary(
                is_share: true,
                is_comm: true,
                imagePath: [],
                date: DateTime.now(),
                content: '',
                emotion: 'calmness', // 기본 감정 설정
              ),
            ).emotion;
      });
    } catch (error) {
      // 에러 제어하는 부분
      print('Error getting share diaries list: $error');
    }
  }

  Future<void> fetchWeatherDataFromServer() async {
    try {
      final data = await apiManager.getWeatherData(lat, lon);

      setState(() {
        weather = data;
      });
    } catch (error) {
      print('Error getting chat list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("emotionToday: $emotionToday");
    print("요일 : $day");

    if (emotionToday == null) {
      return CircularProgressIndicator(); // 데이터를 기다리는 동안 로딩 표시
    }

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getBackgroundImage(getTime())),
          fit: BoxFit.cover
        )
      ),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(getWeatherImage(weather)),
                fit: BoxFit.cover
            )
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.fromLTRB(0, 200, 0, 0),
            child: Stack(
              children: [
                SizedBox(
                    child: (() {
                  switch (emotionToday) {
                    case 'flutter':
                      return Image.asset(
                        'images/main/flutter.gif',
                        width: 1200,
                        height: 1000,
                        fit: BoxFit.contain,
                      );
                    case 'angry':
                      return Image.asset(
                        'images/main/angry.gif',
                        width: 1200,
                        height: 1000,
                        fit: BoxFit.contain,
                      );
                    case 'annoying':
                      return Image.asset(
                        'images/main/anoying.gif',
                        width: 1200,
                        height: 1000,
                        fit: BoxFit.contain,
                      );
                    case 'smile':
                      return Image.asset(
                        'images/main/smile.gif',
                        width: 1200,
                        height: 1000,
                        fit: BoxFit.contain,
                      );
                    case 'tired':
                      return Image.asset(
                        'images/main/tired.gif',
                        width: 1200,
                        height: 1000,
                        fit: BoxFit.contain,
                      );
                    case 'calmness':
                      return Image.asset(
                        'images/main/catmovereal.gif',
                        width: 1200,
                        height: 1000,
                        fit: BoxFit.contain,
                      );
                    case 'sad':
                      return Image.asset(
                        'images/main/sad.gif',
                        width: 1200,
                        height: 1000,
                        fit: BoxFit.contain,
                      );
                    default:
                      return Container();
                  }
                }())),
                Container(
                  child: day == "일" ? Positioned(
                    top: 450,
                    left: 150,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0.0,
                          backgroundColor: Color(0xFFF8F5EB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => weeklySummary()));
                        },
                        child: Text("이번주 요약 보기",style: TextStyle(color: Colors.black, fontFamily: 'kim',),)
                    ),
                  ):Container()
                )
              ],
            ),
          ),
          floatingActionButton: Builder(builder: (context) {
            return Container(
              child: _myDiaryExists == false ? FloatingActionButton(
                backgroundColor: Color(0xFFD2C6BC),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            backgroundColor: Colors.transparent,
                            child: Container(
                              width: 250,
                              height: 270,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Color(0xFFF8F5EB),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                    child: Image.asset(
                                      'images/emotion/pinkfootprint.png',
                                      width: 60,
                                      height: 60,
                                    ),
                                  ), //냥발바닥
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                                    child: Text(
                                      "오늘의 감정을 선택해주세요.",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'fontnanum'),
                                    ),
                                  ), //오늘의 감정을 선택해주세요
                                  SizedBox(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            iconSize: 40,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => writediary(
                                                            emotion: 'smile',
                                                          )));
                                            },
                                            icon: Image.asset(
                                              'images/emotion/smile.gif',
                                              width: 50,
                                              height: 50,
                                            )),
                                        IconButton(
                                            iconSize: 40,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => writediary(
                                                            emotion: 'flutter',
                                                          )));
                                            },
                                            icon: Image.asset(
                                                'images/emotion/flutter.gif')),
                                        Container(
                                          child: IconButton(
                                              iconSize: 40,
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            writediary(
                                                              emotion: 'angry',
                                                            )));
                                              },
                                              icon: Image.asset(
                                                  'images/emotion/angry.png')),
                                        )
                                      ],
                                    ),
                                  ), //감정 첫째줄
                                  SizedBox(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            iconSize: 40,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => writediary(
                                                            emotion: 'annoying',
                                                          )));
                                            },
                                            icon: Image.asset(
                                                'images/emotion/annoying.gif')),
                                        IconButton(
                                            iconSize: 40,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => writediary(
                                                            emotion: 'tired',
                                                          )));
                                            },
                                            icon: Image.asset(
                                                'images/emotion/tired.gif')),
                                        IconButton(
                                            iconSize: 40,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => writediary(
                                                            emotion: 'sad',
                                                          )));
                                            },
                                            icon:
                                                Image.asset('images/emotion/sad.gif')),
                                        IconButton(
                                            iconSize: 40,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => writediary(
                                                            emotion: 'calmness',
                                                          )));
                                            },
                                            icon: Image.asset(
                                                'images/emotion/calmness.gif'))
                                      ],
                                    ),
                                  ), //감정 둘째줄
                                ],
                              ),
                            ),
                        );
                      });
                },
                child: Image.asset(
                  'images/emotion/footprint.png',
                  width: 40,
                  height: 40,
                ),
              ):Container()
            );
          }),
        ),
      ),
    );
  }
}

class Location {
  double latitude = 0;
  double longitude = 0;

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    // print(permission);
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}