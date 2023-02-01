import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:search_my_class/constants.dart';
import 'package:search_my_class/services/firebase_services.dart';
import 'package:search_my_class/tabs/account_tab.dart';
import 'package:search_my_class/tabs/home_tab.dart';
import 'package:search_my_class/tabs/saved_tab.dart';
import 'package:search_my_class/tabs/search_tab.dart';
import 'package:search_my_class/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabsPageController;
  int _selectedTab = 0;
  @override
  void initState() {
    print("Current User Id: ${_firebaseServices.getUserId()}");//get user id of the current user Logged in
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num){
                setState(() {
                  _selectedTab = num;
                 // print("Selected Tab: ${_selectedTab}");
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                SavedTab(),
                AccountTab(),
              ],
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num){
              setState(() {
                _tabsPageController.animateToPage(num, duration: Duration(milliseconds: 500), curve: Curves.easeOutCubic);
              });
            },
          ),
        ],
      ),
    );
  }
}
