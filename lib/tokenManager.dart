
class TokenManager {
  static final TokenManager tokenManager = new TokenManager();
  String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhcGRkbDVAbmF2ZXIuY29tIiwiaWF0IjoxNjk4OTE1NTk4LCJleHAiOjE3MDAxMjUxOTgsInN1YiI6ImFwZGRsNUBuYXZlci5jb20iLCJpZCI6MzZ9._Pb7ja4jgSp0XNk9Vgtub61v1TGdNbJ5lQngsEkjYzg";
  String refreshToken = "";


  TokenManager getTokenManager(){
    return tokenManager;
  }

  String getAccessToken(){
    return accessToken;
  }

  void setAccessToken(String token){
    accessToken = token;
  }

  String getRefreshToken(){
    return refreshToken;
  }

  void setRefreshToken(String token){
    refreshToken = token;

  }






//}


}

