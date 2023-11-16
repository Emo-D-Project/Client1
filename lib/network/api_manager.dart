import 'dart:convert';
import 'package:capston1/tokenManager.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';


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


  Future<List<Map<String, dynamic>>> getCalendarData(DateTime date) async {
    String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(date);

    String baseUrl = "http://localhost:8080";
    String accessToken = tokenManager.getAccessToken();

    Dio dio = Dio();

    try {
      // 비동기식으로 Dio 요청 보내기
      Response<dynamic> response = await dio.get(
        '$baseUrl/api/calendars/date/$formattedDate',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 200) {
        return json.decode(response.data) as List<Map<String, dynamic>>;
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (error) {
      // 에러 처리
      print("에러 발생: $error");
      return []; // 에러가 발생하면 빈 List 반환 또는 다른 처리를 할 수 있습니다.
    }
  }
}
