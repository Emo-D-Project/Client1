class MyInfo {
  static final MyInfo myInfo = new MyInfo();
  late String nickName;

  MyInfo getMyInfo() {
    return myInfo;
  }

  String getNickName() {
    return nickName;
  }

  void setNickName(String newNickName) {
    nickName = newNickName;
  }
}
