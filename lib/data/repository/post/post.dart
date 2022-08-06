import 'package:dummyapi_client/data/models/post/post.dart';
import 'package:dummyapi_client/data/models/user/user.dart';
import 'package:dummyapi_client/data/providers/data_providers.dart';
import 'package:get/get.dart';

class PostRepository {
  DataProvider dataProvider = DataProvider();
  static RxList<Post> postList = <Post>[].obs;
  static RxList<Post> userPostList = <Post>[].obs;
  static RxList<Post> filteredPostList = <Post>[].obs;
  static int postPage = -1;

  bool isLoading = false;

  static RxString filter = "".obs;

  void refresh() {
    postPage = -1;
    postList.clear();
    userPostList.clear();
    filteredPostList.clear();
    isLoading = false;
  }

  Future<void> getPost() async {
    if (isLoading) return;
    isLoading = true;
    postPage++;
    try {
      var response;
      if (filter.value != "") {
        response = await dataProvider.getPostByTag(filter.value, postPage);
      } else {
        response = await dataProvider.getAllPost(postPage);
      }

      for (int x = 0; x < response.length; x++) {
        Post _post = Post.fromJSON(response[x]);
        postList.add(_post);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> getUserPost(String id) async {
    if (isLoading) return;
    isLoading = true;
    postPage++;
    try {
      var response = await dataProvider.getPostUser(id, postPage);

      for (int x = 0; x < response.length; x++) {
        Post _post = Post.fromJSON(response[x]);
        userPostList.add(_post);
        filteredPostList.add(_post);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> filterUserPost(String filter) async {
    if (filter == "") filteredPostList.value = userPostList.value;
    filteredPostList.value = userPostList.value
        .where((element) => element.text.contains(filter))
        .toList();
  }
}
