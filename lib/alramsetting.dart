import 'package:flutter/material.dart';
import 'category.dart';
import 'package:flutter/cupertino.dart';

class alramsetting extends StatefulWidget {
  const alramsetting({super.key});

  @override
  State<alramsetting> createState() => _alramsettingState();
}

class _alramsettingState extends State<alramsetting> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //backgroundColor: Color.fromRGBO(248, 245, 235, 100),
        title: Text("ALRAMSETTING"),
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
              child: Row(
                children: [
                  Container(
                      padding : EdgeInsets.fromLTRB(0, 10, 0, 20),
                      child: Text("쪽지 허용"),
                  ),
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
            ),
            Container(),
            Container(),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}
