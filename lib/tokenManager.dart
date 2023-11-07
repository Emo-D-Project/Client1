import 'network/api_manager.dart';

class TokenManager {
  static TokenManager? _instance;
  late String accessToken;
  late String refreshToken;

  ApiManager apiManager = ApiManager().getApiManager();

  TokenManager._(); // private constructor

  factory TokenManager() {
    if (_instance == null) {
      _instance = TokenManager._();
    }
    return _instance!;
  }

  Future<void> getServerToken(String kakaoToken) async {
    try {
      final response = await apiManager.getServerToken(kakaoToken);

      accessToken = response["access_token"];
      refreshToken = response["refresh_token"];
    } catch (e) {
      print('Error: $e');
    }
  }
}
