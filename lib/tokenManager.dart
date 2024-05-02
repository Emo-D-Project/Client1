class TokenManager {
  static final TokenManager tokenManager = new TokenManager();

  String accessToken = "";


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
