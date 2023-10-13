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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(248, 245, 235, 100),
        title: Text("MYPAGE"),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => category()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(248, 245, 235, 100),
        ),
        child: Container(
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}