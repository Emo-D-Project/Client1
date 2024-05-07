class TokenManager {
  static final TokenManager tokenManager = new TokenManager();

  String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhcGRkbDVAbmF2ZXIuY29tIiwiaWF0IjoxNzExODU4ODY3LCJleHAiOjE3MTcwNDI4NjcsInN1YiI6ImFwZGRsNUBuYXZlci5jb20iLCJpZCI6MX0.4_joPu2_JOTOugCuJgVy2eNZJohhjJJ2H5K48AjoirA";

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
