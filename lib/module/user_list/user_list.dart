import 'package:dummyapi_client/const/color.dart';
import 'package:dummyapi_client/const/text_style.dart';
import 'package:dummyapi_client/data/repository/user/user.dart';
import 'package:dummyapi_client/module/user_detail/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserList extends StatefulWidget {
  UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final ScrollController _scrollController = ScrollController();
  UserRepository user = UserRepository();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double margin = 300.0;
      if (maxScroll - currentScroll <= margin) {
        user.getUser();
      }
    });
  }

  void _onRefresh() async {
    user.refresh();
    await user.getUser();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Users",
          style: reguler16.copyWith(color: kPrimaryColor),
        ),
      ),
      body: Obx(
        () => SmartRefresher(
          enablePullDown: true,
          controller: _refreshController,
          header: const WaterDropMaterialHeader(),
          onRefresh: _onRefresh,
          child: ListView.builder(
            controller: _scrollController,
            itemCount: UserRepository.userList.value.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  UserRepository.selectedUser.value =
                      UserRepository.userList.value[index].id;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserDetail()),
                  );
                },
                child: ListTile(
                  leading: SizedBox(
                    height: 56,
                    width: 56,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          UserRepository.userList.value[index].picture),
                    ),
                  ),
                  title: Text(
                    UserRepository.userList.value[index].getFullName(),
                    style: reguler15.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    UserRepository.userList.value[index].title,
                    style: reguler15.copyWith(fontWeight: FontWeight.bold),
                  ),
                  trailing: const HeroIcon(
                    HeroIcons.chevronRight,
                    solid: true,
                    size: 22,
                    color: kPrimaryColor,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
