import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/screens/UsersScreen.dart';
import 'package:flash_chat/utils/SessionManager.dart';
import 'package:flash_chat/utils/Styles.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'Widgets/MyWidgets.dart';

class ChatScreenMain extends StatefulWidget {
  static const String ID = "chat_screen";

  @override
  _ChatScreenMainState createState() => _ChatScreenMainState();
}

class _ChatScreenMainState extends State<ChatScreenMain> {

  @override
  Widget build(BuildContext context) {
    //
    // if (snapshot.hasData) {
    //   return ListView(
    //       shrinkWrap: true,
    //       reverse: true,
    //       children: snapshot.data.docs.map((documetnSnap) {
    //         print(documetnSnap.toString() +" ......");
    //         return MyWidgets.getUseChatRow(MyUser.fromDoucument(documetnSnap));
    //       }).toList());
    // } else {
    //   return MyWidgets.spinkit;
    // }
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


        if(snapshot.connectionState==ConnectionState.waiting){
          return MyWidgets.showLoading;
        }else if ( snapshot.connectionState==ConnectionState.done){
          if (snapshot.hasData) {
            // print(snapshot.data.data().values);
            snapshot.data.data().values.forEach((element) {
              print(element);
            });

            // FirebaseFirestore.instance.collection("Chats").doc(
            //     FirebaseAuth.instance.currentUser.uid).collection(
            //     FirebaseAuth.instance.currentUser.uid).get().then((snap) {
            //   snap.docs.forEach((element) {
            //     print(element.id);
            //   });
            // });

            //  print(otherUserId.id);
            return ListView(
                children: snapshot.data.data().values.map((document) {
                  return Container();
                }).toList());
          } else {
            print("loading");
            return MyWidgets.showLoading;
          }
        }else{
          return MyWidgets.showLoading;
        }


          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => UsersScreen());
        },
        child: Icon(Icons.message),
      ),
    );
  }
}

