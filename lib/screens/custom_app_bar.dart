import 'package:flutter/material.dart';
import 'package:tinder_clone/screens/chat_screen.dart';
import 'package:tinder_clone/screens/screens.dart';
import 'package:tinder_clone/theme/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: getAppBar(),
        body: getBody(),
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        ExplorePage(),
        LikeScreen(),
        ChatScreen(),
        ProfileScreen(),
      ],
    );
  }

  PreferredSizeWidget getAppBar() {
    List bottomItems = [
      pageIndex == 0
          ? "assets/images/explore_active_icon.svg"
          : "assets/images/explore_icon.svg",
      pageIndex == 1
          ? "assets/images/likes_active_icon.svg"
          : "assets/images/likes_icon.svg",
      pageIndex == 2
          ? "assets/images/chat_active_icon.svg"
          : "assets/images/chat_icon.svg",
      pageIndex == 3
          ? "assets/images/account_active_icon.svg"
          : "assets/images/account_icon.svg",
    ];
    return AppBar(
      backgroundColor: white,
      elevation: 0,
      title: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              bottomItems.length,
              (index) {
                return IconButton(
                  onPressed: () {
                    setState(
                      () {
                        pageIndex = index;
                      },
                    );
                  },
                  icon: SvgPicture.asset(
                    bottomItems[index],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
