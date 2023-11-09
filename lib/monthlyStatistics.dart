import 'package:flutter/material.dart';
import 'statistics.dart';
import 'package:dotted_border/dotted_border.dart';
import 'statistics.dart';
import 'package:capston1/pieGraph/pie_chart.dart';


class ListData{
  final String title;

  ListData(this.title);
}

class monthlyStatistics extends StatefulWidget {
  const monthlyStatistics({super.key});

  @override
  State<monthlyStatistics> createState() => _monthlyStatisticsState();
}

class _monthlyStatisticsState extends State<monthlyStatistics> {
  final List<ListData> datas = [
    ListData('2023년 10월의 감정 통지서'),
    ListData('2023년 09월의 감정 통지서'),
    ListData('2023년 08월의 감정 통지서'),
    ListData('2023년 07월의 감정 통지서'),
    ListData('2023년 06월의 감정 통지서'),
    ListData('2023년 05월의 감정 통지서'),
    ListData('2023년 04월의 감정 통지서'),
    ListData('2023년 03월의 감정 통지서'),
    ListData('2023년 02월의 감정 통지서'),
    ListData('2023년 01월의 감정 통지서'),
    ListData('2022년 12월의 감정 통지서'),
    ListData('2022년 11월의 감정 통지서'),
    ListData('2022년 10월의 감정 통지서'),
    ListData('2022년 09월의 감정 통지서'),
    ListData('2022년 08월의 감정 통지서'),
  ];
  List<double> emotioncount = [200, 190, 150, 80, 50, 40, 5];

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
        itemCount: datas.length,
        itemBuilder: (BuildContext context, int index){
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10), bottom: Radius.circular(10)),
              color: Colors.white,
            ),
            child: Scrollbar(
              thickness: 4.0,
              radius: Radius.circular(8),
              child: ExpansionTile(
                //title: Text("2023년 10월의 감정 통지서", style: TextStyle(fontFamily: "nanum", fontSize: 25,color: Color(0xFF968C83),),),
                title: Text(datas[index].title),
                initiallyExpanded: false,
                //backgroundColor: Colors.white,
                children: <Widget>[
                  Container(child: Padding(padding: EdgeInsets.all(5),
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  color: Color(0xFF745A52),
                                  strokeWidth: 2,
                                  radius: Radius.circular(20),
                                  dashPattern: [13, 13],
                                  child: SizedBox(
                                    width: 400,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 250,


                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                height: 8,
                              ),
                              // 작성된 일기 수
                              Container(
                                  width: 380,
                                  height: 100,
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE1DED6),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        //color: Colors.cyan,
                                          width: 300,
                                          height: 40,
                                          padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                                          child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.brown,
                                                      fontWeight: FontWeight.w600),
                                                  children: [
                                                    TextSpan(
                                                      text: '2023.',
                                                    ), //년도
                                                    TextSpan(text: '7.'), //달
                                                    TextSpan(text: '25 '), //일
                                                    TextSpan(text: '부터 작성 된 일기 수 '),
                                                  ]))),
                                      Container(
                                        //  color: Colors.pink,
                                          width: 300,
                                          height: 40,
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                          child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.brown,
                                                      fontWeight: FontWeight.w900),
                                                  children: [
                                                    TextSpan(text: '177'),
                                                    TextSpan(text: '개'),
                                                  ]))),
                                    ],
                                  )),

                              // 어느 시간대에 일기 가장 많이 쓴 지
                              Container(
                                  width: 380,
                                  height: 100,
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDAD4CC),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        //color: Colors.cyan,
                                          width: 300,
                                          padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                                          child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: '수진',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                        color: Colors.brown)), //닉네임
                                                TextSpan(
                                                    text: ' 님은 ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                        color: Colors.brown)), //
                                                TextSpan(
                                                    text: '밤(18~00) ',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight: FontWeight.w900,
                                                        color: Colors.brown)), //시간
                                                TextSpan(
                                                    text: '에',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                        color: Colors.brown)),
                                              ]))),
                                      Container(
                                        //  color: Colors.pink,
                                          width: 300,
                                          height: 40,
                                          child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.brown,
                                                      fontWeight: FontWeight.w600),
                                                  children: [
                                                    TextSpan(text: '일기를 가장 많이 작성하였어요 :D'),
                                                  ]))),
                                    ],
                                  )),

                              // 몇월에 일기 가장 많이 작성한지
                              Container(
                                  width: 380,
                                  height: 100,
                                  padding: const EdgeInsets.all(8.0),
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFDACFC4),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // 위아래 중앙 정렬
                                    children: [
                                      Container(
                                        //color: Colors.cyan,
                                          width: 300,
                                          height: 40,
                                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                          child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: '2023년 ',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight: FontWeight.w900,
                                                        color: Colors.brown)),
                                                TextSpan(
                                                    text: '9월 ',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight: FontWeight.w900,
                                                        color: Colors.brown)),
                                                TextSpan(
                                                    text: '에',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                        color: Colors.brown)),
                                                TextSpan(
                                                    text: ' 25개 ',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight: FontWeight.w900,
                                                        color: Colors.brown)),
                                                TextSpan(
                                                    text: '로',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 18,
                                                        color: Colors.brown)),
                                              ]))),
                                      Container(
                                        //  color: Colors.pink,
                                          width: 300,
                                          height: 40,
                                          child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.brown,
                                                      fontWeight: FontWeight.w600),
                                                  children: [
                                                    TextSpan(text: '가장 많이 일기를 작성하였어요 :D'),
                                                  ]))),
                                    ],
                                  )),

                              // 가장 많이 공감 받은 일기
                              Container(
                                width: 380,
                                height: 500,
                                padding: const EdgeInsets.all(8.0),
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: Color(0xFFD7D4CC),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                  ),
                ],
              ),
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
