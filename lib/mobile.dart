import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

import 'tab_options.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  int nn = 2;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenItems,
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
          inactiveColor: Colors.grey,
          activeColor: Colors.black,
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.only(top: 3.0, right: 0),
                  // child: Icon(MyFlutterApp.home, size: 23.5),
                  child: Icon(
                    Icons.message,
                  )),
              label: 'Posts',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                  padding: const EdgeInsets.only(top: 3.0, right: 0),
                  // child: Icon(MyFlutterApp.home, size: 23.5),
                  child: Icon(
                    Icons.message,
                  )),
              label: 'Posts 2',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Icon(
                  Icons.add_circle,
                ),
              ),
              label: 'Add',
            ),
          ],
          currentIndex: _page,
          onTap: navigationTapped),
    );
  }
}
