class MyInfo {
  static final MyInfo myInfo = new MyInfo();
  late String nickName;
  int myUserId = 36;

  MyInfo getMyInfo() {
    return myInfo;
  }

  String getNickName() {
    return nickName;
  }

  int getMyUserId(){
    return myUserId;
  }

  void setNickName(String newNickName) {
    nickName = newNickName;
  }

  void setMyUserId(int myUserId){
    this.myUserId = myUserId;
  }
}
