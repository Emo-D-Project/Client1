import 'package:flutter/material.dart';
import 'statistics.dart';

class monthlyStatistics extends StatefulWidget {
  const monthlyStatistics({super.key});

  @override
  State<monthlyStatistics> createState() => _monthlyStatisticsState();
}

class _monthlyStatisticsState extends State<monthlyStatistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text("EMO:D",style: TextStyle(color: Color(0xFF968C83)),),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => statistics()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10),
        itemCount: 10,
        itemBuilder: (BuildContext context, int index){
          return Container(

            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10)),
              color: Colors.white,
            ),
            child: ExpansionTile(title: Text("2023년 10월의 감정 통지서", style: TextStyle(fontFamily: "nanum", fontSize: 25,color: Color(0xFF968C83),),),
              initiallyExpanded: false,
              //backgroundColor: Colors.white,
              children: <Widget>[
                Container(height: 50, child: Padding(padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      SizedBox(child: Text('hi'))
                    ],
                  ),
                ),
                ),
              ],
            ),
          );
        }, separatorBuilder: (BuildContext context, int index) => Divider(
        height: 10,
        color: Colors.white,
      ),
          ),
    );
  }
}
