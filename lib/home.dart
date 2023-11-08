import 'package:capston1/writediary.dart';
import 'package:flutter/material.dart';


class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      body: Center(
          child: SizedBox(
            child: Image.asset('images/main/[ttm]+삼색고양이_기본형_최종-(1).gif',
              width: 1200,
              height : 1000,
              fit: BoxFit.contain,
            ),
          )
      ),
      floatingActionButton: Builder(builder: (context) {
        return FloatingActionButton(
          backgroundColor: Color(0xFFD2C6BC),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: Container(
                      width: 250,
                      height: 270,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xFFF8F5EB),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: Image.asset('images/emotion/pinkcatimage.png',width: 60,height: 60,),
                          ), //냥발바닥
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text("오늘의 감정을 선택해주세요.",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,fontFamily: 'fontnanum'),),
                          ), //오늘의 감정을 선택해주세요
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    iconSize: 40,
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context)=>writediary(emotion: 'smile',)
                                        )
                                      );
                                    }, icon: Image.asset('images/emotion/1.gif',width: 50,height: 50,)),
                                IconButton(
                                    iconSize: 40,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context)=>writediary(emotion: 'flutter',)
                                          )
                                      );
                                    }, icon: Image.asset('images/emotion/2.gif')),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                  child: IconButton(
                                    iconSize: 40,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context)=>writediary(emotion: 'angry',)
                                            )
                                        );
                                      }, icon: Image.asset('images/emotion/3.gif')),
                                )
                              ],
                            ),
                          ), //감정 첫째줄
                          SizedBox(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    iconSize: 40,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context)=>writediary(emotion: 'annoying',)
                                          )
                                      );
                                    }, icon: Image.asset('images/emotion/4.gif')),
                                IconButton(
                                    iconSize: 40,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context)=>writediary(emotion: 'tired',)
                                          )
                                      );
                                    }, icon: Image.asset('images/emotion/5.gif')),
                                IconButton(
                                    iconSize: 40,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context)=>writediary(emotion: 'sad',)
                                          )
                                      );
                                    }, icon: Image.asset('images/emotion/6.gif')),
                                IconButton(
                                    iconSize: 40,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context)=>writediary(emotion: 'calmness',)
                                          )
                                      );
                                    }, icon: Image.asset('images/emotion/7.gif'))
                              ],
                            ),
                          ), //감정 둘째줄
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Image.asset('images/emotion/catimage.png',width: 40,height: 40,),
        );
      }),
    );
  }
}
