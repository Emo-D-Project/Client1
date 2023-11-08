import 'package:flutter/material.dart';
import 'statistics.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:math';

class fullStatistics extends StatefulWidget {
  const fullStatistics({super.key});

  @override
  State<fullStatistics> createState() => _fullStatisticsState();
}

class _fullStatisticsState extends State<fullStatistics> {

  List<double> emotioncount = [200, 190, 150, 80, 50, 40, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "EMO:D",
          style: TextStyle(color: Color(0xFF968C83)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => statistics()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            //padding: EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                    width: 300,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 19,
                                color: Colors.brown,
                                fontWeight: FontWeight.w900
                            ),
                            children: [
                              TextSpan(text: '현재까지 쌓인 감정이에요 :D'),
                            ]
                        )
                    )
                ),
              ],
            ),
          ),

          // 감정 통계
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                width: double.infinity,
                child: Column(
                  children: [
                    DottedBorder(
                      borderType: BorderType.RRect,
                      color: Color(0xFF745A52),
                      strokeWidth: 2,
                      radius: Radius.circular(20),
                      dashPattern: [13, 13],
                      child: SizedBox(//감정 그래프 (barchart)
                        width: 380,
                        child: Column(
                          children: [
                            Container(
                              width: 380,
                              height: 230,
                              padding: EdgeInsets.fromLTRB(0,20,0,0),
                              color: Color(0xFFE1DED6),
                              margin: const EdgeInsets.all(8.0),
                              child: Center(
                                child: CustomPaint(
                                  size: Size(400, 400),
                                  foregroundPainter: BarChart(
                                    data: emotioncount,
                                    labels: <String>[
                                      '${emotioncount[0].toInt()}',
                                      '${emotioncount[1].toInt()}',
                                      '${emotioncount[2].toInt()}',
                                      '${emotioncount[3].toInt()}',
                                      '${emotioncount[4].toInt()}',
                                      '${emotioncount[5].toInt()}',
                                      '${emotioncount[6].toInt()}',
                                    ],
                                    color: Color(0xFFF2E0E0),
                                  ),
                                ),
                              ),
                            ),

                            //감정 이모션 사진
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      // Container(
                                      //   child: Text('${emotioncount[0].toInt()}',),
                                      // ),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'images/emotion/1.gif'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'images/emotion/2.gif'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.fromLTRB(8, 0, 8, 7),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'images/emotion/3.gif'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 37,
                                    height: 37,
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'images/emotion/4.gif'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'images/emotion/5.gif'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'images/emotion/6.gif'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    padding: const EdgeInsets.all(8.0),
                                    margin: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'images/emotion/7.gif'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),

                                  ),
                                  //color: Color.fromRGBO(248, 245, 235, 100),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8,),
                    // 작성된 일기 수
                    Container(
                        width: 380,
                        height: 100,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color(0xFFE1DED6),
                          borderRadius: BorderRadius.circular(
                              15),
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
                                            fontSize: 18, color: Colors.brown,
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
                          borderRadius: BorderRadius.circular(
                              15),
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
                                    text: TextSpan(
                                        children: [
                                          TextSpan(text: '수진',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.brown)), //닉네임
                                          TextSpan(text: ' 님은 ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.brown)), //
                                          TextSpan(text: '밤(18~00) ',
                                              style: TextStyle(fontSize: 25,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.brown)), //시간
                                          TextSpan(text: '에',
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
                          borderRadius: BorderRadius.circular(
                              15),
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
                                    text: TextSpan(

                                        children: [
                                          TextSpan(text: '2023년 ',
                                              style: TextStyle(fontSize: 25,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.brown)),
                                          TextSpan(text: '9월 ',
                                              style: TextStyle(fontSize: 25,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.brown)),
                                          TextSpan(text: '에',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: Colors.brown)),
                                          TextSpan(text: ' 25개 ',
                                              style: TextStyle(fontSize: 25,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.brown)),
                                          TextSpan(text: '로',
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
                                        style: TextStyle(fontSize: 18,
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
                        borderRadius: BorderRadius.circular(
                            15),
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
        ],
      ),
    );
  }
}

class BarChart extends CustomPainter {
  final Color color;
  final List<double> data;
  final List<String> labels;
  double bottomPadding = 0.0;
  double leftPadding = 0.0;
  double textScaleFactorXAxis = 1.0;
  double textScaleFactorYAxis = 1.2;

  BarChart({required this.data, required this.labels, this.color = Colors.blue});

  @override
  void paint(Canvas canvas, Size size) {
    // 텍스트 공간을 미리 정한다.
    setTextPadding(size);

    List<Offset> coordinates = getCoordinates(size);

    drawBar(canvas, size, coordinates);
    drawXLabels(canvas, size, coordinates);
    //drawYLabels(canvas, size, coordinates);
    //drawLines(canvas, size, coordinates);
  }

  @override
  bool shouldRepaint(BarChart oldDelegate) {
    return oldDelegate.data != data;
  }

  void setTextPadding(Size size) {

    // 세로 크기의 1/10만큼 텍스트 패딩
    bottomPadding = size.height / 15;
    // 가로 길이 1/10만큼 텍스트 패딩
    leftPadding = size.width / 25;
  }

  void drawBar(Canvas canvas, Size size, List<Offset> coordinates) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    // 막대 그래프가 겹치지 않게 간격을 준다.
    double barWidthMargin = size.width * 0.08;

    for (int index = 0; index < coordinates.length; index++) {
      Offset offset = coordinates[index];
      double left = offset.dx;
      // 간격만큼 가로로 이동
      double right = offset.dx + barWidthMargin;
      double top = offset.dy;
      // 텍스트 크기만큼 패딩을 빼준다. 그래서 텍스트와 겹치지 않게 한다.
      double bottom = size.height - bottomPadding;

      Rect rect = Rect.fromLTRB(left, top, right, bottom);
      canvas.drawRect(rect, paint);
    }
  }

  //x축 텍스트(레이블)를 그린다.
  void drawXLabels(Canvas canvas, Size size, List<Offset> coordinates) {
    // 화면 크기에 따라 유동적으로 폰트 크기를 계산한다.
    double fontSize = calculateFontSize(labels[0], size, xAxis: true);

    for (int index = 0; index < labels.length; index++) {
      TextSpan span = TextSpan(

        style: TextStyle(
          color: Colors.black,
          fontSize: fontSize,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,

        ),
        text: labels[index],
      );
      TextPainter tp =
      TextPainter(text: span, textDirection: TextDirection.ltr);
      tp.layout();

      Offset offset = coordinates[index];
      double dx = offset.dx+ (size.width * 0.08 / 3);
      double dy = size.height - tp.height;

      tp.paint(canvas, Offset(dx, dy));
    }
  }
  //
  // // Y축 텍스트(레이블)를 그린다. 최저값과 최고값을 Y축에 표시한다.
  // void drawYLabels(Canvas canvas, Size size, List<Offset> coordinates) {
  //   double bottomY = coordinates[0].dy;
  //   double topY = coordinates[0].dy;
  //   int indexOfMin = 0;
  //   int indexOfMax = 0;
  //
  //   for (int index = 0; index < coordinates.length; index++) {
  //     double dy = coordinates[index].dy;
  //     if (bottomY < dy) {
  //       bottomY = dy;
  //       indexOfMin = index;
  //     }
  //     if (topY > dy) {
  //       topY = dy;
  //       indexOfMax = index;
  //     }
  //   }
  //   String minValue = '${data[indexOfMin].toInt()}';
  //   String maxValue = '${data[indexOfMax].toInt()}';
  //
  //   double fontSize = calculateFontSize(maxValue, size, xAxis: false);
  //
  //   drawYText(canvas, minValue, fontSize, bottomY);
  //   drawYText(canvas, maxValue, fontSize, topY);
  // }

  // 화면 크기에 비례해 폰트 크기를 계산한다.
  double calculateFontSize(String value, Size size, {required bool xAxis}) {
    // 글자수에 따라 폰트 크기를 계산하기 위함
    int numberOfCharacters = value.length;
    // width가 600일 때 100글자를 적어야 한다면, fontSize는 글자 하나당 6이어야 한다.
    double fontSize = (size.width / numberOfCharacters) / data.length;

    if (xAxis) {
      fontSize *= textScaleFactorXAxis;
    } else {
      fontSize *= textScaleFactorYAxis;
    }
    return fontSize;
  }

  // x축 & y축 구분하는 선을 그린다.
  // void drawLines(Canvas canvas, Size size, List<Offset> coordinates) {
  //   Paint paint = Paint()
  //     ..color = Colors.blueGrey[100]!
  //     ..strokeCap = StrokeCap.round
  //     ..style = PaintingStyle.stroke
  //     ..strokeWidth = 1.8;
  //
  //   double bottom = size.height - bottomPadding;
  //   double left = coordinates[0].dx;
  //
  //   Path path = Path();
  //   path.moveTo(left, 0);
  //   path.lineTo(left, bottom);
  //   path.lineTo(size.width, bottom);
  //
  //   canvas.drawPath(path, paint);
  // }

  // void drawYText(Canvas canvas, String text, double fontSize, double y) {
  //   TextSpan span = TextSpan(
  //     style: TextStyle(
  //       fontSize: fontSize,
  //       color: Colors.black,
  //       fontFamily: 'Roboto',
  //       fontWeight: FontWeight.w600,
  //     ),
  //     text: text,
  //   );
  //   TextPainter tp = TextPainter(text: span, textDirection: TextDirection.ltr);
  //
  //   tp.layout();
  //
  //   Offset offset = Offset(0.0, y);
  //   tp.paint(canvas, offset);
  // }

  List<Offset> getCoordinates(Size size) {
    List<Offset> coordinates = <Offset>[];

    double maxData = data.reduce(max);

    double width = size.width - leftPadding;
    double minBarWidth = width / data.length;

    for (int index = 0; index < data.length; index++) {
      // 그래프의 가로 위치를 정한다.
      double left = minBarWidth * (index) + leftPadding;
      // 그래프의 높이가 [0~1] 사이가 되도록 정규화 한다.
      double normalized = data[index] / maxData;
      // x축에 표시되는 글자들과 겹치지 않게 높이에서 패딩을 제외한다.
      double height = size.height - bottomPadding;
      // 정규화된 값을 통해 높이를 구한다.
      double top = height - normalized * height;

      Offset offset = Offset(left, top);
      coordinates.add(offset);
    }

    return coordinates;
  }
}
