import 'package:capston1/main.dart';
import 'package:flutter/material.dart';

class alrampage extends StatelessWidget {
  const alrampage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(0xFFF8F5EB),
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            title: Text(""),
            bottom: TabBar(
              labelStyle: TextStyle(
                color: Colors.black
              ),
              tabs: [
                Tab(
                  text: "ALRAM",
                ),
                Tab(
                  text: "MESSAGE",
                )
              ],
            ),
            leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => MyApp()));
              },
              icon: Icon(Icons.arrow_back_ios),
            ),
          ),
          body: TabBarView(
            children: [
              FirstScreen(),
              SecondScreen(),
            ],
          ),
        ));
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('첫 번째 화면'),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('두 번째 화면'),
    );
  }
}
