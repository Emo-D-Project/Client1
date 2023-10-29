import 'package:flutter/material.dart';

class diaryshare extends StatelessWidget {
  const diaryshare({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLiked = false;
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
                  value: '최신순',
                  items: <String>['최신순', '오래된순', '추천순'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                  underline: Container(
                    height: 2,
                    color: Colors.brown,
                  ),
                  dropdownColor: Color(0xFFF8F5EB),
                  // 드롭다운 메뉴의 배경색
                  icon: Icon(Icons.arrow_drop_down, color: Colors.brown),
                  // 드롭다운 화살표 아이콘 색상
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(width: 25),
              ],
            ),
          ),

          //감정 아이콘
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
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
                Container(
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
                Container(
                  width: 37,
                  height: 37,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.fromLTRB(8, 0, 8, 7),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/emotion/3.gif'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
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
                Container(
                  width: 37,
                  height: 37,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    //    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('images/emotion/5.gif'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
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
                Container(
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
              ],
            ),
            //color: Color.fromRGBO(248, 245, 235, 100),
            width: 1000,
            height: 70,
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
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    //margin으로 감정 아이콘 중간으로 오게 함. 35는 보내기 너비만큼 줌
                                    margin: EdgeInsets.only(left: 35),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('images/emotion/1.gif'),
                                        fit: BoxFit.contain,
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
                                  '하늘도 너무 이뻤다!',
                                  // overflow:TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16),
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
                      //좋아요
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Column(
                          children: [
                            Icon(Icons.favorite_border),
                            SizedBox(
                              width: 9,
                            ),
                            // 좋아요 숫자
                            Text(
                              '10', // 좋아요 숫자를 여기에 넣으세요.
                              style: TextStyle(fontSize: 12),
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
                              child: Icon(Icons.chat_outlined),
                            ),
                            SizedBox(
                              width: 9,
                            ),
                            //댓글 숫자
                            Text(
                              '3', //
                              style: TextStyle(fontSize: 12),
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
                                  child: Container(
                                    width: 33,
                                    height: 33,
                                    //margin으로 감정 아이콘 중간으로 오게 함. 35는 보내기 너비만큼 줌
                                    margin: EdgeInsets.only(left: 35),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('images/emotion/6.gif'),
                                        fit: BoxFit.contain,
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
                        //좋아요
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                          child: Column(
                            children: [
                              Icon(Icons.favorite_border),
                              SizedBox(
                                width: 9,
                              ),
                              // 좋아요 숫자
                              Text(
                                '10', // 좋아요 숫자를 여기에 넣으세요.
                                style: TextStyle(fontSize: 12),
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
                                child: Icon(Icons.chat_outlined),
                              ),
                              SizedBox(
                                width: 9,
                              ),
                              //댓글 숫자
                              Text(
                                '3', //
                                style: TextStyle(fontSize: 12),
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
    isScrollControlled: true,
    builder: (BuildContext context) {
      //흰색 창
      return Container(
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
                      color: Colors.grey,
                      height: 450, //댓글창 컨테이너 크기
                      width: double.infinity, // 가득 차도록 설정
                      child: Column(
                        children: [
                          SizedBox(
                            height: 450, //댓글창 컨테이너 크기
                            width: double.infinity, // 가득 차도록 설정
                            child: Column(
                            children: [
                          //댓글 1
                          Container(
                            height: 80, // 원하는 높이로 설정
                            width: double.infinity, // 가득 차도록 설정
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.red, //임시 빨간색
                                  height: 60,
                                  width: 60, // 원하는 너비로 설정
                                  child: Image.asset(
                                    'images/emotion/1.gif',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      // 첫 번째 컨테이너 색상 (초록색으로 설정)
                                      height: 25,
                                      // 원하는 높이로 설정
                                      child: Text(
                                        ' 삼냥이 1',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.blue,
                                      // 두 번째 컨테이너 색상 (파란색으로 설정)
                                      height: 55,
                                      // 원하는 높이로 설정
                                      child: Text(
                                        ' 우와 라멘 맛있겠다 저기는 어디야?',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          //댓글2
                          Container(
                            height: 80, // 원하는 높이로 설정
                            width: double.infinity, // 가득 차도록 설정
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.deepOrange,
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    'images/emotion/4.gif',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      // 첫 번째 컨테이너 색상 (초록색으로 설정)
                                      height: 25,
                                      child: Text(
                                        ' 삼냥이 2',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.blue,
                                      // 두 번째 컨테이너 색상 (파란색으로 설정)
                                      height: 55,
                                      child: Text(
                                        ' 하늘 정말 이쁘다 사진 잘 찍는다',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                              //댓글2
                              Container(
                                height: 80, // 원하는 높이로 설정
                                width: double.infinity, // 가득 차도록 설정
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colors.deepOrange,
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(
                                        'images/emotion/4.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: Colors.green,
                                          // 첫 번째 컨테이너 색상 (초록색으로 설정)
                                          height: 25,
                                          child: Text(
                                            ' 삼냥이 2',
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          color: Colors.blue,
                                          // 두 번째 컨테이너 색상 (파란색으로 설정)
                                          height: 55,
                                          child: Text(
                                            ' 하늘 정말 이쁘다 사진 잘 찍는다',
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              //댓글2
                              Container(
                                height: 80, // 원하는 높이로 설정
                                width: double.infinity, // 가득 차도록 설정
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colors.deepOrange,
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(
                                        'images/emotion/4.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: Colors.green,
                                          // 첫 번째 컨테이너 색상 (초록색으로 설정)
                                          height: 25,
                                          child: Text(
                                            ' 삼냥이 2',
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          color: Colors.blue,
                                          // 두 번째 컨테이너 색상 (파란색으로 설정)
                                          height: 55,
                                          child: Text(
                                            ' 하늘 정말 이쁘다 사진 잘 찍는다',
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              //댓글2
                              Container(
                                height: 80, // 원하는 높이로 설정
                                width: double.infinity, // 가득 차도록 설정
                                child: Row(
                                  children: [
                                    Container(
                                      color: Colors.deepOrange,
                                      height: 60,
                                      width: 60,
                                      child: Image.asset(
                                        'images/emotion/4.gif',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          color: Colors.green,
                                          // 첫 번째 컨테이너 색상 (초록색으로 설정)
                                          height: 25,
                                          child: Text(
                                            ' 삼냥이 2',
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        Container(
                                          color: Colors.blue,
                                          // 두 번째 컨테이너 색상 (파란색으로 설정)
                                          height: 55,
                                          child: Text(
                                            ' 하늘 정말 이쁘다 사진 잘 찍는다',
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                          //댓글3
                          Container(
                            height: 80, // 원하는 높이로 설정
                            width: double.infinity, // 가득 차도록 설정
                            child: Row(
                              children: [
                                Container(
                                  color: Colors.teal,
                                  height: 60,
                                  width: 60,
                                  child: Image.asset(
                                    'images/emotion/6.gif',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      color: Colors.green,
                                      height: 25,
                                      child: Text(
                                        ' 삼냥이 3',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Container(
                                      color: Colors.blue,
                                      height: 55, // 원하는 높이로 설정
                                      child: Text(
                                        ' 아 배고프다..',
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
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
              ),

              //댓글 달 수 있는 칸
              Container(
                height: 70,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 350,
                      // padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 280,
                            height: 30,
                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text(
                              '내용을 입력해주세요',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/send/send.png'),
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
      );
    },
  );
}
