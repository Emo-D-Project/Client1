import 'package:flutter/material.dart';

void main() async{

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key) ;

  @override
  State<MyApp> createState() => _MyAppState();

}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Text("화면입니다"),
    );
  }
}