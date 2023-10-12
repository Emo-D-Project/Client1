import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 245, 235, 100),
      body: Center(
          child: Container(
            width: 100,
            height: 10,
            color: Colors.black,
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: Icon(Icons.edit),
      ),
    );
  }
}
