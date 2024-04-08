import 'package:flutter/material.dart';
import 'category.dart';
import 'package:flutter/cupertino.dart';
import 'network/api_manager.dart';
import 'models/Alram.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';

class lock extends StatefulWidget {
  const lock({super.key});

  @override
  State<lock> createState() => _lockState();
}

class _lockState extends State<lock> {
  TextEditingController _passwordController = TextEditingController();
  ApiManager apiManager = ApiManager().getApiManager();
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Future<void> fetchDataFromServer() async {
    try {
      String passSwitchString = await apiManager.GetPassSwitch();
      bool passSwitch = false;
      if (passSwitchString.toLowerCase() == 'true') {
        passSwitch = true;
      }
      setState(() {
        _isChecked = passSwitch;
      });
    } catch (error) {
      // 오류 처리
      print('Error getting pass list: $error');
    }
  }

  void _sendPassword() async {
    try {
      String password = _passwordController.text;

      await apiManager.putPassword(password);
    } catch (error) {
      print('Error sending MyPage: $error');
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
          "어플 잠금 설정",
          style: TextStyle(
            color: Color(0xFF968C83),
            fontFamily: 'kim',
            fontSize: 30,
          ),
        ),
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
                    padding: EdgeInsets.fromLTRB(70, 0, 170, 0),
                    child: Text(
                      "어플 잠금",
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'soojin',
                          color: Color(0xFF7D5A50)),
                    ),
                  ),
                  CupertinoSwitch(
                    value: _isChecked,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (value) {
                      setState(() {
                        _togglePassSwitch(value);
                      });
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 15, 0, 5),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (_isChecked == true) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                title: Text(
                                  "일기장 비밀번호",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'soojin',
                                      color: Color(0xFF7D5A50)),
                                ),
                                content: TextField(
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
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: Color(0x4D968C83),
                                          minimumSize: Size(150, 30)),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('취소',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: 'soojin'))),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: Color(0xFF7D5A50),
                                          minimumSize: Size(150, 30)),
                                      onPressed: () async {
                                        _sendPassword();
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('확인',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: 'soojin'))),
                                ],
                              );
                            });
                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                title: Text(
                                  "일기장 비밀번호",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'soojin',
                                      color: Color(0xFF7D5A50)),
                                ),
                                content: Text("비밀번호 설정을 켜주세요."),
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: Color(0x4D968C83),
                                          minimumSize: Size(150, 30)),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('취소',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontFamily: 'soojin'))),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0.0,
                                          backgroundColor: Color(0xFF7D5A50),
                                          minimumSize: Size(150, 30)),
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                      },
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
                    child: Container(
                      padding: EdgeInsets.fromLTRB(70, 0, 170, 0),
                      child: Text(
                        "비밀번호 설정",
                        style: TextStyle(
                            fontSize: 17,
                            fontFamily: 'soojin',
                            color: Color(0xFF7D5A50)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _togglePassSwitch(bool value) async {
    setState(() {
      _isChecked = value;
    });
    await apiManager.putPassSwitch();
    print("일기 잠금 상태 변경");
  }
}
