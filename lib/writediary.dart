import 'package:capston1/main.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class writediary extends StatefulWidget {
  const writediary({super.key, required this.emotion});

  final String emotion;

  @override
  State<writediary> createState() => _writediaryState();
}

final picker = ImagePicker();
List<XFile?> multiImage = []; // 갤러리에서 여러장의 사진을 선택해서 저장할 변수
List<XFile?> images = []; // 가져온 사진들을 보여주기 위한 변수

class _writediaryState extends State<writediary> {
  bool _isChecked = false;
  bool _isCheckedShare = false;

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFFF8F5EB),
        title: Container(
          //decoration: BoxDecoration(color: Colors.amber),
          child: (() {
            switch (widget.emotion) {
              case 'smile':
                return Image.asset(
                  'images/emotion/1.gif',
                  height: 50,
                  width: 50,
                );
              case 'flutter':
                return Image.asset(
                  'images/emotion/2.gif',
                  height: 50,
                  width: 50,
                );
              case 'angry':
                return Image.asset(
                  'images/emotion/3.gif',
                  height: 50,
                  width: 50,
                );
              case 'annoying':
                return Image.asset(
                  'images/emotion/4.gif',
                  height: 50,
                  width: 50,
                );
              case 'tired':
                return Image.asset(
                  'images/emotion/5.gif',
                  height: 50,
                  width: 50,
                );
              case 'sad':
                return Image.asset(
                  'images/emotion/6.gif',
                  height: 50,
                  width: 50,
                );
              case 'calmness':
                return Image.asset(
                  'images/emotion/7.gif',
                  height: 50,
                  width: 50,
                );
            }
          })(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.upload))],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFF8F5EB),
        ),
        child: Column(
          children: [
            Container(
              width: sizeX * 0.88,
              height: sizeY * 0.75,
              margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Container(), // 날짜
                  Container(
                    margin: EdgeInsets.all(10),
                    child: GridView.builder(
                      padding: EdgeInsets.all(0),
                      shrinkWrap: true,
                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1/1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(images[index]!.path),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ), // 일기
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: IconButton(
                            onPressed: () async {
                              multiImage = await picker.pickMultiImage();
                              setState(() {
                                images.addAll(multiImage);
                              });
                            },
                            icon: Icon(Icons.add_a_photo_outlined),
                          ),
                        ),
                      ],
                    ),
                  ), // 사진 추가, 음성 녹음
                ],
              )
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  width: sizeX * 0.4,
                  height: sizeY * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        child: Text(
                          "댓글 허용",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CupertinoSwitch(
                        value: _isChecked,
                        activeColor: CupertinoColors.activeGreen,
                        onChanged: (bool? value) {
                          setState(() {
                            _isChecked = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ), //댓글 허용 onoff
                Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  width: sizeX * 0.4,
                  height: sizeY * 0.07,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Text(
                          "오늘 일기 공유",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      CupertinoSwitch(
                        value: _isCheckedShare,
                        activeColor: CupertinoColors.activeGreen,
                        onChanged: (bool? value) {
                          setState(() {
                            _isCheckedShare = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ), //오늘 일기 공유 onoff
              ],
            ),
          ],
        ),
      ),
    );
  }
}
