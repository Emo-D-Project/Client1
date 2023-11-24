import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'bar graph/bar_graph_month.dart';
import 'models/MonthData.dart';
import 'statistics.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:capston1/pieGraph/pie_chart.dart';
import 'network/api_manager.dart';

enum Emotion { smile, flutter, angry, annoying, tired, sad, calmness }

List<DateTime> title = [
  DateTime(2023, 10),
  DateTime(2023, 9),
  DateTime(2023, 8)
];
List<double> emotioncount = [10, 5, 2, 8, 1, 0, 2];
List<String> mostemo = ['smile', 'sad', 'flutter'];
List<String> worstemo = ['flutter', 'tired', 'smile'];
List<String> mymonth = ['10월 끗', '9월 끗', '8월 끗'];
List<double> total = [1, 2, 3];

Widget sadM = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
        width: 300,
        padding:
        EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: '"EMO:D의 한마디"\n\n',
                  style: TextStyle(
                      fontFamily: 'soojin',
                      fontSize: 30,
                      color: Colors.brown)),
              TextSpan(
                  text:
                  '한 달 동안 어려운 순간들이 많았겠죠.'
                      '\n\n'
                      '그럴 때마다 어떤 상황에서도 당신의\n'
                      '강인함과 인내심을 발견할 수 있었을 거에요.\n'
                      '또한, 어떤 어려움이든 극복할 능력을\n'
                      '갖고 있다는 것을 기억해주세요.\n'
                      '\n'
                      '더 나은 날들이 올 거라 믿어요.\n',
                  style: TextStyle(
                      fontFamily: 'soojin',
                      fontSize: 16,
                      color: Colors.brown)),
            ]))),
    Container(
      color: Colors.black26,
      width: 250,
      height: 1,
    ),
    Container(
      width: 300,
      padding:
      EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text:
                '혼자서 감정을 다스리기 어려울 수 있어요.\n'
                    '상담사와 이야기를 나눠보는 건 어떨까요?\n'
                    '\n'
                    '당신의 이야기를 듣고 함께 해결책을\n'
                    '찾아갈 수 있도록 최선을 다해 도와줄게요.\n',
                style: TextStyle(
                    fontFamily: 'soojin',
                    fontSize: 16,
                    color: Colors.brown)),
          ],
        ),
      ),
    ),

    Container(
      padding:
      EdgeInsets.fromLTRB(10, 0, 10, 8),
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: Color(0xFF745A52),
        strokeWidth: 2,
        radius: Radius.circular(20),
        dashPattern: [13, 13],
        child: SizedBox(
          width: 380,
          height: 150,
          child: Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Image.asset(
                  'images/main/free-icon-communication-3820107.png',
                  width: 40,
                  height: 40, color: Colors.brown),
              Column(
                children: [
                  Padding(
                      padding:
                      EdgeInsets.fromLTRB(
                          0, 5, 0, 0)),
                  Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 70,
                    child: (Text(
                      '정신건강 위기 상담전화\n(1577-0199)',
                      style: TextStyle(fontSize: 16,
                          fontFamily: 'soojin',
                          color: Colors.brown),)),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 70,
                    child: (Text('자살 상담전화(1393)',
                      style: TextStyle(fontSize: 16,
                          fontFamily: 'soojin',
                          color: Colors.brown),)),

                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  ],
);

Widget happyM = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
        width: 300,
        padding:
        EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: '"EMO:D의 한마디"\n\n',
                  style: TextStyle(
                      fontFamily: 'soojin',
                      fontSize: 30,
                      color: Colors.brown)),
              TextSpan(
                  text:
                  '이번 달은 행복한 날들이 많았던 것 같아 EMO:D도 기쁩니다!'
                      '\n\n'
                      '좋은 일들이 있었다면 그 속에는\n'
                      '당신의 긍정적인 마음이\n'
                      '큰 역할을 했을 거라 생각해요.\n'
                      '\n'
                      '그동안 겪은 모든 경험들이 당신에게 좋은\n'
                      '영향을 미쳤을 것이라고 확신합니다!\n'
                      '\n',
                  style: TextStyle(
                      fontFamily: 'soojin',
                      fontSize: 16,
                      color: Colors.brown)),
            ]))),
    Container(
      color: Colors.black26,
      width: 250,
      height: 1,
    ),
    Container(
      width: 300,
      padding:
      EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text:
                '\n'
                    '이런 특별한 순간을 소중하고 감사하게 여기며\n'
                    '더 많은 행복들을 만들어내길 기대하고\n'
                    '그런 순간들이 계속해서 이어지길 바라요:D\n'
                    '\n',
                style: TextStyle(
                    fontFamily: 'soojin',
                    fontSize: 16,
                    color: Colors.brown)),
          ],
        ),
      ),
    ),
    Container(
      color: Colors.black26,
      width: 250,
      height: 1,
    ),
    Container(
      width: 300,
      padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            children: [
              TextSpan(
                  text: '\n'
                      '당당하게 나아가며 더 많은 즐거운 순간을\n'
                      '만들어 나가길 기대하고 있고,\n'
                      '당신의 긍정적인 에너지가 주변에도 전해져\n'
                      '더 많은 행복을 만들어 나가길 희망할게요!\n',
                  style: TextStyle(
                      fontFamily: 'soojin',
                      fontSize: 16,
                      color: Colors.brown)
              )
            ]
        ),
      ),
    ),
  ],
);

