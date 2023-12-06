import 'package:capston1/writediary.dart';
import 'package:flutter/material.dart';
import 'models/Diary.dart';
import 'network/api_manager.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';


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

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getDiaryShareData();

      setState(() {
        diaries = data; // fetchDataFromServer()가 완료된 후에 감정을 설정함
        emotionToday = diaries
            .firstWhere(
              (diary) =>
                  diary.date.year == now.year &&
                  diary.date.month == now.month &&
                  diary.date.day == now.day &&
                  diary.userId ==  LoginedUserInfo.loginedUserInfo.id,
              orElse: () => Diary(
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

  @override
  Widget build(BuildContext context) {
    print("emotionToday: $emotionToday");

    if (emotionToday == null) {
      return CircularProgressIndicator(); // 데이터를 기다리는 동안 로딩 표시
    }

    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      body: Center(
        child: SizedBox(
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
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
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
        );
      }),
    );
  }
}
