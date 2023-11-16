import 'category.dart';
import 'package:flutter/material.dart';

class ListData{
  final String help;
  final String ans;

  ListData(this.help, this.ans);
}

List<ListData> helpList = [
  ListData('카카오 로그인말고는 없나요?', '네. 저희는 카카오 로그인뿐입니다.'),
ListData('로그인했던 카카오 계정을 삭제했어요.','저런... 다시 만드시죠?',),
ListData('프로필 이름을 변경하고 싶어요.','변경하시면 됩니다.\n'
'프로필 들어가셔서 이름 바꾸면 될걸요?',),
ListData('회원 탈퇴는 어떻게 하나요?', '회원 탈퇴는 안됩니다.\n'
'한 번 회원은 영원한 회원!!\n'
'구라고 회원 탈퇴 누르면 탈퇴됩니다.\n'
'근데 탈퇴하지 마세요. 제발요.',),
ListData('내 일기는 안전하게 보관 되나요?', '아니요.\n'
'저희 개발자들이 맨날 일기 훔쳐봅니다.\n',),
ListData('앱 언어는 어떻게 바꾸나요?','저희는 애국자라 한국어밖에 없어요.',),
ListData('내가 쓴 댓글을 삭제하고 싶어요.', '삭제 안됩니다.\n'
'자신이 한 말에 책임을 지세요.',),
ListData('신고하고 싶어요.', '신고하세요.',),
ListData('푸시 알림이 오지 않아요.', '알림 센터 들어가서 확인해보세요,\n'
'카테고리 > 알람 설정에 있습니다.'),
];

class help extends StatelessWidget {
  const help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F5EB),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Text(
          "자주 하는 질문",
          style: TextStyle(
              color: Color(0xFF968C83), fontFamily: 'kim', fontSize: 30
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => category()));
          },
          icon: Icon(Icons.arrow_back_ios,color: Color(0xFF968C83),),
        ),
      ),
      body: ListView.builder(

        itemCount: helpList.length,
          itemBuilder: (BuildContext context, int index){
          return Theme(
            data: ThemeData(dividerColor: Colors.transparent),
            child: ExpansionTile(

              tilePadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              title: Text(helpList[index].help,
                style: TextStyle(
                  fontFamily: 'soojin',
                  fontSize:20,
                  color : Color(0xFF968C83),
                ),
              ),
              initiallyExpanded: false,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(20),
                  child: Container(
                    width: double.infinity,
                    child: Text(helpList[index].ans,
                      style: TextStyle(
                        fontFamily: 'soojin',
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          );

          },
          //child: Text('자주 하는 질문', style: TextStyle(fontFamily: 'soojin', fontSize: 40, color: Colors.brown),)
      ),
    );
  }
}