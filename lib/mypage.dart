import 'package:capston1/models/MyInfo.dart';
import 'package:flutter/material.dart';
import 'category.dart';
import 'models/Mypage.dart';
import 'network/api_manager.dart';
import 'models/Diary.dart';
import 'diaryshare.dart';


class mypage extends StatefulWidget {
  final int userId;  //일기 공유에서

  const mypage({super.key,required this.userId});

  @override
  State<mypage> createState() => _mypageState(userId);
}


final _contentEditController = TextEditingController(); //소개답변 저장 변수
final _answerEditController = TextEditingController(); //질문에 대한 답변 저장 변수

class _mypageState extends State<mypage> {

  ApiManager apiManager = ApiManager().getApiManager();
 // ApiManager apiManager = ApiManager().GetOtherUserPage(id);

  int userId;

  late String title;
  late String content;
  late String tititle;

  List<Mypage> myPageDatas = [];
  List<Mypage> otherPageDatas = [];


  //List<Mypage> otherPageDatas = [];
  //String login = "mine"; // 내 로그인 정보 담아두고
  //String mine = "mine"; // 버튼 누른 사람의 정보를 담아서  비교하면 내가 원하는대로 되려나

  List<Map<String, dynamic>> mypages = [];

  _mypageState(this.userId);

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }



  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.GetMyPageDataById(userId);
      final otherData = await apiManager.getMypageData();


      setState(() {
        myPageDatas = data!;
        otherPageDatas = otherData!;

      });
    } catch (error) {
      print('Error getting MP list: $error');
    }
  }


  void _sendMyPage() {
    String title = tititle;
    String content = _answerEditController.text;
    apiManager.sendMypage(title, content);
    _answerEditController.clear();

    Navigator.of(context).pop();
  }


  //질문 선택 창
  void plusDialog(context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: sizeY * 0.5,
          color: Color(0xFF737373),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 130,
                    height: 5,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                    color: Color.fromRGBO(117, 117, 117, 100),
                  ),
                  SizedBox(
                    child: Text(
                      "질문 선택",
                      style: TextStyle(
                          color: Color(0xFF7D5A50),
                          fontSize: 14,
                          fontFamily: 'soojin'),
                    ),
                  ),
                  Container(
                    //칸 나누는 줄
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    color: Colors.black54,
                    width: sizeX, height: 1,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDialog(context, "최애 영화");
                      tititle = "최애 영화";
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                    ),
                    child: Text('최애 영화',
                        style: TextStyle(
                            color: Color(0xFF7D5A50),
                            fontSize: 15,
                            fontFamily: 'soojin')),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDialog(context, "최애 노래");
                      tititle = "최애 노래";
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                    ),
                    child: Text("최애 노래",
                        style: TextStyle(
                            color: Color(0xFF7D5A50),
                            fontSize: 15,
                            fontFamily: 'soojin')),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDialog(context, "MBTI");
                      tititle = "MBTI";
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                    ),
                    child: Text("MBTI",
                        style: TextStyle(
                            color: Color(0xFF7D5A50),
                            fontSize: 15,
                            fontFamily: 'soojin')),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDialog(context, "최애 드라마");
                      tititle = "최애 드라마";
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                    ),
                    child: Text("최애 드라마",
                        style: TextStyle(
                            color: Color(0xFF7D5A50),
                            fontSize: 15,
                            fontFamily: 'soojin')),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showDialog(context, "최애 색깔");
                      tititle = "최애 색깔";
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Colors.white,
                    ),
                    child: Text("최애 색깔",
                        style: TextStyle(
                            color: Color(0xFF7D5A50),
                            fontSize: 15,
                            fontFamily: 'soojin')),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //질문 답변창
  Future<void> _showDialog(BuildContext context, String item) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            item,
            style: TextStyle(
              fontFamily: 'soojin',
              color: Color(0xFF7D5A50),
            ),
          ),
          content: TextField(
            style: TextStyle(fontFamily: 'soojin'),
            maxLength: 20,
            decoration: InputDecoration(
              hintText: '20자 이내로 작성해주세요.',
              hintStyle: TextStyle(fontFamily: 'soojin'),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
            ),
            controller: _answerEditController,
          ),
          actions: <Widget>[
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Color(0x4D968C83),
                    minimumSize: Size(150, 30)),
                onPressed: () => Navigator.of(context).pop(),
                child: Text('취소',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'soojin'))),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Color(0xFF7D5A50),
                    minimumSize: Size(150, 30)),
                onPressed: () async {
                  _sendMyPage(); //
                  final data = await apiManager.getMypageData();
                  setState(() {
                    myPageDatas = data!;
                  });
                }, //showContainer로 데이터 넘기기 // 디비에 저장하기
                child: Text('확인',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'soojin'))),
          ],
        );
      },
    );
  }


  //``````````````````````````````````````````````````````````````````````````````

  @override
  Widget build(BuildContext context) {
    final SizeX = MediaQuery.of(context).size.width;
    final SizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: SizedBox(
          child: (() {
            if (userId == myPageDatas) {
              return Text(
                "MYPAGE",
                style: TextStyle(
                    color: Color(0xFF968C83), fontFamily: 'kim', fontSize: 30),
              );
            } else {
              return Text(
                "PROFILE",
                style: TextStyle(
                    color: Color(0xFF968C83), fontFamily: 'kim', fontSize: 30),
              );
            }
          })(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => category()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(10, 30, 10, 6),
              width: SizeX * 0.9,
              height: SizeY * 0.75,
              decoration: BoxDecoration(
                color: Color(0x4D968C83),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: (() {
                      if (MyInfo.myInfo.myUserId == userId) {
                        return Text(
                          "권해진 바보",
                          //myInfo.getNickName(),
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'soojin',
                              color: Color(0xFF7D5A50)),
                        );
                      } else {
                        return Text(
                          "삼냥이",
                          style: TextStyle(
                              fontSize: 28,
                              fontFamily: 'soojin',
                              color: Color(0xFF7D5A50)),
                        );
                      }
                    })(),
                  ),
                  Container(
                    //칸 나누는 줄
                    color: Colors.black54,
                    width: 300, height: 1,
                  ),
                  Container(
                    width: 300,
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: TextField(
                      controller: _contentEditController,
                      maxLength: 20,
                      decoration: InputDecoration(
                        hintText: '소개(20자 이내로 적어주세요.)',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black54,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      style: TextStyle(fontSize: 13, fontFamily: 'soojin'),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: myPageDatas.length,
                      itemBuilder: (BuildContext context, int index) {
                        if(MyInfo.myInfo.myUserId == userId){
                          return CustomQuestionContainer(
                            //답변 받는 부분
                            vquestion: myPageDatas[index].title,
                            vanswer: myPageDatas[index].content,
                          );
                        }else{
                          return CustomQuestionContainer(
                            //답변 받는 부분
                            vquestion: otherPageDatas[index].title,
                            vanswer: otherPageDatas[index].content,
                          );
                        }

                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: (() {
                      if (MyInfo.myInfo.myUserId == userId) {
                        return IconButton(
                            onPressed: () {
                              plusDialog(context);
                            },
                            icon: Icon(
                              Icons.add_circle,
                              color: Color(0xFF7D5A50),
                              size: 40,
                            ));
                      }
                    })(),
                  ),
                  /*Container(
                          width: sizeX * 0.8,
                          child: (() {
                            if (login != mine) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      singoDialog(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: Color(0x4D968C83),
                                    ),
                                    child: Text("신고",
                                        style: TextStyle(color: Color(0xFF7D5A50),
                                            fontSize: 15)),
                                  ),
                                  SizedBox(width: 5,),
                                  ElevatedButton(
                                    onPressed: () {
                                      _showchadanDialog(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0.0,
                                      backgroundColor: Color(0x4D968C83),
                                    ),
                                    child: Text("차단",
                                        style: TextStyle(color: Color(0xFF7D5A50),
                                            fontSize: 15)),
                                  ),
                                ],
                              );
                            }
                          })(),
                        )*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void singoDialog(context) {
  final sizeX = MediaQuery.of(context).size.width;
  final sizeY = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: 1000,
        color: Color(0xFF737373),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                  width: 130,
                  height: 5,
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                  color: Color.fromRGBO(117, 117, 117, 100),
                ),
                SizedBox(
                  child: Text(
                    "신고 사유 선택",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: 'fontnanum'),
                  ),
                ),
                Container(
                  //칸 나누는 줄
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  color: Colors.black54,
                  width: sizeX, height: 1,
                ),
                ElevatedButton(
                  onPressed: () {
                    _showsingoDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("욕설 / 비하",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showsingoDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("음란물 / 불건전한 만남 및 대화",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showsingoDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("상업적 광고 및 판매",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showsingoDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("낚시 / 도배",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showsingoDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("유출 / 사기 / 사칭",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showsingoDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("기타",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<dynamic> _showsingoDialog(BuildContext context) {
  final sizeY = MediaQuery.of(context).size.height;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(' '),
      content: SizedBox(
          height: sizeY * 0.05, child: Center(child: Text("정말 신고 하시겠습니까?"))),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.amber,
                minimumSize: Size(150, 30)),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소',
                style: TextStyle(color: Colors.black, fontSize: 20))),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.blue,
                minimumSize: Size(150, 30)),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('확인',
                style: TextStyle(color: Colors.black, fontSize: 20))),
      ],
    ),
  );
}

Future<dynamic> _showchadanDialog(BuildContext context) {
  final sizeY = MediaQuery.of(context).size.height;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(' '),
      content: SizedBox(
        height: sizeY * 0.07,
        child: Center(
          child: Text("쪽지 수신 및 발신이 모두 차단되며, 다시 해제하실 수 없습니다"),
        ),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.amber,
                minimumSize: Size(150, 30)),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소',
                style: TextStyle(color: Colors.black, fontSize: 20))),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Colors.blue,
                minimumSize: Size(150, 30)),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('확인',
                style: TextStyle(color: Colors.black, fontSize: 20))),
      ],
    ),
  );
}

class CustomQuestionContainer extends StatelessWidget {
  final String vquestion;
  final String vanswer;

  CustomQuestionContainer({
    super.key,
    required this.vquestion,
    required this.vanswer,
  });

  @override
  Widget build(BuildContext context) {
    final SizeX = MediaQuery.of(context).size.width;
    final SizeY = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      height: SizeY * 0.08,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Text(
                vquestion,
                style: TextStyle(
                    fontFamily: 'soojin',
                    fontSize: 17,
                    color: Color(0xFF7D5A50)),
              ),
            ],
          ),
          Container(
            //칸 나누는 줄
            color: Colors.grey,
            width: SizeX * 0.8, height: 1,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
          ),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Text(
                vanswer,
                style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'soojin',
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
