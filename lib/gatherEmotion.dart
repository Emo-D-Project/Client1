import 'package:capston1/diaryReplay.dart';
import 'package:flutter/material.dart';
import 'statistics.dart';
import 'package:intl/intl.dart';



class ListData{
  final DateTime date;

  ListData(this.date);
}


class gatherEmotion extends StatefulWidget {
  const gatherEmotion({super.key});

  @override
  State<gatherEmotion> createState() => _gatherEmotionState();
}

final LayerLink _layerLink = LayerLink();

class _gatherEmotionState extends State<gatherEmotion> {
  List<String> items = ['기본','기쁨','슬픔','화남','짜증','피곤','설렘'];
  String? selectedItem = '기본';

  final List<ListData> datas = [
    ListData(DateTime(2023,10)),
    ListData(DateTime(2023,09)),
    ListData(DateTime(2023,08)),

 ];

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "EMO:D",
          style: TextStyle(
              color: Color(0xFF968C83), fontFamily: 'kim', fontSize: 30),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => statistics()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Container(//드롭박스

            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(10),
                itemCount: datas.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: sizeX * 0.9,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: EdgeInsets.fromLTRB(10, 3, 0, 3),
                            child: Text(
                              "2023.10",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal, // 수평으로 스크롤
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>diaryReplay(date: '20231025')
                                            )
                                        );
                                      }, icon: Image.asset('images/emotion/2.gif')),
                                  Text("10.25")
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>diaryReplay(date: '20231025')
                                            )
                                        );
                                      }, icon: Image.asset('images/emotion/2.gif')),
                                  Text("10.25")
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>diaryReplay(date: '20231025')
                                            )
                                        );
                                      }, icon: Image.asset('images/emotion/2.gif')),
                                  Text("10.25")
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>diaryReplay(date: '20231025')
                                            )
                                        );
                                      }, icon: Image.asset('images/emotion/2.gif')),
                                  Text("10.25")
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>diaryReplay(date: '20231025')
                                            )
                                        );
                                      }, icon: Image.asset('images/emotion/2.gif')),
                                  Text("10.25")
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>diaryReplay(date: '20231025')
                                            )
                                        );
                                      }, icon: Image.asset('images/emotion/2.gif')),
                                  Text("10.25")
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>diaryReplay(date: '20231025')
                                            )
                                        );
                                      }, icon: Image.asset('images/emotion/2.gif')),
                                  Text("10.25")
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                      iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>diaryReplay(date: '20231025')
                                            )
                                        );
                                      }, icon: Image.asset('images/emotion/2.gif')),
                                  Text("10.25")
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  height: 10,
                  thickness: 1.0,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
