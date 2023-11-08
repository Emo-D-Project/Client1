import 'package:flutter/material.dart';
import 'category.dart';
import 'package:flutter/cupertino.dart';

class alramsetting extends StatefulWidget {
  const alramsetting({super.key});

  @override
  State<alramsetting> createState() => _alramsettingState();
}

class _alramsettingState extends State<alramsetting> {
  bool _isMessageOn = false;
  bool _isMessageAlram = false;
  bool _isMentionAlram = false;
  bool _isHeartAlram = false;
  bool _isAlram = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("ALRAMSETTING",style: TextStyle(color: Color(0xFF968C83),fontFamily: 'kim', fontSize: 30,),),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => category()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 5),
              child: Row(
                children: [
                  Container(
                      padding : EdgeInsets.fromLTRB(70, 0, 170, 0),
                      child: Text("쪽지 허용",style: TextStyle(fontSize: 17,fontFamily: 'soojin',color: Color(0xFF7D5A50)),),
                  ),
                  CupertinoSwitch(
                    value: _isMessageOn,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value){
                      setState((){
                        _isMessageOn = value ??false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: [
                  Container(
                    padding : EdgeInsets.fromLTRB(70, 0, 170, 0),
                    child: Text("쪽지 알림",style: TextStyle(fontSize: 17,fontFamily: 'soojin',color: Color(0xFF7D5A50)),),
                  ),
                  CupertinoSwitch(
                    value: _isMessageAlram,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value){
                      setState((){
                        _isMessageAlram = value ??false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: [
                  Container(
                    padding : EdgeInsets.fromLTRB(70, 0, 170, 0),
                    child: Text("댓글 알림",style: TextStyle(fontSize: 17,fontFamily: 'soojin',color: Color(0xFF7D5A50)),),
                  ),
                  CupertinoSwitch(
                    value: _isMentionAlram,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value){
                      setState((){
                        _isMentionAlram = value ??false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: [
                  Container(
                    padding : EdgeInsets.fromLTRB(70, 0, 170, 0),
                    child: Text("공감 알림",style: TextStyle(fontSize: 17,fontFamily: 'soojin',color: Color(0xFF7D5A50)),),
                  ),
                  CupertinoSwitch(
                    value: _isHeartAlram,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value){
                      setState((){
                        _isHeartAlram = value ??false;
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(
                children: [
                  Container(
                    padding : EdgeInsets.fromLTRB(70, 0, 170, 0),
                    child: Text("활동 알림",style: TextStyle(fontSize: 17,fontFamily: 'soojin',color: Color(0xFF7D5A50)),),
                  ),
                  CupertinoSwitch(
                    value: _isAlram,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value){
                      setState((){
                        _isAlram = value ??false;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
