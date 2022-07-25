import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppie_app/provider/user_detail_provider.dart';
import 'package:shoppie_app/resources/cloud_firestore_methods.dart';
import 'package:shoppie_app/utils/color_themes.dart';
import 'package:shoppie_app/utils/constants.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  changePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    CloudFirestoreClass().getNameAndAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<UserDetailsProvider>(context).getData();
    return DefaultTabController(
      // tab controller must use
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            children: screens,
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey[500]!))),
            child: TabBar(
              indicator: BoxDecoration(
                  // BNB top line
                  border: Border(
                      top: BorderSide(color: activeCyanColor, width: 4))),
              onTap: changePage,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  child: Icon(
                    Icons.home_outlined,
                    color: currentPage == 0 ? activeCyanColor : Colors.black,
                  ),
                ),
                Tab(
                  child: Icon(Icons.account_circle_outlined,
                      color: currentPage == 1 ? activeCyanColor : Colors.black),
                ),
                Tab(
                  child: Icon(Icons.shopping_cart_outlined,
                      color: currentPage == 2 ? activeCyanColor : Colors.black),
                ),
                Tab(
                  child: Icon(Icons.menu,
                      color: currentPage == 3 ? activeCyanColor : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
