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

  Future<Map<String, dynamic>> getDetailUser(String id) async {
    try {
      var response = await connect.get('$baseUrl/user/$id');
      print("response data : $response");
      return response.data;
    } on DioError catch (e) {
      print(e.message);
      rethrow;
    }
  }

  Future<List<dynamic>> getPostUser(String id, int page) async {
    try {
      var response = await connect
          .get('$baseUrl/user/$id/post?page=$page&limit=$apiLimit');
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

  Future<List<dynamic>> getPostByTag(String tag, int page) async {
    try {
      var response = await connect
          .get('$baseUrl/tag/$tag/post?page=$page&limit=$apiLimit');
      print("response data : $response");
      return response.data["data"];
    } on DioError catch (e) {
      print(e.message);
      rethrow;
    }
  }
}
