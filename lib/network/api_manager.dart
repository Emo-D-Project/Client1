import 'dart:convert';
import 'package:capston1/tokenManager.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../calendar.dart';
import '../models/ChatRoom.dart';
import '../models/Diary.dart';
import '../models/Message.dart';


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

  Map<DateTime, String> convertToDateTimeMap(Map<String, dynamic> input) {
    return Map<DateTime, String>.fromIterable(
      input.keys,
      key: (key) => DateTime.parse(key), // 키를 DateTime으로 변환
      value: (key) => input[key]!, // 값을 그대로 사용
    );
  }

  Future<Map<DateTime, String>?> getCalendarData() async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/calendars/date";

    final response = await http.get(Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken', // 요청 헤더 설정
      },
    );

    if (response.statusCode == 200) { // 통신 성공 시
      print("getCalendarData에서 서버로부터 받아온 데이터의 body : " + response.body);

      Map<DateTime, String> output = convertToDateTimeMap(json.decode(response.body));
      return output;
    } else {
      throw Exception('Failed to load data from the API');
    }
    // Make an API request to fetch diary data
    // Parse the response and return a map of DateTime to List<DiaryEntry>
    return {
      DateTime(2023, 11, 1): "angry",
      DateTime(2023, 11, 2): "flutter",
      // Additional entries for other dates
    };
  }

  Future<List<ChatRoom>> getChatList() async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/messages/chatList";

    final response = await http.get(Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if(response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("chatList data: " + response.body);

      List<ChatRoom> chatRooms = rawData.map((data) {
        return ChatRoom(
          id: data['otherUserId'].toString(),
          name: data['name'],
          lastMessage: data['lastMessage'],
          lastMessageSentAt: DateTime.parse(data['lastMessageSentAt']),
          isRead: data['isRead'] ?? false, // Null이면 false로 설정
        );
      }).toList();

      return chatRooms;
    } else {
      throw Exception("Fail to load chatList from the API");
    }

  }

  Future<List<Diary>> getDiaryData() async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/diaries/mine/{userid}";

    final response = await http.get(Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if(response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("my diary data: " + response.body);

      List<Diary> diaries = rawData.map((data) {
        return Diary(
          date: DateTime.parse(data['createdAt']),
          content: data['content'],
          emotion: data['emotion']
        );
      }).toList();

      return diaries;
    } else {
      throw Exception("Fail to load diary data from the API");
    }

  }

  Future<List<Message>> getMessageList(int otherUserId) async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/messages/chat/$otherUserId";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("message List data: " + response.body);

      List<Message> messages = rawData.map((data) {
        return Message(
          content: data['content'],
          sendtime: DateTime.parse(data['sentAt']),
          isMyMessage: data['myMessage'] == 1 , // 내가 보낸 메시지인지 여부 확인
        );
      }).toList();

      return messages;
    } else {
      throw Exception("Fail to load chat data from the API");
    }
  }

  void sendMessage(String message, int otherUserId, DateTime dateTime) async {
    String endpoint = "/api/messages";
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
        data: {
          "content": message,
          "sentAt": DateFormat('yyyy-MM-ddTHH:mm:ss').format(dateTime.toUtc()),
          "receiverId": otherUserId,
        }, // 요청 데이터
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 201) {
        print("post 응답 성공");
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


}
