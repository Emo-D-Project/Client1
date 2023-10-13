import 'package:capston1/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class writediary extends StatefulWidget {
  const writediary({super.key});

  @override
  State<writediary> createState() => _writediaryState();
}

class _writediaryState extends State<writediary> {
  bool _isChecked = false;
  bool _isCheckedShare = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(248, 245, 235, 100),
        title: Icon(Icons.mood,size: 50,),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyApp()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(onPressed: (){},
              icon: Icon(Icons.upload)
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(248, 245, 235, 100),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB( 10, 10, 10, 10),
              width: 350,height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Container(), //날짜
                  Container(), //일기
                  Container(), //사진추가,음성녹음
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    width: 170,height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 10,),
                        SizedBox(child: Text("댓글 허용",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),),
                        SizedBox(width: 20,),
                        CupertinoSwitch(
                          value: _isChecked,
                          activeColor: CupertinoColors.activeGreen,
                          onChanged: (bool? value){
                            setState((){
                              _isChecked = value ??false;
                            });
                          },
                        ),
                      ],
                    ),
                  ), //댓글 허용 onoff
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    width: 170,height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(child: Text("오늘 일기 공유",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),),
                        CupertinoSwitch(
                          value: _isCheckedShare,
                          activeColor: CupertinoColors.activeGreen,
                          onChanged: (bool? value){
                            setState((){
                              _isCheckedShare = value ??false;
                            });
                          },
                        ),
                      ],
                    ),
                  ), //오늘 일기 공유 onoff
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
