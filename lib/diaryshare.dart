import 'package:capston1/alrampage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dropbox.dart';
import 'package:capston1/network/api_manager.dart';
import 'message_write.dart';
import 'package:image_picker/image_picker.dart';



//----------------------------------------

final List<String> imagePaths = [
  'images/emotion/1.gif',
  'images/emotion/2.gif',
  'images/emotion/angry.png',
  'images/emotion/4.gif',
  'images/emotion/5.gif',
  'images/emotion/6.gif',
  'images/emotion/7.gif',
];

String selectedImagePath = 'images/emotion/7.gif'; // 기본은 무표정

final List<String> d_imagePaths = [
  'images/send/sj3.jpg',
  'images/send/sj1.jpg',
  //'images/send/sj2.jpg',
];

String dynamicText = '행복한 하루입니다람지 제가 잘하고 있는게 맞나요?';

final String start = DateTime.now().toString();
String formattedDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());

//----------------------------------------


class diaryshare extends StatefulWidget {
  diaryshare({Key? key}) : super(key: key);

  @override
  State<diaryshare> createState() => _diaryshareState();
}


// 일기 버전 1 - 그냥 텍스트만있는..

class customwidget1 extends StatefulWidget {
  const customwidget1({super.key});

  @override
  State<customwidget1> createState() => _customwidget1State();
}
class _customwidget1State extends State<customwidget1> {
  List<int> favoriteCounts = [0, 0, 0, 0, 0, 0, 0];
  List<bool> isLiked = [false, false, false, false, false, false, false];
  final List<Comment> comments = [ ]; // 댓글을 관리하는 리스트

  TextEditingController _commentController = TextEditingController();
  // 댓글 추가 기능

  // 댓글 추가 기능 댓글이 쌓이면 숫자 증가함
  int _commentCount = 1;

  void addComment(String name, String imagePath, String text) {
    setState(() {
      comments.add(Comment(name: '$name $_commentCount', imagePath: imagePath,
        text: text,
      ));
      _commentCount++;

    });
    print('보낸 사람: $name $_commentCount, 전송 메세지: $text');

  }

