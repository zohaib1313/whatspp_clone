import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/Models/ModelChat.dart';
import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/utils/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:bubble/bubble.dart';
import 'package:get/get.dart';

import 'Widgets/MyWidgets.dart';

class ChatUserScreen extends StatelessWidget {
  final MyUser otherUser;

  final controllerMessageToSend = TextEditingController();

  ChatUserScreen(this.otherUser);

  final RxString messageToSent = "".obs;

  // final RxList<ModelChat> listOfChat =
  //     List<ModelChat>.empty(growable: true).obs;

  final ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    final Query chatSnapRef = FirebaseFirestore.instance
        .collection('Chats')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection(otherUser.id)
        .orderBy("time", descending: true);

    if (_scrollController.hasClients) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
    return Material(
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: -20,
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: otherUser.profileImage == ''
                      ? Image.asset("assets/images/place_holder.png").image
                      : Image.network(otherUser.profileImage).image,
                ),
              ),
              Text(otherUser.name),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.videocam),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.call),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.menu),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/chat.jpg"))),
          child: Column(
            children: [
              Expanded(
                child: Container(
                    color: Colors.white.withOpacity(0.5),
                    child: StreamBuilder(
                        stream: chatSnapRef.snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView(
                                shrinkWrap: true,
                                reverse: true,
                                controller: _scrollController,
                                children:
                                    snapshot.data.docs.map((documetnSnap) {
                                  ModelChat chatModel =
                                      ModelChat.fromDoucument(documetnSnap);

                                  return getChatBubble(chatModel);
                                }).toList());
                          } else {
                            return MyWidgets.spinkit;
                          }
                        })),
              ),
              Material(
                elevation: 0,
                child: Container(
                    constraints: BoxConstraints(
                        minWidth: double.infinity, maxHeight: 150),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.emoji_emotions_outlined,
                            size: 26,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.attachment_outlined,
                            size: 26,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              controller: controllerMessageToSend,
                              onChanged: (text) {
                                messageToSent.value = text;
                              },
                              style: Style.kTextStyleNormal,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: "Enter message to send...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Obx(
                            () => messageToSent.value.isEmpty
                                ? GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.mic,
                                      size: 26,
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () async {
                                      ModelChat modelChat = ModelChat(
                                          id: FirebaseAuth
                                              .instance.currentUser.uid,
                                          type: "Text",
                                          time: DateTime.now()
                                              .toLocal()
                                              .toString(),
                                          text: controllerMessageToSend.text,
                                          isRead: false,
                                          isSent: true);

                                      controllerMessageToSend.clear();


                                      modelChat.deliveryType = "Sent";
                                      await FirebaseFirestore.instance
                                          .collection("Chats")
                                          .doc(FirebaseAuth
                                              .instance.currentUser.uid)
                                          .set({
                                        otherUser.id: {
                                          "id": otherUser.id,
                                          "name": "areeba",
                                          "image": "imageeee",
                                          "lastMessage": messageToSent.value

                                        }
                                      }, SetOptions(merge: true));
                                      //     .set({
                                      //   "collectionsId": FieldValue.arrayUnion(
                                      //     [
                                      //       {
                                      //         otherUser.id:
                                      //         otherUser.id
                                      //       }
                                      //     ],
                                      //   )
                                      // });
                                      await FirebaseFirestore.instance
                                          .collection("Chats")
                                          .doc(FirebaseAuth
                                              .instance.currentUser.uid)
                                          .collection(otherUser.id)
                                          .add(modelChat.toMap());

                                      modelChat.deliveryType = "Received";
                                      await FirebaseFirestore.instance
                                          .collection("Chats")
                                          .doc(otherUser.id)
                                          //     .set({
                                          //   "collectionsId": FieldValue.arrayUnion(
                                          //     [
                                          //       {
                                          //         FirebaseAuth.instance.currentUser.uid:
                                          //         FirebaseAuth.instance.currentUser.uid
                                          //       }
                                          //     ],
                                          //   )
                                          // });
                                          .set({
                                        FirebaseAuth.instance.currentUser.uid:
                                        {
                                          "id":FirebaseAuth.instance.currentUser.uid,
                                          "name": "zohaib",
                                          "image": "imageeee",
                                          "lastMessage": messageToSent.value
                                        }
                                      }, SetOptions(merge: true));
                                      // .set({FirebaseAuth.instance.currentUser.uid: FirebaseAuth.instance.currentUser.uid});

                                      await FirebaseFirestore.instance
                                          .collection("Chats")
                                          .doc(otherUser.id)
                                          .collection(FirebaseAuth
                                              .instance.currentUser.uid)
                                          .add(modelChat.toMap());
                                      messageToSent.value = "";
                                      if (_scrollController.hasClients) {
                                        SchedulerBinding.instance
                                            .addPostFrameCallback((_) {
                                          _scrollController.animateTo(
                                            _scrollController
                                                .position.minScrollExtent,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                        });
                                      }
                                    },
                                    child: Icon(
                                      Icons.send,
                                      size: 26,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getChatBubble(ModelChat modelChat) {
    return modelChat.deliveryType != "Sent"
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Bubble(
              elevation: 10,
              alignment: Alignment.topLeft,
              nip: BubbleNip.leftTop,
              color: Color.fromRGBO(212, 234, 244, 1.0),
              child: Text(modelChat.text,
                  textAlign: TextAlign.center,
                  style: Style.kTextStyleNormal.copyWith(fontSize: 14)),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Bubble(
              elevation: 10,
              alignment: Alignment.topRight,
              nip: BubbleNip.rightTop,
              color: Color.fromRGBO(212, 234, 244, 1.0),
              child: Text(modelChat.text,
                  textAlign: TextAlign.center,
                  style: Style.kTextStyleNormal.copyWith(fontSize: 14)),
            ),
          );
  }
}
