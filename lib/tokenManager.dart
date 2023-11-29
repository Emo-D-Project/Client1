class TokenManager {
  static final TokenManager tokenManager = new TokenManager();
  String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhcGRkbDVAbmF2ZXIuY29tIiwiaWF0IjoxNzAxMjIzNDM3LCJleHAiOjE3MDY0MDc0MzcsInN1YiI6ImFwZGRsNUBuYXZlci5jb20iLCJpZCI6MzZ9.xVdHG6ZiNz__CJYVaL97_khHVuusBMlzfEr6NawrfMM";
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

