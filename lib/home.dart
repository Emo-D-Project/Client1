import 'package:capston1/main.dart';
import 'package:capston1/writediary.dart';
import 'package:flutter/material.dart';
import 'style.dart' as style;
import 'writediary.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      body: Center(
          child: Container(
            child: Image.asset('images/main/[ttm]+삼색고양이_기본형_최종-(1).gif',
              width: 1000,
              height : 1000,
              fit: BoxFit.contain,

            ),
          )
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: Container(
                      width: 250,
                      height: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Icon(Icons.favorite,size: 50,),
                          ), //냥발바닥
                          Container(
                            child: Text("오늘의 감정을 선택해주세요.",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                          ), //오늘의 감정을 선택해주세요
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.mood, size: 30,)),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.mood_bad, size: 30,)),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.mood, size: 30,))
                              ],
                            ),
                          ), //감정 첫째줄
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.mood, size: 30,)),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.mood_bad, size: 30,)),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.mood, size: 30,)),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.mood_bad, size: 30,))
                              ],
                            ),
                          ), //감정 둘째줄
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => const writediary()));
                              },
                              child: Text("확인"),
                            ),
                          ), //확인 버튼
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Icon(Icons.edit),
        );
      }),
    );
  }
}
