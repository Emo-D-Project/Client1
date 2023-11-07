
class TokenManager {
  static final TokenManager tokenManager = new TokenManager();
  late String accessToken;
  late String refreshToken;

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







}
