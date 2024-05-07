import 'package:capston1/main.dart';
import 'package:flutter/material.dart';
import 'category.dart';
import 'package:flutter/cupertino.dart';
import 'network/api_manager.dart';

class blur extends StatefulWidget {
  const blur({super.key});

  @override
  State<blur> createState() => _blurState();
}

class _blurState extends State<blur> {
  TextEditingController _passwordController = TextEditingController();
  ApiManager apiManager = ApiManager().getApiManager();

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  String passwordcorrect= '';

  Future<void> fetchDataFromServer() async {
    try {
      String password = await apiManager.GetPassword();
      passwordcorrect = password;
      print(password);
    } catch (error) {
      // 오류 처리
      print('Error getting pass list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "EMO:D",
          style: TextStyle(
            color: Color(0xFF968C83),
            fontFamily: 'kim',
            fontSize: 30,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 5),
              child: Container(
                padding: EdgeInsets.fromLTRB(70, 0, 170, 0),
                child: Text(
                  "어플 잠금",
                  style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'soojin',
                      color: Color(0xFF7D5A50)),
                ),
              ),
            ),
            TextField(
              controller: _passwordController,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
                fontFamily: 'soojin',
              ),
              decoration: InputDecoration(
                hintText: '비밀번호를 입력해주세요.',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if(passwordcorrect == _passwordController.text){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));}
                  else{
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                        title: Text(
                          "일기장 비밀번호",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'soojin',
                              color: Color(0xFF7D5A50)),
                        ),
                        content: Text(
                          "비밀번호가 틀렸습니다.",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'soojin',
                              color: Color(0xFF7D5A50)),
                        ),
                        actions: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0.0,
                                  backgroundColor: Color(0x4D968C83),
                                  minimumSize: Size(150, 30)),
                              onPressed: () {
                                  Navigator.of(context).pop();
                                  print(passwordcorrect);},
                              child: Text('확인',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontFamily: 'soojin'))),
                        ],
                      );
                    });
                  }
                },
                child: Text('확인',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'soojin')))
          ],
        ),
      ),
    );
  }
}
