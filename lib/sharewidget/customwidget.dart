import 'package:flutter/material.dart';
import 'package:capston1/comment.dart';
import 'package:capston1/message_write.dart';

class shareData{
  final String imagePath;
  final String diaryImage;
  final String comment;
  final int favoritCount;
  final bool favoritColor;

  shareData({
    required this.imagePath,
    required this.diaryImage,
    required this.comment,
    required this.favoritColor,
    required this.favoritCount,
  });
}

class customWidget1 extends StatefulWidget {
  final String simagePath;
  final String sdiaryImage;
  final String scomment;
  final int sfavoritCount;
  final bool sfavoritColor;

  const customWidget1({super.key,
    required this.simagePath,
    required this.sdiaryImage,
    required this.scomment,
    required this.sfavoritColor,
    required this.sfavoritCount,
  });

  @override
  State<customWidget1> createState() => _customWidget1State();
}

//전역변수들
String selectedImagePath = 'images/emotion/7.gif'; // 기본은 무표정
String dynamicText = '행복한 하루입니다람지 제가 잘하고 있는게 맞나요?';
final List<String> d_imagePaths = [
  'images/send/sj3.jpg',
  'images/send/sj1.jpg',
  //'images/send/sj2.jpg',
];
//끗

class _customWidget1State extends State<customWidget1> {
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
  void plusDialog(BuildContext context) {
    final sizeY = MediaQuery.of(context).size.height;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            height: sizeY * 0.8,
            color: Color(0xFF737373),
            //

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
                                child: Image.asset(widget.sdiaryImage),
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
                          widget.scomment,
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
                            color: widget.sfavoritColor ? Colors.red : Colors.grey,
                          ),
                        ),
                        Text(
                          '${widget.sfavoritCount}',
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

