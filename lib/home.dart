import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            width: 100,
            height: 10,
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
