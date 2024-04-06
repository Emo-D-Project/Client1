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
      bool passSwitch = passSwitchString.toLowerCase() == 'true';
      setState(() {
        _isChecked = passSwitch;
      });
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
                        _isChecked = value;
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
