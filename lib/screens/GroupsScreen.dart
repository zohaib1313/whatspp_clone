import 'package:flash_chat/Models/Users.dart';

import 'package:flutter/material.dart';

import 'Widgets/MyWidgets.dart';

var listOfUsersInChat = List<MyUser>.empty(growable: true);

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    listOfUsersInChat.clear();
    listOfUsersInChat.add(MyUser(
        id: "",
        name: "zohaib",
        profileImage: "none",
        phoneNumber: "03062196778"));

    return Scaffold(
      appBar:  MyWidgets.buildAppBar(),
      body: Container(
        child: ListView.builder(
            itemCount: listOfUsersInChat.length,
            itemBuilder: (context, item) {
              return Container();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.message),
      ),
    );
  }
}
