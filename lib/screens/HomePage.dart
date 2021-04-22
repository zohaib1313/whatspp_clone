import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flash_chat/screens/CallsScreen.dart';
import 'package:flash_chat/screens/CameraScreen.dart';
import 'package:flash_chat/screens/ChatScreenMain.dart';
import 'package:flash_chat/screens/SignUpScreen.dart';
import 'package:flash_chat/screens/StatusScreen.dart';
import 'package:flash_chat/screens/pages/index.dart';
import 'package:flash_chat/utils/SessionManager.dart';
import 'package:flash_chat/utils/Styles.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'GroupsScreen.dart';

class HomeScreen extends StatelessWidget {
  static const String ID = "home_screen";
  final RxInt _currentIndex = 1.obs;

  final listOfSCreens = [
    CameraScreen(),
    ChatScreenMain(),
    GroupScreen(),
    StatusScreen(),
    IndexPage()
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Style.kPrimaryColor,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Style.kSecondaryColor,
        statusBarIconBrightness: Brightness.light));
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Style.kPrimaryColor,
            brightness: Brightness.light,
            accentColor:Style.kPrimaryColor,

            primaryColorDark: Style.kSecondaryColor),
        themeMode: SessionManager.myController.isDark.value
            ? ThemeMode.dark
            : ThemeMode.light,
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Style.kPrimaryColor,
            primaryColorDark: Style.kSecondaryColor),
        home: SessionManager.myController.rXisLoggedIn.value
            ? SafeArea(
                child: Scaffold(
                  body: listOfSCreens[_currentIndex.value],
                  bottomNavigationBar: BottomNavyBar(
                    selectedIndex: _currentIndex.value,
                    backgroundColor: Style.kPrimaryColor,
                    onItemSelected: (index) {
                      _currentIndex.value = index;
                    },
                    items: <BottomNavyBarItem>[
                      BottomNavyBarItem(
                          title: Text('Camera',
                              style: Style.kTextStyleNormal
                                  .copyWith(color: Colors.white)),
                          icon:
                              Icon(Icons.camera, color: Style.kSecondaryColor)),
                      BottomNavyBarItem(
                          title: Text('Chat',
                              style: Style.kTextStyleNormal
                                  .copyWith(color: Colors.white)),
                          icon: Icon(Icons.chat_bubble,
                              color: Style.kSecondaryColor)),
                      BottomNavyBarItem(
                          title: Text('Groups',
                              style: Style.kTextStyleNormal
                                  .copyWith(color: Colors.white)),
                          icon:
                              Icon(Icons.group, color: Style.kSecondaryColor)),
                      BottomNavyBarItem(
                          title: Text('Status',
                              style: Style.kTextStyleNormal
                                  .copyWith(color: Colors.white)),
                          icon: Icon(Icons.rss_feed,
                              color: Style.kSecondaryColor)),
                      BottomNavyBarItem(
                          title: Text('Calls',
                              style: Style.kTextStyleNormal
                                  .copyWith(color: Colors.white)),
                          icon: Icon(Icons.call, color: Style.kSecondaryColor)),
                    ],
                  ),
                ),
              )
            : SignUpScreen(),
      ),
    );
  }
}
