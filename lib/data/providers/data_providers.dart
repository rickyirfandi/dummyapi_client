import 'package:dio/dio.dart';
import 'package:dummyapi_client/const/api.dart';

class DataProvider {
  Dio connect = Dio();

  DataProvider() {
    setUpConnection();
  }

  void setUpConnection() {
    connect.options.headers['app-id'] = '62edc4d5bf2669010d763e0a';
  }

  Future<List<dynamic>> getUser(int page) async {
    try {
      var response =
          await connect.get('$baseUrl/user?page=$page&limit=$apiLimit');
      print("response data : $response");
      return response.data["data"];
    } on DioError catch (e) {
      print(e.message);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getDetailUser() async {
    try {
      var response =
          await connect.get('$baseUrl/user/60d0fe4f5311236168a109ca');
      print("response data : $response");
      return response.data["data"];
    } on DioError catch (e) {
      print(e.message);
      rethrow;
    }
  }

  Future<List<dynamic>> getPostUser() async {
    try {
      var response =
          await connect.get('$baseUrl/user/60d0fe4f5311236168a109ca/post');
      print("response data : $response");
      return response.data["data"];
    } on DioError catch (e) {
      print(e.message);
      rethrow;
    }
  }

  Future<List<dynamic>> getAllPost(int page) async {
    try {
      var response =
          await connect.get('$baseUrl/post?page=$page&limit=$apiLimit');
      print("response data : $response");
      return response.data["data"];
    } on DioError catch (e) {
      print(e.message);
      rethrow;
    }
  }

  Future<List<dynamic>> getPostByTag(String tag) async {
    try {
      var response = await connect.get('$baseUrl/tag/$tag/post');
      print("response data : $response");
      return response.data["data"];
    } on DioError catch (e) {
      print(e.message);
      rethrow;
    }
  }
}
