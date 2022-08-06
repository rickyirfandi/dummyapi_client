import 'package:dummyapi_client/data/models/user/user.dart';
import 'package:dummyapi_client/data/providers/data_providers.dart';
import 'package:get/get.dart';

class UserRepository {
  DataProvider dataProvider = DataProvider();
  static RxList<User> userList = <User>[].obs;
  static int userPage = -1;

  bool isLoading = false;

  Future<void> getUser() async {
    if (isLoading) return;
    isLoading = true;
    userPage++;
    try {
      var response = await dataProvider.getUser(userPage);

      for (int x = 0; x < response.length; x++) {
        User user = User.fromJSON(response[x]);
        userList.add(user);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
    }
  }
}