Widget calmM = Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Container(
        width: 300,
        padding:
        EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: '"EMO:D의 한마디"\n\n',
                  style: TextStyle(
                      fontFamily: 'soojin',
                      fontSize: 30,
                      color: Colors.brown)),
              TextSpan(
                  text:
                  '이번 달은 평온한 날들이 많았나보군요.'
                      '\n\n'
                      '이러한 날들 속에도 소중한 순간들이\n'
                      '많았을 것입니다.\n\n'
                      '때로는 조용하고 차분한 시간이 필요하고,\n'
                      '그 안에서 새로운 에너지를 찾을 수도 있어요.\n\n'
                      '일상의 소소한 기쁨이나 안락함을 느끼며\n'
                      '하루를 보내는 것 역시 중요한 일이에요.\n'
                      '\n',
                  style: TextStyle(
                      fontFamily: 'soojin',
                      fontSize: 16,
                      color: Colors.brown)),
            ]))),
    Container(
      color: Colors.black26,
      width: 250,
      height: 1,
    ),
    Container(
      width: 300,
      padding:
      EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text:
                '\n'
                    '평범한 날들이라 해서 특별하지 않다고\n'
                    '생각하지 않아도 돼요.\n'
                    '\n'
                    '지금의 평온한 순간을 느끼며 휴식을 취하고,\n'
                    '내 안의 소소한 기쁨들을 발견해보는 것도\n'
                    '좋은 방법입니다:D\n'
                    '\n',
                style: TextStyle(
                    fontFamily: 'soojin',
                    fontSize: 16,
                    color: Colors.brown)),
          ],
        ),
      ),
    ),
    Container(
      color: Colors.black26,
      width: 250,
      height: 1,
    ),
    Container(
      width: 300,
      padding:
      EdgeInsets.fromLTRB(0, 15, 0, 0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text:
                '\n'
                    '모든 순간은 의미가 있고,\n'
                    '그 속에서 찾는 웃음이나 안정감은\n'
                    '큰 행복으로 이어질 수 있습니다.\n'
                    '\n'
                    '조용한 날들도 그 자체로 가치있고,\n'
                    '평온함을 느끼며 내 안의 평화를\n'
                    '찾아가는 여정에 기대어 보는건 어때요?\n'
                    '\n',
                style: TextStyle(
                    fontFamily: 'soojin',
                    fontSize: 16,
                    color: Colors.brown)),
          ],
        ),
      ),
    ),

  ],
);


class monthlyStatistics extends StatefulWidget {

  const monthlyStatistics({super.key});

  @override
  State<monthlyStatistics> createState() => _monthlyStatisticsState();
}

class _monthlyStatisticsState extends State<monthlyStatistics> {

  ApiManager apiManager = ApiManager().getApiManager();