  //댓글 부분
  void plusDialog(BuildContext context) {
    final sizeY = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // 키보드가 나타날 때 텍스트 필드가 상단으로 이동
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            height: sizeY * 0.8,
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 100,
                      height: 5,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                      color: Color.fromRGBO(117, 117, 117, 100),
                    ),
                  ), // 맨위에 회색 줄
                  //댓글 부분
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      Comment comment = comments[index];
                      return Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Image.asset(
                                comment.imagePath,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Text(
                                      comment.name,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF7D5A50),
                                        fontFamily: 'soojin',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                    child: Text(
                                      comment.text,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'soojin',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  //댓글 달 수 있는 칸
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          //color: Colors.cyan,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: 350,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: [
                                    Container(
                                      width: 280,
                                      height: 30,
                                      padding: EdgeInsets.fromLTRB(
                                          10, 15, 0, 0),
                                      child: TextField(
                                        controller: _commentController,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontFamily: 'soojin',
                                        ),
                                        decoration: InputDecoration(
                                          hintText: '내용을 입력해주세요', // 힌트 텍스트 추가
                                          hintStyle: TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        String commentText = _commentController
                                            .text;
                                        if (commentText.isNotEmpty) {
                                          // 댓글 추가 메서드 호출
                                          addComment('삼냥이', 'images/emotion/1.gif',
                                              commentText);
                                          // 텍스트 필드 비우기
                                          _commentController.clear();
                                        }
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        margin: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/send/real_send.png'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
                Container(
                  width: 380,
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              width: 35,
                              height: 35,
                              margin: EdgeInsets.only(left: 35),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(selectedImagePath),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          )),

                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => message_write()
                            ),
                          );
                        },
                        icon: Image.asset(
                          'images/send/real_send.png',
                          height: 50, // 이미지 높이 조절
                          width: 30, // 이미지 너비 조절
                        ),
                      ),
                    ],
                  ),
                ),
                //이미지
                SingleChildScrollView(
                  child: Container(
                      width: 200,
                      height: 150, // 이미지 높이 조절
                      child: Container(
                        child: PageView.builder( //listview로 하면 한장씩 안넘어가서 페이지뷰함
                          scrollDirection: Axis.horizontal,
                          itemCount: d_imagePaths.length > 3 ? 3 : d_imagePaths
                              .length, // 최대 3장까지만 허용
                          itemBuilder: (context, index) {
                            return Container(
                              child: Center(
                                child: Image.asset(d_imagePaths[index]),
                              ),
                            );
                          },
                        ),
                      )
                  ),
                ),
                //텍스트
                Container(
                    width: 380,
                    padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                    color: Colors.white54,
                    child: Column(
                      children: [
                        Text(
                          dynamicText,
                          style: TextStyle(fontSize: 15, fontFamily: 'soojin'),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )),
              ],
            ),
          ),
          //좋아요,댓글
          Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isLiked[0]) {
                                favoriteCounts[0]--;
                              } else {
                                favoriteCounts[0]++;
                              }
                              isLiked[0] = !isLiked[0];
                            });
                          },
                          onLongPress: () {},
                          child: Icon(
                            Icons.favorite,
                            color: isLiked[0] ? Colors.red : Colors.grey,
                          ),
                        ),
                        Text(
                          '${favoriteCounts[0]}',
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),

                  //댓글
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            plusDialog(context);
                          },
                          child:
                          Icon(Icons.chat_outlined, color: Colors.grey),
                        ),
                        //댓글 숫자
                        Text(
                          '6', //
                          style: TextStyle(fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

}

  class Comment {
  final String name;
  final String imagePath;
  final String text;

  Comment({required this.name, required this.imagePath, required this.text});
}


class _diaryshareState extends State<diaryshare> {
  //----------------------------------------------------------
  ApiManager apiManager = ApiManager().getApiManager();

  Future<void> GetDiaryShare(String endpoint) async {
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

  Future<void> PostDiaryShare(String endpoint) async {
    ApiManager apiManager = ApiManager().getApiManager();

    try {
      final postData = {
        //보낼 변수 넣기
      };

      print(postData);

      //await apiManager.post(endpoint, postData); // 실제 API 엔드포인트로 대체
    } catch (e) {
      print('Error: $e');
    }
  }

  //-----------------------------------------------------------

  List<int> favoriteCounts = [0, 0, 0, 0, 0, 0, 0];
  List<bool> isLiked = [false, false, false, false, false, false, false];
  String selectedValue = '최신순';

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Container(
      color: Color(0xFFF8F5EB),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 드롭박스
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                DropdownButton<String>(
                  value: selectedValue,
                  // 현재 선택된 값
                  items: <String>['최신순', '추천순'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedValue = value!; // 선택된 값 업데이트
                    });
                  },
                  underline: Container(
                    height: 2,
                    color: Colors.brown,
                  ),
                  dropdownColor: Color(0xFFF8F5EB),
                  icon: Icon(Icons.arrow_drop_down, color: Colors.brown),
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 25),
              ],
            ),
          ),

          //날짜
          Container(
            //   margin: EdgeInsets.fromLTRB(0, 20, 120, 20),
            child: Text(
              formattedDate,
              style: TextStyle(
                color: Color(0xFF7D5A50),
                fontSize: 17,
                fontWeight: FontWeight.w900,
                fontFamily: 'soojin',
              ),
            ), //날짜
          ),

          //감정 아이콘
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: ClampingScrollPhysics(),
            child: Row(
              children: imagePaths.map((path) {
                return Padding(
                  padding: EdgeInsets.all(3),
                  child: IconButton(
                    icon: Image.asset(
                      path,
                      width: 50,
                      height: 50,
                    ),
                    onPressed: () {
                      setState(() {
                        selectedImagePath = path; // 선택한 아이콘의 경로로 변경
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),

          customwidget1()
        ],
      ),
    );
  }
}
