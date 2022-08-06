import 'package:dummyapi_client/const/color.dart';
import 'package:dummyapi_client/const/text_style.dart';
import 'package:dummyapi_client/data/repository/post/post.dart';
import 'package:dummyapi_client/data/repository/user/user.dart';
import 'package:dummyapi_client/module/post_list/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostList extends StatefulWidget {
  PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  final ScrollController _scrollController = ScrollController();
  PostRepository post = PostRepository();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    post.refresh();
    post.getPost();
    super.initState();
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double margin = 300.0;
      if (maxScroll - currentScroll <= margin) {
        post.getPost();
      }
    });
  }

  void _onRefresh() async {
    post.refresh();
    await post.getPost();
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
            itemCount: PostRepository.postList.value.length,
            itemBuilder: (context, index) {
              return CardPost(post: PostRepository.postList.value[index]);
              return GestureDetector(
                onTap: () {},
                child: ListTile(
                  leading: SizedBox(
                    height: 56,
                    width: 56,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                          PostRepository.postList.value[index].image),
                    ),
                  ),
                  title: Text(
                    PostRepository.postList.value[index].text,
                    style: reguler15.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    PostRepository.postList.value[index].tags[0],
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
