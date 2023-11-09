import 'package:capston1/MyInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'category.dart';
import 'network/api_manager.dart';

class mypage extends StatefulWidget {
  const mypage({super.key, this.item1});

  final item1;

  @override
  State<mypage> createState() => _mypageState();
}

final _contentEditController = TextEditingController(); //소개답변 저장 변수
final _answerEditController = TextEditingController(); //질문에 대한 답변 저장 변수

List question = ['최애 영화', '최애 노래', '최애 드라마', '취미', 'MBTI'];
List answer = [null, null, null, null, null];

class _mypageState extends State<mypage> {
  //-------------------------------------------------------------------------------
  ApiManager apiManager = ApiManager().getApiManager();
  String login = "mine"; // 내 로그인 정보 담아두고
  String mine = "mine"; // 버튼 누른 사람의 정보를 담아서   비교하면 내가 원하는대로 되려나
  //String another = "another";

  Future<void> GetMyPage(String endpoint) async {
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

  /*Future<void> PostMyPage(String endpoint) async {
    ApiManager apiManager = ApiManager().getApiManager();

    try {
      final postData = {

      };

      print(postData);

      await apiManager.post(endpoint, postData); // 실제 API 엔드포인트로 대체
    } catch (e) {
      print('Error: $e');
    }
  }*/
  //-------------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    print("item1 ${widget.item1}");
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    MyInfo myInfo = MyInfo().getMyInfo();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: SizedBox(
          child: (() {
            if (login == mine) {
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 6),
                width: sizeX * 0.9,
                height: sizeY * 0.75,
                decoration: BoxDecoration(
                  color: Color(0x4D968C83),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: (() {
                            if (login == mine) {
                              return Text(
                                "해지니",
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
                            style:
                                TextStyle(fontSize: 13, fontFamily: 'soojin'),
                          ),
                        ),
                        SizedBox(
                          width: 300,
                          //height: 430,
                          child: Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                //width: sizeX * 0.9,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  color: Colors.transparent,
                                  width: 300,
                                  height: 70,
                                  child: (() {
                                    if (widget.item1 != 0) {
                                      _showContainer(
                                        item2: widget.item1,
                                      );
                                    }
                                  })(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: (() {
                            if (login == mine) {
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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
                    if (answer[0] == null) {
                      _showDialogex(context, 0);
                    } else
                      ;
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("${question[0]}",
                      style: TextStyle(
                          color: Color(0xFF7D5A50),
                          fontSize: 15,
                          fontFamily: 'soojin')),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (answer[1] == null) {
                      _showDialogex(context, 1);
                    } else
                      ;
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("${question[1]}",
                      style: TextStyle(
                          color: Color(0xFF7D5A50),
                          fontSize: 15,
                          fontFamily: 'soojin')),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (answer[2] == null) {
                      _showDialogex(context, 2);
                    } else
                      ;
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("${question[2]}",
                      style: TextStyle(
                          color: Color(0xFF7D5A50),
                          fontSize: 15,
                          fontFamily: 'soojin')),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (answer[3] == null) {
                      _showDialogex(context, 3);
                    } else
                      ;
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("${question[3]}",
                      style: TextStyle(
                          color: Color(0xFF7D5A50),
                          fontSize: 15,
                          fontFamily: 'soojin')),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (answer[4] == null) {
                      _showDialogex(context, 4);
                    } else
                      ;
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("${question[4]}",
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

Future<dynamic> _showDialogex(BuildContext context, int item) {
  final sizeY = MediaQuery.of(context).size.height;

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) => AlertDialog(
      title: Text(
        '${question[item]}',
        style: TextStyle(
          fontFamily: 'soojin',
          color: Color(0xFF7D5A50),
        ),
      ),
      content: TextField(
        maxLength: 20,
        decoration: InputDecoration(
          hintText: '20자 이내로 작성해주세요.',
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
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Color(0x4D968C83),
                minimumSize: Size(150, 30)),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소',
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: 'soojin'))),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                backgroundColor: Color(0xFF7D5A50),
                minimumSize: Size(150, 30)),
            onPressed: () {
              String answerText = _answerEditController.text;
              //print(answerText);
              answer[item] = answerText;
              //print(question);
              //print(answer);
              Navigator.of(context).pop();
              mypage(item1: item);
              print("item: $item");
            }, //showContainer로 데이터 넘기기 // 디비에 저장하기
            child: Text('확인',
                style: TextStyle(
                    color: Colors.black, fontSize: 20, fontFamily: 'soojin'))),
      ],
    ),
  );
}

//마이페이지에 나타나는 질답컨테이너
class _showContainer extends StatelessWidget {
  const _showContainer({Key? key, this.item2}) : super(key: key);
  final item2;

  @override
  Widget build(BuildContext context) {
    print("item2 $item2");
    return Container(
      //margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: 300,
      height: 70,
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
              Container(
                child: Text(
                  "${question[item2]}",
                  style: TextStyle(
                      fontFamily: 'soojin',
                      fontSize: 17,
                      color: Color(0xFF7D5A50)),
                ),
              ),
            ],
          ),
          Container(
            //칸 나누는 줄
            color: Colors.grey,
            width: 260, height: 1,
            margin: EdgeInsets.fromLTRB(0, 5, 0, 6),
          ),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Container(
                child: Text("${answer[item2]}",
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'soojin',
                    )),
              )
            ],
          ),
        ],
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
