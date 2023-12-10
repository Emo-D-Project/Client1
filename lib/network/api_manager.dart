import 'dart:convert';
import 'dart:io';
import 'package:capston1/models/MyInfo.dart';
import 'package:capston1/tokenManager.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../models/Alram.dart';
import '../models/ChatRoom.dart';
import '../models/Diary.dart';
import '../models/Message.dart';
import '../models/MonthData.dart';
import '../models/TotalData.dart';
import '../models/Mypage.dart';
import '../models/Comment.dart';
import 'package:http_parser/http_parser.dart';


class ApiManager {
  static ApiManager apiManager = new ApiManager();
  TokenManager tokenManager = TokenManager().getTokenManager();

  ApiManager getApiManager() {
    return apiManager;
  }

  String baseUrl = "http://34.22.108.184:8080";

  // 정보 받아올 때
  Future<List<dynamic>> GetMessage(String endpoint) async {
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

  Future<List<dynamic>> GetListWithHeadData(String endpoint,
      String data) async {
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
            'Failed to make a POST request. Status code: ${response
                .statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');
      // 에러를 처리하거나 사용자에게 알릴 수 있음
      // 예를 들어, ScaffoldMessenger 또는 showDialog를 사용하여 에러 메시지 표시
      throw e;
    }
  }

  Future<Map<String, dynamic>> Get(String endpoint) async {
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
      print("getCalendarData에서 서버로부터 받아온 데이터의 body : ${response.body}");

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
          otherUserId: data['otherUserId'],
          name: data['name'],
          lastMessage: data['lastMessage'],
          lastMessageSentAt: DateTime.parse(data['lastMessageSentAt']),
          isRead: data['read'] == true,
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
          content: data['content'],
          date: DateTime.parse(data['createdAt']),
          emotion: data['emotion'],
          userId: data['user_id'] as int ?? 0,
          favoriteCount: data['empathy'] as int ?? 0,
          audio: data["audio"] ?? "",
          imagePath: List<String>.from(data['images'].where((element) => element != null) ?? const []),
          favoriteColor: data['favoriteColor'] ?? false,
          diaryId: data['id'] ?? 0,
          is_comm: data['is_comm'] ?? true,
          is_share: data['is_share'] ?? true,
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
      print("댓글 data: " + response.body);

      List<Message> messages = rawData.map((data) {
        return Message(
          receiverId: data['receiverId'],
          senderId: data['senderId'],
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
            'Failed to make a POST request. Status code: ${response
                .statusCode}');
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

// 자신의 마이페이지에 등록한 정보들을 불러오는 기능
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
          userId: data['userId'],
          title: data['title'],
          content: data['content'],
        );
      }).toList();

