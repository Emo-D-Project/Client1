import 'dart:convert';
import 'package:capston1/tokenManager.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ApiManager {
  static ApiManager apiManager = new ApiManager();
  TokenManager tokenManager = TokenManager().getTokenManager();

  ApiManager getApiManager(){
    return apiManager;
  }

  String baseUrl = "http://34.64.78.183:8080";

  // 정보 받아올 때
  Future<List<dynamic>> GetMessage(String endpoint) async {

    baseUrl = "http://34.64.78.183:8080";
    String accessToken = tokenManager.getAccessToken();

    final response = await http.get(Uri.parse('$baseUrl$endpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken', // 요청 헤더 설정
      },
    );


    if (response.statusCode == 200) { // 통신 성공 시
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }
  Future<Map<String, dynamic>> Get(String endpoint) async {

    baseUrl = "http://34.64.78.183:8080";
    String accessToken = tokenManager.getAccessToken();

    final response = await http.get(Uri.parse('$baseUrl$endpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken', // 요청 헤더 설정
      },
    );


    if (response.statusCode == 200) { // 통신 성공 시
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  //정보 보낼 때
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {

    baseUrl = "http://34.64.78.183:8080";
    String accessToken = tokenManager.getAccessToken();

    Dio _dio = Dio();
    // 요청 헤더를 Map으로 정의
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      var response = await _dio.post(
        '$baseUrl$endpoint',
        data: data, // 요청 데이터
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 201) {
        print("post 응답 성공");
        return response.data;
      } else {
        print("응답 코드: ${response.statusCode}");
        throw Exception('Failed to make a POST request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');
      // 에러를 처리하거나 사용자에게 알릴 수 있음
      // 예를 들어, ScaffoldMessenger 또는 showDialog를 사용하여 에러 메시지 표시
      throw e;
    }
  }


  // 카카오 토큰을 이용해서 서버 토큰을 받기 위한 함수
  Future<Map<String, dynamic>> getServerToken (String kakaoAccessToken) async {
    String endpoint = "/user/auth/kakao";

    final response = await http.get(Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'kakaoAccessToken': 'Bearer $kakaoAccessToken', // 요청 헤더 설정
      },
    );

    if (response.statusCode == 200) { // 통신 성공 시
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }


}
