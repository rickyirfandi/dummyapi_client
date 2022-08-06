import 'package:dummyapi_client/const/color.dart';
import 'package:dummyapi_client/const/text_style.dart';
import 'package:dummyapi_client/data/models/user/user_detail.dart';
import 'package:dummyapi_client/data/repository/post/post.dart';
import 'package:dummyapi_client/data/repository/user/user.dart';
import 'package:dummyapi_client/module/post_list/widgets/post_card.dart';
import 'package:dummyapi_client/module/user_detail/widgets/text_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({Key? key}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  TextEditingController controller = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  UserRepository userReposiroty = UserRepository();
  PostRepository postRepository = PostRepository();

  late UserData user;
  RxBool isLoaded = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postRepository.refresh();
    loadUser();
    controller.addListener(() {
      postRepository.filterUserPost(controller.text);
      print("filter ${controller.text}");
    });
  }

  void loadUser() async {
    user = await userReposiroty.getUserData();
    postRepository.getUserPost(user.id);
    isLoaded.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const CircleAvatar(
            backgroundColor: kBackButton,
            child: HeroIcon(
              HeroIcons.chevronLeft,
              solid: true,
              size: 16,
              color: kGrey,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Detail",
          style: reguler15.copyWith(color: kPrimaryColor),
        ),
      ),
      body: Obx(
        () => Container(
          child: (isLoaded.value == true) ? Profile() : Text("Please wait"),
        ),
      ),
    );
  }

  Widget Profile() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          User(),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                controller: _scrollController,
                itemCount: PostRepository.filteredPostList.value.length,
                itemBuilder: (context, index) {
                  return CardPost(
                      post: PostRepository.filteredPostList.value[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget User() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(user.picture),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${user.getFullName()} (${user.title})",
                    style: reguler18.copyWith(color: kPrimaryColor),
                  ),
                  Text(
                    user.email,
                    style: reguler15.copyWith(color: kPrimaryColor),
                  ),
                  Text(
                    user.getBirthDate(),
                    style: reguler15.copyWith(color: kPrimaryColor),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            "Join : ${user.getJoinDate()}",
            style: reguler15.copyWith(color: kPrimaryColor),
          ),
          Text(
            "Gender : ${user.gender}",
            style: reguler15.copyWith(color: kPrimaryColor),
          ),
          Text(
            "Address : ${user.location.address()}",
            style: reguler15.copyWith(color: kPrimaryColor),
          ),
          const SizedBox(
            height: 12,
          ),
          TextSearch(
            title: "Search in ${user.firstName}'s post",
            controller: controller,
          ),
        ],
      ),
    );
  }
}