      return mypagedata;
    } else {
      throw Exception("Fail to load mypage data from the API");
    }
  }

  // 아이디로 마이페이지에 등록한 정보들을 불러오는 기능
  Future<List<Mypage>> GetMyPageDataById(int userId) async {

    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/userInfo/$userId";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> rawData = json.decode(utf8.decode(response.bodyBytes));
      print("OtherUser page data: " + response.body);

      List<Mypage> mypagedata = rawData.map((data) {
        return Mypage(
          userId: data['userId'],
          title: data['title'],
          content: data['content'],
        );
      }).toList();

      return mypagedata;
    } else {
      throw Exception("Fail to load GetMyPageDataById data from the API 2");
    }
  }

  // 자신의 마이페이지에 등록한 자기 소개 정보를 불러오는 기능
  Future<String> GetMyPageDataIntrod() async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/userInfo/my";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      throw Exception("Fail to load GetMyPageDataIntrod data from the API 3 ");
    }
  }

  // 자신의 마이페이지에 등록한 자기 소개 정보를 불러오는 기능
  Future<int> GetMyId() async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/user";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return int.parse(response.body);
    }else {
      throw Exception("Fail to load My ID from the API");
    }
  }

  Future<DateTime> getCurrentTime() async {
    String accessToken = tokenManager.getAccessToken();
    String endpoint = "/api/korean-time";
    
    Uri uri = Uri.parse("$baseUrl$endpoint");

    final response = await http.get(
      uri,
      headers: {
      'Authorization': 'Bearer $accessToken',
      },
    );

    if(response.statusCode == 200){
      return DateTime.parse(response.body);
    } else{
      throw Exception("Fail to Load currentTime data from the API");
    }
  }


  // 자신의 마이페이지에 등록한 자기 소개 정보를 불러오는 기능
  Future<String> GetMyPageDataItrodById(int userId) async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/userInfo/description/${userId}";

    // Uri 객체를 사용하여 URL 조립
    Uri uri = Uri.parse('$baseUrl$endPoint?userId=$userId');

    print("GetMyPageDataItrodById endpoint: ${uri}");

    final response = await http.get(
      uri,
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Fail to load GetMyPageDataItrodById from the API");
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
          audio: data["audio"] ?? "",
          imagePath: List<String>.from(data['images']?.where((element) => element != null) ?? const []),
          favoriteColor: data['favoriteColor'] ?? false,
          diaryId: data['id'] ?? 0,
          is_comm: data['_comm'] ?? true,
          is_share: data['_share'] ?? true,
        );
      }).toList();

      return diaries;
    } else {
      throw Exception("Fail to load diary data from the API");
    }
  }

  Future<String> ConvertSpeechToText(String audioFilePath) async {

    var url = Uri.parse("$baseUrl/api/audio/upload");
    String accessToken = tokenManager.getAccessToken();

    var request = http.MultipartRequest('POST', url);

    var audioFile = audioFilePath; // 오디오 파일

    request.headers['Authorization'] = 'Bearer $accessToken';

    // 오디오 파일을 추가
    if (audioFile != null && audioFile.isNotEmpty) {
      print('Audio File Path: $audioFile');

      request.files.add(await http.MultipartFile.fromPath(
          'audioFile', audioFile, contentType: MediaType('audio', 'mp3')));
    } else {
      print('Warning: audioFile is empty or null. Skipping audioFile.');
    }

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        // response를 문자열로 변환
        var responseString = await response.stream.bytesToString();
        print("audio recognize response: $responseString");
        return responseString;
      } else {
        print('ConvertSpeechToText failed with status: ${response.statusCode}');
        return "";
      }
    } catch (e) {
      print('Error uploading data: $e');
    }

    return "";

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
    if (response.statusCode == 200) {} else {
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
            'Failed to make a POST request. Status code: ${response
                .statusCode}');
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

  // 마이페이지에 정보 등록하는 기능
  void sendMypageIntroduce(int userId, String title, String content) async {
    String endpoint = "/api/userInfo/my/description";
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
          data:content, // 요청 데이터
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

//마이페이지에 자기 소개 정보를 등록하는 기능
  void sendMypage(int userId, String title, String content) async {

    String endpoint = "/api/userInfo";
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
          "userId":userId,
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
            'Failed to make a POST request. Status code: ${response
                .statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');

      throw e;
    }
  }


  //==================================================
  void RemoveDiary(int id) async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/diaries/delete/${id}";

    Dio _dio = Dio();
    // 요청 헤더를 Map으로 정의
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await _dio.delete(
        '$baseUrl$endPoint',
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 200) {
        print("diary 삭제 성공");
      } else {
        print("응답 코드: ${response.statusCode}");
        throw Exception(
            'Failed to make a POST request. Status code: ${response
                .statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');
    }
  }

  Future<File?> saveXFileToFile(XFile? xFile) async {
    if (xFile == null) return null;

    try {
      final bytes = await xFile.readAsBytes();
      final tempDir = await getTemporaryDirectory();
      final tempPath = tempDir.path;
      final fileName = '${DateTime
          .now()
          .millisecondsSinceEpoch}.png';

      if (!await Directory(tempPath).exists()) {
        await Directory(tempPath).create(recursive: true);
      }

      final File file = File('$tempPath/$fileName');
      await file.writeAsBytes(bytes);

      // 파일이 성공적으로 저장되었는지 확인하는 로그
      print('Image File saved to: ${file.path}');

      return file;
    } catch (e) {
      // 파일 저장 중 발생한 오류 로그
      print('Error saving image file: $e');
      return null;
    }
  }

  Future<void> sendPostDiary(dynamic data, List<XFile?> images,
      dynamic audio) async {
    var url = Uri.parse("http://34.22.108.184:8080/api/diaries/create");
    String accessToken = tokenManager.getAccessToken();

    var requestData = {
      "request": {
        "content": data['content'],
        "emotion": data['emotion'],
        "is_share": data['is_share'],
        "is_comm": data['is_comm'],
      },
    };

    var request = http.MultipartRequest('POST', url);

    // 이미지 파일이 있는 경우에만 처리
    if (images != null && images.isNotEmpty) {
      List<File?> files = [];
      for (var xFile in images) {
        if (xFile != null) {
          File? file = await saveXFileToFile(xFile);
          if (file != null) {
            files.add(file);
          } else {
            print('Warning: Failed to get file from XFile. Skipping file.');
          }
        } else {
          print('Warning: xFile is null. Skipping xFile.');
        }
      }

      // 이미지 파일을 추가
      for (var imageFile in files) {
        if (imageFile != null) {
          print('Image File Path: ${imageFile.path}');
          request.files.add(await http.MultipartFile.fromPath(
              'imageFile', imageFile.path,
              contentType: MediaType('image', 'jpeg')));
        } else {
          print('Warning: imageFile is empty or null. Skipping imageFile.');
        }
      }
    } else {
      print('Warning: images list is null or empty. No image files to upload.');
    }

    var audioFile = audio; // 오디오 파일

    final jsonData = jsonEncode(requestData['request']);
    final jsonPart = http.MultipartFile.fromString("request", jsonData, filename: 'data.json', contentType: MediaType('application', 'json'));
    request.files.add(jsonPart);
    request.headers['Authorization'] = 'Bearer $accessToken';

    // 오디오 파일을 추가
    if (audioFile != null && audioFile.isNotEmpty) {
      print('Audio File Path: $audioFile');

      request.files.add(await http.MultipartFile.fromPath(
          'audioFile', audioFile, contentType: MediaType('audio', 'mp3')));
    } else {
      print('Warning: audioFile is empty or null. Skipping audioFile.');
    }

    try {
      var response = await request.send();

      if (response.statusCode == 201) {
        print('Uploaded!');
        print(await response.stream.bytesToString());
      } else {
        print('Upload failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading data: $e');
    }
  }

  void RemoveComment(int id) async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/comments/delete/${id}";

    Dio _dio = Dio();
    // 요청 헤더를 Map으로 정의
    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $accessToken',
    };
    try {
      var response = await _dio.delete(
        '$baseUrl$endPoint',
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 200) {
        print("댓글 삭제 성공");
      } else {
        print("응답 코드: ${response.statusCode}");
        throw Exception(
            'Failed to make a POST request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');
    }
  }

  Future<Diary> getMyDiaryData(int id) async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/diaries/read/${id}";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      dynamic rawData = json.decode(utf8.decode(response.bodyBytes));
      print("rawData : $rawData");
      print("my diary data: " + response.body);

      Diary diaries = Diary(
        date: DateTime.parse(rawData['createdAt']),
        content: rawData['content'],
        emotion: rawData['emotion'],
        diaryId: rawData['id']?? 0,
        userId: rawData['user_id']as int ?? 0,
        audio: rawData['audio'] ?? "",
        imagePath: List<String>.from(rawData['images'].where((element) => element != null) ?? const []),
        is_share: rawData['is_share'] ?? true,
        is_comm: rawData['is_comm'] ?? true,
      );
      return diaries;
    } else {
      print("응답 코드: ${response.statusCode}");
      throw Exception("Fail to load diary data from the API");
    }
  }
  Future<void> putDiaryUpdate(int id, String emotion, String content, bool is_share, bool is_comm) async {
    String endpoint = "/api/diaries/change/${id}";
    String accessToken = tokenManager.getAccessToken();

    Dio _dio = Dio();
    // 요청 헤더를 Map으로 정의
    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      var response = await _dio.put(
        '$baseUrl$endpoint',
        data: {
          "emotion": emotion,
          "content": content,
          "is_share": is_share,
          "is_comm": is_comm,
        },
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 200) {
        print("post 응답 성공");
      } else {
        print("응답 코드: ${response.statusCode}");
        throw Exception(
            'Failed to make a PUT request. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');

      throw e;
    }
  }

  Future<Alram> getAlramData() async {
    String accessToken = tokenManager.getAccessToken();
    String endPoint = "/api/settings";

    final response = await http.get(
      Uri.parse('$baseUrl$endPoint'),
      headers: <String, String>{
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      dynamic rawData = json.decode(utf8.decode(response.bodyBytes));
      print("Alram data: " + response.body);

      Alram Alramdata = Alram(
        id: rawData['id'],
        userId: rawData['userId'],
        allowMsg: rawData['allowMsg'],
        msgAlarm: rawData['magAlarm'],
        empAlarm: rawData['empAlarm'],
        commAlarm: rawData['commAlarm'],
        actAlarm: rawData['actAlarm'],
      );

      return Alramdata;
    } else {
      throw Exception("Fail to load alram data from the API");
    }
  }

  void sendMycomment(String comment) async {
    String endpoint = "/api/report/create/${comment}";
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
          "comment":comment,
        }, // 요청 데이터
        options: Options(headers: headers), // 요청 헤더 설정
      );

      if (response.statusCode == 200) {
        print("post 응답 성공");
      } else {
        print("응답 코드: ${response.statusCode}");
        throw Exception(
            'Failed to make a POST request. Status code: ${response
                .statusCode}');
      }
    } catch (e) {
      print('에러 발생: $e');

      throw e;
    }
  }


}