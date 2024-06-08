class TokenManager {
  static final TokenManager tokenManager = new TokenManager();

  String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhcGRkbDVAbmF2ZXIuY29tIiwiaWF0IjoxNzE0NjM2ODA0LCJleHAiOjE3MTk4MjA4MDQsInN1YiI6ImFwZGRsNUBuYXZlci5jb20iLCJpZCI6MX0.SM5tgSvAwM34ZQeXuoTS7UWGMsRAHkZC3ofrvuoDdB8";
  //String accessToken = "";


  String refreshToken = "";

  String fcm = "";

  TokenManager getTokenManager() {
    return tokenManager;
  }

  String getAccessToken() {
    return accessToken;
  }

  void setAccessToken(String token) {
    accessToken = token;
  }

  String getRefreshToken() {
    return refreshToken;
  }

  void setRefreshToken(String token) {
    refreshToken = token;
  }

  String getFirebaseToken(){
    return fcm;
  }

  void setFirebaseToken(String token) {
    fcm = token;
  }

}
