class TokenManager {
  static final TokenManager tokenManager = new TokenManager();

  String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhcGRkbDVAbmF2ZXIuY29tIiwiaWF0IjoxNzA4NjU5NjEwLCJleHAiOjE3MTM4NDM2MTAsInN1YiI6ImFwZGRsNUBuYXZlci5jb20iLCJpZCI6MX0.W8A4hxnJU9dDs13VyPN2w2T42aT5Rtmlp2p9ViDXSo0";

  String refreshToken = "";

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
}
