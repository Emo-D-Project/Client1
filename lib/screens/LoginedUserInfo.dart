class LoginedUserInfo{

  static LoginedUserInfo loginedUserInfo = new LoginedUserInfo();
  late int id;

  LoginedUserInfo GetInstance(){
    return loginedUserInfo;
  }

}