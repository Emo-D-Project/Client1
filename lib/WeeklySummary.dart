import 'package:flutter/material.dart';

class weeklySummary extends StatefulWidget {
  const weeklySummary({super.key});

  @override
  State<weeklySummary> createState() => _weeklySummaryState();
}

class _weeklySummaryState extends State<weeklySummary> {
  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery.of(context).size.width;
    final sizeY = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFF8F5EB),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          color: Color(0xFFF8F5EB),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                width: sizeX*0.9,
                child: Text("이번주 요약",style: TextStyle(color: Color(0xFF7D5A50),fontSize: 24,fontFamily: 'kim',fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              ),
              Row(
                children: [
                  Container(
                    width: sizeX*0.42,
                    height: sizeY*0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Text("가장 좋았던 일",style: TextStyle(fontSize: 16,fontFamily: 'kim',),),
                          margin: EdgeInsets.fromLTRB(3, 13, 50, 20),
                        ),
                        Container(
                          child: Text("셤 끝남~!",style: TextStyle(fontSize: 20,fontFamily: 'kim',),),
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    width: sizeX*0.42,
                    height: sizeY*0.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Text("가장 나빴던 일",style: TextStyle(fontSize: 16,fontFamily: 'kim',),),
                          margin: EdgeInsets.fromLTRB(3, 13, 50, 20),
                        ),
                        Container(
                          child: Text("셤 망침~!",style: TextStyle(fontSize: 20,fontFamily: 'kim',),),
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                width: sizeX*0.9,
                height: sizeY*0.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    Container(
                      child: Text("이번주의 감정",style: TextStyle(fontSize: 16,fontFamily: 'kim',),),
                      margin: EdgeInsets.fromLTRB(3, 13, 250, 20),
                    ),
                    Container(
                      child: Image.asset(
                        'images/emotion/flutter.gif',
                        height: 120,
                        width: 120,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                width: sizeX*0.9,
                child: Text("요일별 요약",style: TextStyle(color: Color(0xFF7D5A50),fontSize: 20,fontFamily: 'kim',fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
                width: sizeX*0.9,
                height: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Text("MON",style: TextStyle(fontSize: 20,fontFamily: 'kim',fontWeight: FontWeight.bold)),
                            width: sizeX*0.2,
                          ),
                          Container(
                            width: sizeX*0.6,
                            child: Text("알고리즘 시험침ㅜㅜ",style: TextStyle(fontSize: 20,fontFamily: 'kim',),textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    ),Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: sizeX*0.2,
                            child: Text("TUE",style: TextStyle(fontSize: 20,fontFamily: 'kim',fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            width: sizeX*0.6,
                            child: Text("알고리즘 시험침ㅜㅜ",style: TextStyle(fontSize: 20,fontFamily: 'kim',),textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    ),Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: sizeX*0.2,
                            child: Text("WED",style: TextStyle(fontSize: 20,fontFamily: 'kim',fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            width: sizeX*0.6,
                            child: Text("알고리즘 시험침ㅜㅜ",style: TextStyle(fontSize: 20,fontFamily: 'kim',),textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    ),Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: sizeX*0.2,
                            child: Text("THR",style: TextStyle(fontSize: 20,fontFamily: 'kim',fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            width: sizeX*0.6,
                            child: Text("알고리즘 시험침ㅜㅜ",style: TextStyle(fontSize: 20,fontFamily: 'kim',),textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    ),Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: sizeX*0.2,
                            child: Text("FRI",style: TextStyle(fontSize: 20,fontFamily: 'kim',fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            width: sizeX*0.6,
                            child: Text("알고리즘 시험침ㅜㅜ",style: TextStyle(fontSize: 20,fontFamily: 'kim',),textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    ),Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: sizeX*0.2,
                            child: Text("SAT",style: TextStyle(fontSize: 20,fontFamily: 'kim',fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            width: sizeX*0.6,
                            child: Text("알고리즘 시험침ㅜㅜ",style: TextStyle(fontSize: 20,fontFamily: 'kim',),textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    ),Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: sizeX*0.2,
                            child: Text("SUN",style: TextStyle(fontSize: 20,fontFamily: 'kim',fontWeight: FontWeight.bold)),
                          ),
                          Container(
                            width: sizeX*0.6,
                            child: Text("알고리즘 시험침ㅜㅜ",style: TextStyle(fontSize: 20,fontFamily: 'kim',),textAlign: TextAlign.right,),
                          ),
                        ],
                      ),
                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