  @override
  void initState() {
    super.initState();
    //print("message.dart입장 ");
    // 서버로부터 채팅방 목록 불러오기
    fetchDataFromServer();
  }

  late DateTime date;
  late List<double> emotions;
  late int mostEmotion;
  late int leastEmotion;
  late String comment;
  late int point;

  List<MonthData> monthDatas = [];

  Future<void> fetchDataFromServer() async {
    try{
      final data = await apiManager.getMSatisData();
      setState(() {
        monthDatas = data! as List<MonthData>;
      });
    }
    catch (error) {
      // 에러 제어하는 부분
      print('Error getting chat list: $error');
    }

  }

  Future<void> GetMStatis(String endpoint) async {
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['date']; // 키를 통해 value를 받아오기
      print('date: $value');
      date = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['emotions']; // 키를 통해 value를 받아오기
      print('emotions: $value');
      emotions = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['mostEmotion']; // 키를 통해 value를 받아오기
      print('mostEmotion: $value');
      mostEmotion = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['leastEmotion']; // 키를 통해 value를 받아오기
      print('leastEmotion: $value');
      leastEmotion = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['comment']; // 키를 통해 value를 받아오기
      print('comment: $value');
      comment = value;
    } catch (e) {
      print('Error: $e');
    }
    try {
      final response = await apiManager.Get(endpoint);
      // 실제 API 엔드포인트로 대체
      final value = response['point']; // 키를 통해 value를 받아오기
      print('point: $value');
      point = value;

    } catch (e) {
      print('Error: $e');
    }
  }

  String selectedValue = '최신순';

  void _reverseList() {
    setState(() {
      title = List.from(title.reversed);
      //emotioncount = List.from(emotioncount.reversed);
      mostemo = List.from(mostemo.reversed);
      worstemo = List.from(worstemo.reversed);
      mymonth = List.from(mymonth.reversed);
      total = List.from(total.reversed);
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizeX = MediaQuery
        .of(context)
        .size
        .width;
    final sizeY = MediaQuery
        .of(context)
        .size
        .height;

    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "EMO:D",
          style: TextStyle(
            fontSize: 30,
            fontFamily: 'kim',
            color: Color(0xFF968C83),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => statistics()));
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DropdownButton<String>(
                    value: selectedValue,
                    // 현재 선택된 값
                    items: <String>['최신순', '오래된순'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value!;

                        if (selectedValue == '오래된순') {
                          _reverseList(); // Reverse the list
                        }
                        else {
                          _reverseList();
                        }
                      });
                    },
                    underline: Container(
                      height: 2,
                      color: Colors.brown,
                    ),
                    dropdownColor: Color(0xFFF8F5EB),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.brown),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 25),
                ],
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              itemCount: monthDatas.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                          bottom: Radius.circular(10)),
                      color: Colors.white,
                    ),
                    child: ExpansionTile(
                      title: Text('${monthDatas[index].date.year}년 ${monthDatas[index].date.month}월 감정통지서',
                        //'10월감정통지서' ,
                        style: TextStyle(
                          fontFamily: "soojin",
                          fontSize: 25,
                          color: Color(0xFF968C83),
                        ),
                      ),
                      initiallyExpanded: false,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    //원형그래프 + 감정
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: DottedBorder(
                                        borderType: BorderType.RRect,
                                        color: Color(0xFF745A52),
                                        strokeWidth: 2,
                                        radius: Radius.circular(20),
                                        dashPattern: [13, 13],
                                        child: SizedBox(
                                          width: 400,
                                          height: 250,
                                          child: Row(
                                            children: [
                                              Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 0, 0, 0)),
                                              SizedBox(
                                                width: 180,
                                                child: MyPieChart(),
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                      padding: EdgeInsets
                                                          .fromLTRB(
                                                          130, 7, 0, 0)),
                                                  Container(
                                                    height: 120,
                                                    width: 130,
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          '가장 많았던 감정',
                                                          style: TextStyle(
                                                              fontFamily: 'soojin',
                                                              fontSize: 16),
                                                        ),
                                                        Image.asset(
                                                          'images/emotion/2.gif',
                                                          width: 90,
                                                          height: 90,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 120,
                                                    width: 130,
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          '가장 많았던 감정',
                                                          style: TextStyle(
                                                              fontFamily: 'soojin',
                                                              fontSize: 16),
                                                        ),
                                                        Image.asset(
                                                          'images/emotion/5.gif',
                                                          width: 90,
                                                          height: 90,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // 막대그래프
                                    Center(
                                      child: Container(
                                        width: 380,
                                        height: 210,
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFE1DED6),
                                          borderRadius: BorderRadius.circular(
                                              15),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Container(
                                              height: 150,
                                              child: MyBarGraph_M(
                                                emotioncount: monthDatas[index].emotions,
                                              ),
                                            ),
                                            //감정 이모션 사진
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 28,
                                                    height: 28,
                                                    margin: const EdgeInsets
                                                        .all(6.5),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                          'images/emotion/1.gif',
                                                        ),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Container(
                                                    width: 28,
                                                    height: 28,
                                                    margin: const EdgeInsets
                                                        .all(6.5),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/emotion/2.gif'),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Container(
                                                    width: 28,
                                                    height: 28,
                                                    margin: const EdgeInsets
                                                        .all(6.5),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/emotion/angry.png'),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Container(
                                                    width: 28,
                                                    height: 28,
                                                    margin: const EdgeInsets
                                                        .all(6.5),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/emotion/4.gif'),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Container(
                                                    width: 28,
                                                    height: 28,
                                                    margin: const EdgeInsets
                                                        .all(6.5),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/emotion/5.gif'),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Container(
                                                    width: 28,
                                                    height: 28,
                                                    margin: const EdgeInsets
                                                        .all(6.5),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/emotion/6.gif'),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 5,),
                                                  Container(
                                                    width: 28,
                                                    height: 28,
                                                    margin: const EdgeInsets
                                                        .all(6.5),
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            'images/emotion/7.gif'),
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    // emod의 한마디
                                    Container(
                                        width: 380,
                                        //height: 600,
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFDAD4CC),
                                          borderRadius: BorderRadius.circular(
                                              15),
                                        ),
                                        child: LayoutBuilder(
                                          builder: (BuildContext context,
                                              BoxConstraints constraints) {
                                            if (monthDatas[index].point == 1) {
                                              //print(ctotalEmo);
                                              return happyM;
                                            }
                                            else if (monthDatas[index].point == 2)
                                              return sadM;
                                            else if (monthDatas[index].point == 3)
                                              return calmM;
                                            else {
                                              //print(ctotalEmo);
                                              return Container();
                                            }
                                          },
                                        )),

                                    // 나의 n월은
                                    Container(
                                        width: 380,
                                        //height: 200,
                                        padding: const EdgeInsets.all(8.0),
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFFDACFC4),
                                          borderRadius: BorderRadius.circular(
                                              15),
                                        ),
                                        child: LayoutBuilder(
                                          builder: (BuildContext context,
                                              BoxConstraints constraints) {
                                            return Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              // 위아래 중앙 정렬
                                              children: [
                                                Container(
                                                    width: 300,
                                                    height: 40,
                                                    padding:
                                                    EdgeInsets.fromLTRB(
                                                        0, 5, 0, 0),
                                                    child: RichText(
                                                        textAlign: TextAlign
                                                            .center,
                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text: '나의 ${monthDatas[index]
                                                                      .date.month}월은',
                                                                  //n월로 변경해야함
                                                                  style: TextStyle(
                                                                      fontSize: 30,
                                                                      fontFamily: 'soojin',
                                                                      color: Colors
                                                                          .brown)),
                                                            ]))),
                                                Container(
                                                  color: Colors.black26,
                                                  width: 250,
                                                  height: 1,
                                                ),
                                                Padding(padding: EdgeInsets
                                                    .fromLTRB(15, 10, 0, 0)),
                                                Container(
                                                    width: 250,
                                                    child: RichText(
                                                        textAlign: TextAlign
                                                            .center,
                                                        text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text: monthDatas[index].comment,
                                                                  //n월로 변경해야함
                                                                  style: TextStyle(
                                                                      fontSize: 16,
                                                                      fontFamily: 'soojin',
                                                                      color: Colors
                                                                          .brown)),
                                                            ]
                                                        )
                                                    )
                                                ),
                                              ],

                                            );
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(
                    height: 10,
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

//커스텀 컨테이너
/*class MyCustomContent extends StatelessWidget {

  final DateTime ctitle;
  final List<double> cemotions;
  final String cmostEmo;
  final String cworstEmo;
  final String cmyMonth;
  final double ctotalEmo; //하드코딩쭈고
  MyCustomContent({super.key,
    required this.ctitle,
    required this.cemotions,
    required this.cmostEmo,
    required this.cworstEmo,
    required this.cmyMonth,
    required this.ctotalEmo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: Text('${monthDatas} 감정통지서',
          //'10월감정통지서' ,
          style: TextStyle(
            fontFamily: "soojin",
            fontSize: 25,
            color: Color(0xFF968C83),
          ),
        ),
        initiallyExpanded: false,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(5),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  width: double.infinity,
                  child: Column(
                    children: [
                      //원형그래프 + 감정
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
                            height: 250,
                            child: Row(
                              children: [
                                Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                                SizedBox(
                                  width: 180,
                                  child: MyPieChart(),
                                ),
                                Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            130, 7, 0, 0)),
                                    Container(
                                      height: 120,
                                      width: 130,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text(
                                            '가장 많았던 감정',
                                            style: TextStyle(
                                                fontFamily: 'soojin',
                                                fontSize: 16),
                                          ),
                                          Image.asset(
                                            'images/emotion/2.gif',
                                            width: 90,
                                            height: 90,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 120,
                                      width: 130,
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          Text(
                                            '가장 많았던 감정',
                                            style: TextStyle(
                                                fontFamily: 'soojin',
                                                fontSize: 16),
                                          ),
                                          Image.asset(
                                            'images/emotion/5.gif',
                                            width: 90,
                                            height: 90,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // 막대그래프
                      Center(
                        child: Container(
                          width: 380,
                          height: 210,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFE1DED6),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 150,
                                child: MyBarGraph_M(
                                  emotioncount: cemotions,
                                ),
                              ),
                              //감정 이모션 사진
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 28,
                                      height: 28,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'images/emotion/1.gif',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: 28,
                                      height: 28,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/2.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: 28,
                                      height: 28,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/angry.png'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: 28,
                                      height: 28,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/4.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: 28,
                                      height: 28,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/5.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: 28,
                                      height: 28,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/6.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5,),
                                    Container(
                                      width: 28,
                                      height: 28,
                                      margin: const EdgeInsets.all(6.5),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'images/emotion/7.gif'),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // emod의 한마디
                      Container(
                          width: 380,
                          //height: 600,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFDAD4CC),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              if (ctotalEmo == 1) {
                                print(ctotalEmo);
                                return happyM;
                              }
                              else if (ctotalEmo == 2)
                                return sadM;
                              else if (ctotalEmo == 3)
                                return calmM;
                              else {
                                print(ctotalEmo);
                                return Container();
                              }
                            },
                          )),

                      // 나의 n월은
                      Container(
                          width: 380,
                          //height: 200,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Color(0xFFDACFC4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                // 위아래 중앙 정렬
                                children: [
                                  Container(
                                      width: 300,
                                      height: 40,
                                      padding:
                                      EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: '나의 ${ctitle.month}월은',
                                                //n월로 변경해야함
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontFamily: 'soojin',
                                                    color: Colors.brown)),
                                          ]))),
                                  Container(
                                    color: Colors.black26,
                                    width: 250,
                                    height: 1,
                                  ),
                                  Padding(padding: EdgeInsets.fromLTRB(
                                      15, 10, 0, 0)),
                                  Container(
                                      width: 250,
                                      child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            TextSpan(
                                                text: cmyMonth, //n월로 변경해야함
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: 'soojin',
                                                    color: Colors.brown)),
                                          ]
                                          )
                                      )
                                  ),
                                ],

                              );
                            },
                          )),
                    ],
                  ),
                ),
              )),
        ],
      ),

    );
  }
}*/