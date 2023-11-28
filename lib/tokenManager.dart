class TokenManager {
  static final TokenManager tokenManager = new TokenManager();
  String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhcGRkbDVAbmF2ZXIuY29tIiwiaWF0IjoxNzAxMTU4MzgxLCJleHAiOjE3MDExNjU1ODEsInN1YiI6ImFwZGRsNUBuYXZlci5jb20iLCJpZCI6MzZ9.Y73KL_t1dddXKVE0It3vRuXpFBfZVNC0c4i7aD2kYSE";
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

