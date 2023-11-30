import 'dart:convert';
import 'package:capston1/tokenManager.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/ChatRoom.dart';
import '../models/Diary.dart';
import '../models/Message.dart';
import '../models/MonthData.dart';
import '../models/TotalData.dart';
import '../models/Mypage.dart';
import '../models/Comment.dart';

class ApiManager {
  static ApiManager apiManager = new ApiManager();
  TokenManager tokenManager = TokenManager().getTokenManager();

  ApiManager getApiManager() {
    return apiManager;
  }

  String baseUrl = "http://34.64.78.183:8080";

  // 정보 받아올 때
  Future<List<dynamic>> GetMessage(String endpoint) async {
    baseUrl = "http://34.64.78.183:8080";
    String accessToken = tokenManager.getAccessToken();

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken', // 요청 헤더 설정
      },
    );

    if (response.statusCode == 200) {
      // 통신 성공 시
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  Future<List<dynamic>> GetList(String endpoint) async {
    String accessToken = tokenManager.getAccessToken();

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken', // 요청 헤더 설정
      },
    );

    if (response.statusCode == 200) {
      // 통신 성공 시
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  Future<List<dynamic>> GetListWithHeadData(
      String endpoint, String data) async {
    String accessToken = tokenManager.getAccessToken();

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint/$data'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken', // 요청 헤더 설정
      },
    );

    if (response.statusCode == 200) {
      // 통신 성공 시
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  //정보 보낼 때
  Future<dynamic> post(String endpoint, dynamic data) async {
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
        throw Exception(
            'Failed to make a POST request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');
      // 에러를 처리하거나 사용자에게 알릴 수 있음
      // 예를 들어, ScaffoldMessenger 또는 showDialog를 사용하여 에러 메시지 표시
      throw e;
    }
  }

  Future<Map<String, dynamic>> Get(String endpoint) async {
    baseUrl = "http://34.64.78.183:8080";
    String accessToken = tokenManager.getAccessToken();

    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken', // 요청 헤더 설정
      },
    );

    if (response.statusCode == 200) {
      // 통신 성공 시
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  // 카카오 토큰을 이용해서 서버 토큰을 받기 위한 함수
  Future<Map<String, dynamic>> getServerToken(String kakaoAccessToken) async {
    String endpoint = "/user/auth/kakao";

    final response = await http.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: <String, String>{
        'kakaoAccessToken': 'Bearer $kakaoAccessToken', // 요청 헤더 설정
      },
    );

    if (response.statusCode == 200) {
      // 통신 성공 시
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

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken', // 요청 헤더 설정
      },
    );

    if (response.statusCode == 200) {
      // 통신 성공 시
      print("getCalendarData에서 서버로부터 받아온 데이터의 body : " + response.body);

      Map<DateTime, String> output =
          convertToDateTimeMap(json.decode(response.body));
      return output;
    } else {
      throw Exception('Failed to load data from the API');
    }
  }

  Future<List<ChatRoom>> getChatList() async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/messages/chatList";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
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

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("my diary data: " + response.body);

      List<Diary> diaries = rawData.map((data) {
        return Diary(
            date: DateTime.parse(data['createdAt']),
            content: data['content'],
            emotion: data['emotion']);
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
      print("댓글 data: " + response.body);

      List<Message> messages = rawData.map((data) {
        return Message(
          content: data['content'],
          sendtime: DateTime.parse(data['sentAt']),
          isMyMessage: data['myMessage'] == 1, // 내가 보낸 메시지인지 여부 확인
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
        throw Exception(
            'Failed to make a POST request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');

      throw e;
    }
  }

  Future<List<MonthData>> getMSatisData() async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/report/read";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("monthly statistics data: " + response.body);

      List<MonthData> MSatisdata = rawData.map((data) {
        return MonthData(
          date: DateTime.parse(data['date']),
          emotions: List<double>.from(data['emotions']),
          mostEmotion: data['mostEmotion'],
          leastEmotion: data['leastEmotion'],
          comment: data['comment'],
          point: data['point'],
        );
      }).toList();

      return MSatisdata;
    } else {
      throw Exception("Fail to load Month data from the API");
    }
  }

  Future<TotalData> getTSatisData() async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/report/analysis";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      dynamic rawData = json.decode(utf8.decode(response.bodyBytes));
      print("total statistics data: " + response.body);

      TotalData TSatisdata = TotalData(
        nums: rawData['nums'],
        emotions: List<double>.from(rawData['emotions']),
        mostWritten: rawData['mostWritten'],
        firstDate: DateTime.parse(rawData['firstDate']),
        mostYearMonth: DateTime.parse(rawData['mostYearMonth']),
        mostNums: rawData['mostNums'],
        mostViewed: rawData['mostViewed'],
        mostViewedEmpathy: rawData['mostViewedEmpathy'],
        mostViewedComments: rawData['mostViewedComments'],
      );

      return TSatisdata;
    } else {
      throw Exception("Fail to load total data from the API");
    }
  }

  Future<List<Mypage>> getMypageData() async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/userInfo";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("mypage data: " + response.body);

      List<Mypage> mypagedata = rawData.map((data) {
        return Mypage(
          title: data['title'],
          content: data['content'],
        );
      }).toList();

      return mypagedata;
    } else {
      throw Exception("Fail to load mypage data from the API");
    }
  }

  Future<List<Diary>> getDiaryShareData() async {
    String accessToken = tokenManager.getAccessToken();

    String endPoint = "/api/diaries/read";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("diary share List data: " + response.body);

      List<Diary> diaries = rawData.map((data) {
        return Diary(
          content: data['content'],
          date: DateTime.parse(data['createdAt']),
          emotion: data['emotion'],
          userId: data['user_id'] as int ?? 0,
          favoriteCount: data['empathy'] as int ?? 0,
          voice: data["voice"] ?? "",
          imagePath: List<String>.from(data['imagePath'] ?? const []),
          favoriteColor: data['favoriteColor'] ?? false,
          diaryId: data['id'] ?? 0,
        );
      }).toList();

      return diaries;
    } else {
      throw Exception("Fail to load diary data from the API");
    }
  }

  //좋아요 수
  Future<void> putFavoriteCount(int id) async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/diaries/recommend/${id}";

    print("put favoriteCount diary id: $id");

    final response = await http.put(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception(
          "Fail to load favorite data from the API : ${response.statusCode}");
    }
  }

