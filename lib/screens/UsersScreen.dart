import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/screens/ChatScreenMain.dart';
import 'package:flash_chat/screens/ChatUserScreen.dart';
import 'package:flash_chat/screens/Widgets/MyWidgets.dart';
import 'package:flash_chat/utils/Styles.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

final List<MyUser> listOfUsers = List.empty(growable: true);

class UsersScreen extends StatelessWidget {
  final Query users =
      FirebaseFirestore.instance.collection('Users');
          //.where("id",isNotEqualTo: FirebaseAuth.instance.currentUser.uid);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select Contact',
                style: Style.kTextStyleBol,
              ),
              Text("${listOfUsers.length} contacts",
                  style: Style.kTextStyleNormal.copyWith(fontSize: 12))
            ],
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(
                      context: context, delegate: DataSearch(listOfUsers));
                })
          ],
        ),
        body: StreamBuilder(
          stream: users.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              listOfUsers.clear();
              return ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                MyUser myUser = MyUser.fromDoucument(document);
                listOfUsers.add(myUser);
                return GestureDetector(
                    onTap: () {
                      Get.to(() => ChatUserScreen(myUser));
                    },
                    child: MyWidgets.getUserRow(myUser));
              }).toList());
            } else {
              return MyWidgets.spinkit;
            }
          },
        ),
      ),
    );
  }
}

class DataSearch extends SearchDelegate<MyUser> {
  final List<MyUser> listWords;

  DataSearch(this.listWords);

  @override
  List<Widget> buildActions(BuildContext context) {
    //Actions for app bar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //leading icon on the left of the app bar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Center(
      child: Text(query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty
        ? listOfUsers
        : listOfUsers.where((p) => p.name.startsWith(query)).toList();

    return ListView.builder(
      itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            print(suggestionList[index].name);
            Get.to(ChatUserScreen(suggestionList[index]));
          },
          child: MyWidgets.getUserRow(suggestionList[index])),
      itemCount: suggestionList.length,
    );
  }
}
