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
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        //backgroundColor: Color.fromRGBO(248, 245, 235, 100),
        title: Text("MYPAGE",style: TextStyle(color: Color(0xFF968C83)),),
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
          decoration: BoxDecoration(
            color: Color(0xFFF8F5EB),
          ),
          child: Container(
            margin: EdgeInsets.fromLTRB( 10, 0, 10, 20),
            width: 330,height: 550,
            decoration: BoxDecoration(
              color: Color(0x4D968C83),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text("내 닉네임",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                ),
                Container(
                  //칸 나누는 줄
                  color: Color.fromRGBO(125, 90, 80, 100),
                  width: 300, height: 2,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 250, 0),
                  child: Text("소개",style: TextStyle(fontSize: 13),),
                ),
                Container(
                  //칸 나누는 줄
                  color: Color.fromRGBO(125, 90, 80, 100),
                  width: 280, height: 2,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: 300,height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("최애 영화",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Color(0xFF7D5A50)),),
                        padding: EdgeInsets.fromLTRB(0, 0, 50, 4),
                      ),
                      Container(
                        //칸 나누는 줄
                        color: Colors.grey,
                        width: 280, height: 2,
                      ),
                      Container(
                        child: Text("신과 함께",style: TextStyle(fontSize: 15),),
                        padding: EdgeInsets.fromLTRB(0, 5, 50, 0),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: 300,height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("최애 노래",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Color(0xFF7D5A50)),),
                        padding: EdgeInsets.fromLTRB(0, 0, 50, 4),
                      ),
                      Container(
                        //칸 나누는 줄
                        color: Colors.grey,
                        width: 280, height: 2,
                      ),
                      Container(
                        child: Text("want so bad - straykids(leeknow, han)",style: TextStyle(fontSize: 15),),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  width: 300,height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Text("MBTI",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Color(0xFF7D5A50)),),
                        padding: EdgeInsets.fromLTRB(0, 0, 50, 4),
                      ),
                      Container(
                        //칸 나누는 줄
                        color: Colors.grey,
                        width: 280, height: 2,
                      ),
                      Container(
                        child: Text("ISTP",style: TextStyle(fontSize: 15),),
                        padding: EdgeInsets.fromLTRB(0, 5, 50, 0),
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.add_circle,size: 40,)
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}