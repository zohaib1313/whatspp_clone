import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flash_chat/screens/CallsScreen.dart';
import 'package:flash_chat/screens/CameraScreen.dart';
import 'package:flash_chat/screens/ChatScreenMain.dart';
import 'package:flash_chat/screens/SignUpScreen.dart';
import 'package:flash_chat/screens/StatusScreen.dart';
import 'package:flash_chat/utils/SessionManager.dart';

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
    CallScreen()
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue,
      statusBarBrightness: Brightness.light,
    ));
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: SessionManager.myController.isDark.value
            ? ThemeData.dark()
            : ThemeData.light(),
        home: SessionManager.myController.rXisLoggedIn.value
            ? SafeArea(
                child: Scaffold(
                  body: listOfSCreens[_currentIndex.value],
                  bottomNavigationBar: BottomNavyBar(
                    selectedIndex: _currentIndex.value,
                    onItemSelected: (index) {
                      _currentIndex.value = index;
                    },
                    items: <BottomNavyBarItem>[
                      BottomNavyBarItem(
                          title: Text('Camera'), icon: Icon(Icons.camera)),
                      BottomNavyBarItem(
                          title: Text('Chat'), icon: Icon(Icons.chat_bubble)),
                      BottomNavyBarItem(
                          title: Text('Groups'), icon: Icon(Icons.group)),
                      BottomNavyBarItem(
                          title: Text('Status'), icon: Icon(Icons.rss_feed)),
                      BottomNavyBarItem(
                          title: Text('Calls'), icon: Icon(Icons.call)),
                    ],
                  ),
                ),
              )
            : SignUpScreen(),
      ),
    );
  }
}

// getWidget(int selectedIndex) {
// switch (selectedIndex) {
//   case 0:
//     return CameraScreen();
//     break;
//   case 1:
//     return ChatScreen();
//     break;
//   case 2:
//     return GroupScreen();
//     break;
//   case 3:
//     return StatusScreen();
//     break;

//   case 4:
//     return CallScreen();
//     break;

//   default:
//     return Container(color: Colors.blue);
// }
//}
