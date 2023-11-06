import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final String start = DateTime.now().toString();
String formattedDate = DateFormat('yyyy년 MM월 dd일').format(DateTime.now());

class diaryshare extends StatefulWidget {
  diaryshare({Key? key}) : super(key: key);

  @override
  State<diaryshare> createState() => _diaryshareState();
}

class _diaryshareState extends State<diaryshare> {
  List<int> favoriteCounts = [0, 0, 0, 0, 0, 0, 0];
  List<bool> isLiked = [false, false, false, false, false, false, false];
  String selectedValue = '최신순';
  String selectedImagePath = 'images/emotion/7.gif'; // 기본값은 무표정으로 함

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
                  items: <String>['최신순', '오래된순', '추천순'].map((String value) {
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
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w900,
                fontFamily: 'fontnanum',
              ),
            ), //날짜
          ),

          //감정 아이콘
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImagePath = 'images/emotion/1.gif';
                    });
                  },
                  child: Container(
                    width: 37,
                    height: 37,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/emotion/1.gif'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImagePath = 'images/emotion/2.gif';
                    });
                  },
                  child: Container(
                    width: 37,
                    height: 37,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/emotion/2.gif'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImagePath = 'images/emotion/3.gif';
                    });
                  },
                  child: Container(
                    width: 37,
                    height: 37,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 7),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/emotion/3.gif'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImagePath = 'images/emotion/4.gif';
                    });
                  },
                  child: Container(
                    width: 37,
                    height: 37,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/emotion/4.gif'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImagePath = 'images/emotion/5.gif';
                    });
                  },
                  child: Container(
                    width: 37,
                    height: 37,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/emotion/5.gif'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImagePath = 'images/emotion/6.gif';
                    });
                  },
                  child: Container(
                    width: 37,
                    height: 37,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/emotion/6.gif'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImagePath = 'images/emotion/7.gif';
                    });
                  },
                  child: Container(
                    width: 37,
                    height: 37,
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/emotion/7.gif'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //color: Color.fromRGBO(248, 245, 235, 100),
            width: 1000,
            height: 60,
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(5.0),
          ),

          Expanded(
            child: SingleChildScrollView(
              //scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  // 일기 화면1
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
                          color: Colors.white54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      //margin으로 감정 아이콘 중간으로 오게 함. 35는 보내기 너비만큼 줌
                                      margin: EdgeInsets.only(left: 35),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(selectedImagePath),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // 쪽지 보내기 아이콘
                              Container(
                                child: Container(
                                  width: 33,
                                  height: 33,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('images/send/send.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SingleChildScrollView(
                          child: Container(
                            width: 200,
                            height: 150, // 이미지 높이 조절
                            child: PageView(
                              scrollDirection: Axis.horizontal, // 수평으로 스크롤
                              children: <Widget>[
                                Container(
                                  child: Center(
                                      child:
                                          Image.asset('images/send/sj3.jpg')),
                                ),
                                Container(
                                  child: Center(
                                      child:
                                          Image.asset('images/send/sj1.jpg')),
                                ),
                                Container(
                                  child: Center(
                                      child:
                                          Image.asset('images/send/sj2.jpg')),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 텍스트 컨테이너
                        Container(
                            width: 380,
                            padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                            color: Colors.white54,
                            child: Column(
                              children: [
                                Text(
                                  '오늘 하루 아주 만족스러운 날이다. '
                                  '친구들이랑 맛있게 밥도 먹고'
                                  ' 하늘도 너무 이뻤다!',
                                  // overflow:TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 15),
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

                  //일기2
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
                          color: Colors.white54,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {});
                                    },
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      //margin으로 감정 아이콘 중간으로 오게 함. 35는 보내기 너비만큼 줌
                                      margin: EdgeInsets.only(left: 35),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(selectedImagePath),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              // 쪽지 보내기
                              Container(
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('images/send/send.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //녹음
                        Container(
                          width: 250, // 너비를 최대로 설정
                          height: 25,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Row(
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.black,
                              ),
                              Icon(
                                Icons.pause,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),

                        // 텍스트 컨테이너
                        Container(
                          width: 380,
                          padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                          color: Colors.white54,
                          child: Column(
                            children: [
                              Text(
                                '오늘은 기분이 좋은 하루네요~~ 굳굳 ',
                                // overflow:TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
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
                                    isLiked[1] = !isLiked[1];
                                    if (isLiked[1]) {
                                      favoriteCounts[1]++;
                                    } else {
                                      favoriteCounts[1]--;
                                    }
                                  });
                                },
                                onLongPress: () {},
                                child: Icon(
                                  Icons.favorite,
                                  color: isLiked[1] ? Colors.red : Colors.grey,
                                ),
                              ),
                              Text(
                                '${favoriteCounts[1]}',
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
                                child: Icon(
                                  Icons.chat_outlined,
                                  color: Colors.grey,
                                ),
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
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// 댓글 기능 누르면 뜨는 창
void plusDialog(BuildContext context) {
  final sizeY = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // 키보드가 나타날 때 텍스트 필드가 상단으로 이동
    builder: (BuildContext context) {
      return SingleChildScrollView(
        child: Container(
          //키보드가 나타날 때 텍스트 필드가 상단으로 이동
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              //댓글 1
                              Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 60,
                                      height: 60,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Image.asset(
                                        'images/emotion/5.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '삼냥이 1',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '난 오늘 너무 힘든 하루였어..',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              //댓글 2
                              Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Image.asset(
                                        'images/emotion/6.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '삼냥이 2',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '우와 나 라멘 진짜 좋아하는데!! 저기 맛있겠다 저기는 어디야?'
                                              '   하.. 갑자기 또 라멘 먹고싶네'
                                              ' 일본 갔다올게'
                                              'ㅇㅇㅇㅇㅇㅇ'
                                              'ㅇㅇㅇㅇ'
                                              'ㅇㅇㅇㅇㅇ',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              //댓글 3
                              Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Image.asset(
                                        'images/emotion/7.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '삼냥이 3',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '난 오늘 일한다고 하늘을 한번도 못봤어ㅜ',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              //댓글 4
                              Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Image.asset(
                                        'images/emotion/2.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '삼냥이 4',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '하늘 정말 이쁘다 그리고 너 사진 잘 찍는당'
                                              '. 휴대폰 기종이 뭐야? '
                                              '쪽지 보낼게!!',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              //댓글 5
                              Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Image.asset(
                                        'images/emotion/2.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '삼냥이 5',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '아 배고파 ..',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              //댓글 6
                              Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Image.asset(
                                        'images/emotion/4.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '삼냥이 6',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '나도 한식 잘 먹는데',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              //댓글 7
                              Container(
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 60,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      child: Image.asset(
                                        'images/emotion/3.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '삼냥이 7',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.brown),
                                            ),
                                          ),
                                          Container(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 3, 0, 0),
                                            child: Text(
                                              '나랑 같은 곳이였나보네 ',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //댓글 달 수 있는 칸
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 70,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 280,
                                    height: 30,
                                    padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                                    child: TextField(
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: '내용을 입력해주세요', // 힌트 텍스트 추가
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 30,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('images/send/send.png'),
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
