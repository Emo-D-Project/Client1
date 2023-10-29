import 'package:flutter/material.dart';
import 'category.dart';

class mypage extends StatefulWidget {
  const mypage({super.key});

  @override
  State<mypage> createState() => _mypageState();
}

class _mypageState extends State<mypage> {
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
          "MYPAGE",
          style: TextStyle(color: Color(0xFF968C83)),
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
        child: Container(
          width: sizeX*0.9, height: sizeY*0.8,
          decoration: BoxDecoration(
            color: Color(0xFFF8F5EB),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
            width: 330,
            height: 550,
            decoration: BoxDecoration(
              color: Color(0x4D968C83),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
                    "내 닉네임",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF7D5A50)),
                  ),
                ),
                Container(
                  //칸 나누는 줄
                  color: Colors.black54,
                  width: 300, height: 1,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 250, 0),
                  child: Text(
                    "소개",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Container(
                  //칸 나누는 줄
                  color: Colors.black54,
                  width: 280, height: 1,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Text(
                              "최애 영화",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color(0xFF7D5A50)),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //칸 나누는 줄
                        color: Colors.grey,
                        width: 280, height: 1,
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Container(
                            child: Text(
                              "신과 함께",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Text(
                              "최애 노래",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color(0xFF7D5A50)),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //칸 나누는 줄
                        color: Colors.grey,
                        width: 280, height: 1,
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Container(
                            child: Text(
                              "want so bad - straykids",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            child: Text(
                              "MBTI",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color(0xFF7D5A50)),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //칸 나누는 줄
                        color: Colors.grey,
                        width: 280, height: 1,
                        margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 25,
                          ),
                          Container(
                            child: Text(
                              "ISTP-T",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      plusDialog(context);
                    },
                    icon: Icon(
                      Icons.add_circle,
                      size: 40,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}



void plusDialog(context) {
  final sizeX = MediaQuery.of(context).size.width;
  final sizeY = MediaQuery.of(context).size.height;

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        height: sizeY*0.5,
        color: Color(0xFF737373),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Center(
            child: Column(
              children: [
                Container(
                    width: 130,
                    height: 5,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                    color: Color.fromRGBO(117, 117, 117, 100),
                ),
                SizedBox(child: Text("질문 선택",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,fontFamily: 'fontnanum'),),),
                Container(//칸 나누는 줄
                  margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  color: Colors.black54,
                  width: sizeX, height: 1,
                ),
                ElevatedButton(
                    onPressed: (){
                      _showDialog(context);
                    },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("질문 1",style: TextStyle(color: Colors.black,fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: (){
                    _showDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("질문 2",style: TextStyle(color: Colors.black,fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: (){
                    _showDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("질문 3",style: TextStyle(color: Colors.black,fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: (){
                    _showDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("질문 4",style: TextStyle(color: Colors.black,fontSize: 15)),
                ),
                ElevatedButton(
                  onPressed: (){
                    _showDialog(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: Colors.white,
                  ),
                  child: Text("질문 5",style: TextStyle(color: Colors.black,fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<dynamic> _showDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text('최애 음식'),
      content: TextField(),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: Colors.amber,
                minimumSize: Size(150, 30)
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('취소',style: TextStyle(color: Colors.black,fontSize: 20))),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: Colors.blue,
              minimumSize: Size(150, 30)
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text('확인',style: TextStyle(color: Colors.black,fontSize: 20))),
      ],
    ),
  );
}
