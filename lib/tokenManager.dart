import "package:capston1/network/api_manager.dart";
import "package:capston1/login.dart";

class TokenManager {
  static final TokenManager tokenManager = new TokenManager();
  ApiManager apiManager = ApiManager().getApiManager();

  String accessToken = "";
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
