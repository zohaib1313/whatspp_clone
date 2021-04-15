import 'package:flash_chat/Models/ModelChat.dart';
import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/utils/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:bubble/bubble.dart';
import 'package:get/get.dart';

class ChatUserScreen extends StatelessWidget {
  final MyUser otherUser;

  final controllerMessageToSend = TextEditingController();

  ChatUserScreen(this.otherUser);

  final RxString messageToSent = "".obs;
  final RxList<ModelChat> listOfChat = List<ModelChat>.empty(growable: true).obs;
final  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {


    listOfChat.add(ModelChat(
        id: "",
        text: "hellow how ",
        isRead: true,
        isMe: true,
        isSent: true,
        time: "10 january ",
        type: Type.text));

    listOfChat.add(ModelChat(
        id: "",
        text: "hellow how ",
        isRead: true,
        isMe: false,
        isSent: true,
        time: "10 january ",
        type: Type.text));

    if (_scrollController.hasClients) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }



    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backwardsCompatibility: true,
          leading: Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircleAvatar(
              backgroundImage: otherUser.profileImage == ''
                  ? Image.asset("assets/images/place_holder.png").image
                  : Image.network(otherUser.profileImage).image,
            ),
          ),
          title: Text(otherUser.name),
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
                  child: Obx(
                    () => ListView.builder(

                      controller: _scrollController,
                      itemCount: listOfChat.length,
                      itemBuilder: (item, index) {
                        return getChatBubble(listOfChat[index]);
                      },
                    ),
                  ),
                ),
              ),
              Material(
                elevation: 0,
                color: Colors.white.withOpacity(0.7),
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
                                    onTap: () {
                                      ModelChat modelChat = ModelChat(
                                          id: "",
                                          type: Type.text,
                                          time: "10 january",
                                          isMe: true,
                                          text: controllerMessageToSend.text,
                                          isRead: false,
                                          isSent: true);
                                      listOfChat.add(modelChat);
                                      controllerMessageToSend.clear();
                                      messageToSent.value="";

                                      if (_scrollController.hasClients) {
                                        SchedulerBinding.instance.addPostFrameCallback((_) {
                                          _scrollController.animateTo(
                                            _scrollController.position.maxScrollExtent,
                                            duration: const Duration(milliseconds: 300),
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

  getChatBubble(ModelChat modelChat) {
    return !modelChat.isMe
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
