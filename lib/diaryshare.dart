import 'package:flutter/material.dart';

class diaryshare extends StatelessWidget {
  const diaryshare({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: sizeX,
            height: sizeY,
            //감정 아이콘
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/emotion/1.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/emotion/2.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/emotion/3.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/emotion/4.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/emotion/5.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/emotion/6.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('images/emotion/7.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //color: Color.fromRGBO(248, 245, 235, 100),
                  width: 1000,
                  height: 65,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                ),

                // 일기 화면1
                Container(
                  color: Colors.white,
                  width: 1000,
                  height: 300,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  //decoration: BoxDecoration(
                    //  borderRadius: BorderRadius.all(Radius.circular(15))
                 // ),
                  child: Column(
                    children: [
                      Container(
                        width: 1000,
                        height: 65,
                        color: Colors.white54,
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage('images/emotion/6.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(), // 여백을 추가합니다.
                            // 쪽지 보내기 아이콘
                            Container(
                              //  color: Colors.blue, // 배경색을 파란색으로 지정
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.question_answer_outlined,
                                  color: Colors.black26, // 아이콘 색상을 흰색으로 지정
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 텍스트 컨테이너
                      Container(
                        padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                        color: Colors.white54,

                        child: Text(
                          '안녕 예원아 해진아 나는 수진이야... '
                          ' 나 너무 어렵고 힘들어 이게 맞니?  '
                          ' 아이콘이 뭔 짓을 해도 중간에 안와서 '
                          '너무 화가 나ㅜ  '
                          '배경색들은 컨테이너 구분되게 볼려고  '
                          '잠시 넣어놨어 오해말아줘',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                        width: 500,
                        // 너비를 800으로 설정
                        height: 200, // 높이를 100으로 설정
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
                          Icon(Icons.chat_outlined),
                          SizedBox(
                            width: 9,
                          ),
                          //댓글 숫자
                          Text(
                            '10', // 좋아요 숫자를 여기에 넣으세요.
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),

                //일기2
                Container(
                  color: Colors.white,
                  width: 1000,
                  height: 300,
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        width: 1000,
                        height: 65,
                        color: Colors.white54, // 배경색을 흰색으로 지정
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage('images/emotion/6.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(), // 여백을 추가합니다.
                            Container(
                              //  color: Colors.blue, // 배경색을 파란색으로 지정
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.question_answer_outlined,
                                  color: Colors.black26, // 아이콘 색상을 흰색으로 지정
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 텍스트 컨테이너
                      Container(
                        padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                        color: Colors.white60,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity, // 너비를 최대로 설정
                              height: 30,
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              // 높이를 30으로 설정 (원하는 높이로 조절하세요)
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
                            SizedBox(height: 10), // 여백 추가 (원하는 크기로 조절하세요)
                            Text(
                              '안녕하십니까 수쟌입니다.이게 5시간 넘게 한 '
                              '저의 결과물입니다. 이건 녹음 버전 ㅋ '
                              '시간대비 결과물이 처참하네요',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        width: 500,
                        height: 200,
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
                          Icon(Icons.chat_outlined),
                          SizedBox(
                            width: 9,
                          ),
                          //댓글 숫자
                          Text(
                            '10', // 좋아요 숫자를 여기에 넣으세요.
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
              ],
            )),
      ),
    );
  }
}
