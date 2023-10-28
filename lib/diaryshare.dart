import 'package:flutter/material.dart';

class diaryshare extends StatelessWidget {
  const diaryshare({super.key});


  @override

  Widget build(BuildContext context) {
    bool isLiked = false;
    final sizeX = MediaQuery
        .of(context)
        .size
        .width;
    final sizeY = MediaQuery
        .of(context)
        .size
        .height;
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
              items: <String>['최신순', '오래된순', '추천순']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
                  .toList(),
              onChanged: (String? newValue) {},
              underline: Container(  // 이 부분을 추가해서 드롭박스의 테두리를 설정합니다.
                height: 2,
                color: Colors.brown, // 테두리 선 색을 검정으로 설정
              ),
                dropdownColor: Color(0xFFF8F5EB), // 드롭다운 메뉴의 배경색
                icon: Icon(Icons.arrow_drop_down, color: Colors.brown), // 드롭다운 화살표 아이콘 색상
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
              margin:  const EdgeInsets.fromLTRB(8, 0, 8, 7),
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
                                image: AssetImage(
                                    'images/emotion/1.gif'),
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
                              image: AssetImage(
                                  'images/send/send.png'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: PageView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        _buildPolaroid('images/send/sj3.jpg', '사진 1'),
                        _buildPolaroid('images/send/sj1.jpg', '사진 2'),
                        _buildPolaroid('images/send/sj2.jpg', '사진 3'),
                      ],
                    ),
                  ),
                ),


                // 텍스트 컨테이너
                Container(
                    width: 380,
                    padding:
                    const EdgeInsets.fromLTRB(35, 10, 35, 10),
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
                                image: AssetImage(
                                    'images/emotion/6.gif'),
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
                              image: AssetImage(
                                  'images/send/send.png'),
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
                      borderRadius: BorderRadius.all(Radius.circular(15))),
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
                    padding:
                    const EdgeInsets.fromLTRB(35, 10, 35, 10),
                    color: Colors.white54,
                    child: Column(
                      children: [
                        Text(
                          '안녕하세요 저는 오늘 하루 너무 힘이 드네요.. 위로가 필요한 하루입니다..'
                              '힘이 너무 들어요 넘무 울고싶어요.. 모든게 제 마음대로 되는게 없어요'
                              '으아아ㅏ아아아아앙 ',
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
            ),
          ),
            ],
          ),
        ),
      )],
      ),
    );
  }
}

Widget _buildPolaroid(String imagePath, String text) {
  return Container(
    margin: EdgeInsets.all(10), // 폴라로이드 간격 조절
    decoration: BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black, // 액자 색상
              width: 5, // 액자 두께
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.white,
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    ),
  );
}