//get 좋아요수 확인
  Future<int> getFavoriteCount(int id) async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/diaries/read/$id";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));

      return data["empathy"];
    } else {
      throw Exception("Fail to load getFavorite data from the API");
    }
  }

  Future<bool> GetFavoriteColor(int diaryId) async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/diaries/recommend/$diaryId";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(utf8.decode(response.bodyBytes));

      if (data == 0 || data == 1) {
        bool favoriteColor = data == 1;

        return favoriteColor;
      } else {
        throw Exception("Unexpected data value received from the API");
      }
    } else {
      throw Exception("Fail to load getFavorite data from the API");
    }
  }




//post 댓글작성
  void sendComment(String content, int post_id) async {
    String endpoint = "/api/comments/create";
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
          "content": content,
          "post_id": post_id,
        }, // 요청 데이터
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 201) {
        print("post 응답 성공");
      } else {
        print("응답 코드: ${response.statusCode}");
        throw Exception(
            'Failed to make a POST request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');

      throw e;
    }
  }

//get 댓글 확인
  Future<List<Comment>> getCommentData(int postId) async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/comments/read/${postId}";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("diary Comment list data: " + response.body);

      List<Comment> comment = rawData.map((data) {
        return Comment(
          content: data['content'],
          user_id: data['user_id'],
          post_id: data['post_id'],
          id: data['id'],
        );
      }).toList();
      return comment;
    } else {
      throw Exception("Fail to load comment data from the API");
    }
  }

  void sendMypage(String title, String content) async {
    String endpoint = "/api/userInfo";
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
          "title": title,
          "content": content,
        }, // 요청 데이터
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 201) {
        print("post 응답 성공");
      } else {
        print("응답 코드: ${response.statusCode}");
        throw Exception(
            'Failed to make a POST request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');

      throw e;
    }
  }
}
