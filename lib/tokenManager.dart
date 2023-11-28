class TokenManager {
  static final TokenManager tokenManager = new TokenManager();
  String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhcGRkbDVAbmF2ZXIuY29tIiwiaWF0IjoxNzAwMTM4NDk0LCJleHAiOjE3MDEzNDgwOTQsInN1YiI6ImFwZGRsNUBuYXZlci5jb20iLCJpZCI6MzZ9.aBKQ6Fm2DaARJ_yHKin0CsJjU9wltWHP4KjYkTVrmJQ";
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

