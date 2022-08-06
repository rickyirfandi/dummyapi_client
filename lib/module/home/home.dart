import 'package:dummyapi_client/const/color.dart';
import 'package:dummyapi_client/const/text_style.dart';
import 'package:dummyapi_client/data/repository/user/user.dart';
import 'package:dummyapi_client/module/post_list/post_list.dart';
import 'package:dummyapi_client/module/user_list/user_list.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserRepository userRepository = UserRepository();

  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            UserList(),
            PostList(),
            const SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 26,
                    width: 26,
                    child: HeroIcon(
                      HeroIcons.userGroup,
                      solid: (_selectedIndex == 0) ? true : false,
                      size: 16,
                      color: (_selectedIndex == 0)
                          ? kPrimaryColor
                          : kInactiveBottomNavButton,
                    ),
                  ),
                ],
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 26,
                    width: 26,
                    child: HeroIcon(
                      HeroIcons.annotation,
                      solid: (_selectedIndex == 1) ? true : false,
                      size: 16,
                      color: (_selectedIndex == 1)
                          ? kPrimaryColor
                          : kInactiveBottomNavButton,
                    ),
                  ),
                ],
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(top: 3.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 26,
                    width: 26,
                    child: HeroIcon(
                      HeroIcons.heart,
                      solid: (_selectedIndex == 2) ? true : false,
                      size: 16,
                      color: (_selectedIndex == 2)
                          ? kPrimaryColor
                          : kInactiveBottomNavButton,
                    ),
                  ),
                ],
              ),
            ),
            label: "",
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColor,
      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    userRepository.getUser();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _selectedIndex = page;
    });
  }
}
