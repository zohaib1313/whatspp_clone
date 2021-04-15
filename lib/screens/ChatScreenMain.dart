import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/screens/UsersScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Widgets/MyWidgets.dart';

var listOfUsersInChat = List<MyUser>.empty(growable: true);

class ChatScreenMain extends StatefulWidget {
  static const String ID = "chat_screen";

  @override
  _ChatScreenMainState createState() => _ChatScreenMainState();
}

class _ChatScreenMainState extends State<ChatScreenMain> {
  @override
  Widget build(BuildContext context) {
    listOfUsersInChat.clear();

    return Scaffold(
      appBar: MyWidgets.buildAppBar(),
      body: Container(
        child: ListView.builder(
            itemCount: listOfUsersInChat.length,
            itemBuilder: (context, item) {
              return MyWidgets.getUseChatRow(listOfUsersInChat[item]);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(UsersScreen());
        },
        child: Icon(Icons.message),
      ),
    );
  }
}
