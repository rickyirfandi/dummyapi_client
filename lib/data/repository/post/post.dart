import 'package:dummyapi_client/data/models/post/post.dart';
import 'package:dummyapi_client/data/models/user/user.dart';
import 'package:dummyapi_client/data/providers/data_providers.dart';
import 'package:get/get.dart';

class PostRepository {
  DataProvider dataProvider = DataProvider();
  static RxList<Post> postList = <Post>[].obs;
  static int postPage = -1;

  bool isLoading = false;

  void refresh() {
    postPage = -1;
    postList.clear();
    isLoading = false;
  }

  Future<void> getPost() async {
    if (isLoading) return;
    isLoading = true;
    postPage++;
    try {
      var response = await dataProvider.getAllPost(postPage);

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
}
