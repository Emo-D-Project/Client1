import 'package:flutter/material.dart';
import 'category.dart';
import 'package:flutter/cupertino.dart';
import 'network/api_manager.dart';
import 'models/Alram.dart';
import 'package:capston1/screens/LoginedUserInfo.dart';


class alramsetting extends StatefulWidget {
  const alramsetting({super.key});

  @override
  State<alramsetting> createState() => _alramsettingState();
}

class _alramsettingState extends State<alramsetting> {
  ApiManager apiManager = ApiManager().getApiManager();

  bool _isMessageOn = false;
  bool _isMessageAlram = false;
  bool _isMentionAlram = false;
  bool _isHeartAlram = false;
  bool _isAlram = false;

  Future<void> PostExample(String endpoint) async {
    ApiManager apiManager = ApiManager().getApiManager();

    try {
      final postData = {
        'userId': LoginedUserInfo.loginedUserInfo.id,
        'allowMsg': _isMessageOn,
        'msgAlarm': _isMessageAlram,
        'commAlarm': _isMentionAlram,
        'empAlarm': _isHeartAlram,
        'actAlarm': _isAlram,
      };
      await apiManager.post(endpoint, postData); // 실제 API 엔드포인트로 대체
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromServer();
  }

  Alram? alram;

  Future<void> fetchDataFromServer() async {
    try {
      final data = await apiManager.getAlramData();
      setState(() {
        alram = data;
      });

    } catch (error) {
      // 오류 처리
      print('Error getting Alram list: $error');
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
          "ALRAMSETTING",
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
                      "쪽지 허용",
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'soojin',
                          color: Color(0xFF7D5A50)),
                    ),
                  ),
                  CupertinoSwitch(
                    value: alram!= null ? alram!.allowMsg : false,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value) {
                      setState(() {
                        _isMessageOn = value ?? false;
                        PostExample("/api/settings/save");
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
                    padding: EdgeInsets.fromLTRB(70, 0, 170, 0),
                    child: Text(
                      "쪽지 알림",
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'soojin',
                          color: Color(0xFF7D5A50)),
                    ),
                  ),
                  CupertinoSwitch(
                    value: alram!= null ? alram!.msgAlarm : false,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value) {
                      setState(() {
                        _isMessageAlram = value ?? false;
                        PostExample("/api/settings/save");
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
                    padding: EdgeInsets.fromLTRB(70, 0, 170, 0),
                    child: Text(
                      "댓글 알림",
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'soojin',
                          color: Color(0xFF7D5A50)),
                    ),
                  ),
                  CupertinoSwitch(
                    value: alram!= null ? alram!.commAlarm : false,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value) {
                      setState(() {
                        _isMentionAlram = value ?? false;
                        PostExample("/api/settings/save");
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
                    padding: EdgeInsets.fromLTRB(70, 0, 170, 0),
                    child: Text(
                      "공감 알림",
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'soojin',
                          color: Color(0xFF7D5A50)),
                    ),
                  ),
                  CupertinoSwitch(
                    value: alram!= null ? alram!.empAlarm : false,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value) {
                      setState(() {
                        _isHeartAlram = value ?? false;
                        PostExample("/api/settings/save");
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
                    padding: EdgeInsets.fromLTRB(70, 0, 170, 0),
                    child: Text(
                      "활동 알림",
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'soojin',
                          color: Color(0xFF7D5A50)),
                    ),
                  ),
                  CupertinoSwitch(
                    value: alram!= null ? alram!.actAlarm : false,
                    activeColor: CupertinoColors.activeGreen,
                    onChanged: (bool? value) {
                      setState(() {
                        _isAlram = value ?? false;
                        PostExample("/api/settings/save");
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
