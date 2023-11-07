import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiManager {
  static ApiManager apiManager = new ApiManager();
  String accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJhcGRkbDVAbmF2ZXIuY29tIiwiaWF0IjoxNjk4OTE1NTk4LCJleHAiOjE3MDAxMjUxOTgsInN1YiI6ImFwZGRsNUBuYXZlci5jb20iLCJpZCI6MzZ9._Pb7ja4jgSp0XNk9Vgtub61v1TGdNbJ5lQngsEkjYzg";

  ApiManager getApiManager(){
    return apiManager;
  }

  final String baseUrl = "http://34.64.78.183:8080";

  // 정보 받아올 때
  Future<Map<String, dynamic>> Get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'authorization': 'Beaer ' + accessToken, // 요청 헤더 설정
      },
    );

    if (response.statusCode == 200) { // 통신 성공 시
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8', // 요청 헤더 설정
        'authorization': 'Beaer ' + accessToken,

      },
      body: jsonEncode(data), // 요청 데이터를 JSON 형식으로 변환
    );

    if (response.statusCode == 200) { // 성공적인 응답
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }


}
