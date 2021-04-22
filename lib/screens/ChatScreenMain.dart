import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/screens/ChatUserScreen.dart';
import 'package:flash_chat/screens/UsersScreen.dart';
import 'package:flash_chat/utils/SessionManager.dart';
import 'package:flash_chat/utils/Styles.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'Widgets/MyWidgets.dart';


class ChatScreenMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyWidgets.buildAppBar(),
      body: Container(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Chats')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

            print(snapshot.data.isBlank);

            if (snapshot.hasData && snapshot.data.data()!=null) {
              return ListView(
                  children: snapshot.data.data().values.map((document) {

                    print(document);
                    var id=document["id"];
                    var name=document["name"];
                    var image=document["image"];
                    var dateTime=document["dateTime"];
                    var lastMessage=document["lastMessage"];

                    return GestureDetector(
                      onTap:()=>Get.to(() => ChatUserScreen(MyUser(id: id,name:name,profileImage: image))) ,
                      child: Container(
                  child: MyWidgets.getUseChatRow(name: name,image: image,lastMessage: lastMessage,timeDate: dateTime),
                ),
                    );
              }).toList());
            } else {
              return Center(
                child: Container(
                  child: Text("No Chat"),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,

        onPressed: () {
          Get.to(() => UsersScreen());
        },
        child: Icon(Icons.message,color: Style.kSecondaryColor,),
      ),
    );
  }
}
