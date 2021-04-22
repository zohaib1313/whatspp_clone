import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flash_chat/Models/ModelStatus.dart';
import 'package:flash_chat/Models/Users.dart';
import 'package:flash_chat/screens/Widgets/MyWidgets.dart';
import 'package:flash_chat/utils/SessionManager.dart';
import 'package:flash_chat/utils/Styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicorndial/unicorndial.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class StatusScreen extends StatelessWidget {
  final showLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Status"),
      ),
      floatingActionButton: getCustomFab(),
      body: Obx(() => showLoading.value
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myStatus(context),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Status")
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
                        return Column(
                          children: [
                            getDivider("Recent Updates", context),
                            ListView(
                              shrinkWrap: true,
                              children: snapshot.data.docs.map((document) {
                                print(
                                    ModelStatus.fromDocumentSnapShot(document));
                                return MyWidgets.getStatusRow(
                                    ModelStatus.fromDocumentSnapShot(document));
                                //Container(child: Text("Asdfsd"),);
                              }).toList(),
                            ),
                          ],
                        );
                        // snapshot.data.docs.map((document) {
                        //   print(ModelStatus.fromDocumentSnapShot(document));
                        // });

                      } else {
                        return getDivider("No Recent Update", context);
                      }
                    })
              ],
            )),
    );
  }

  getDivider(String title, BuildContext context) {
    return Card(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: Style.kTextStyleBol,
        ),
      ),
    );
  }

  myStatus(BuildContext context) {
    return GestureDetector(
      onTap: () => _settingModalBottomSheet(context),
      child: Container(
        padding:
            const EdgeInsets.only(left: 5.0, right: 3.0, top: 8.0, bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CircleAvatar(
                        backgroundImage:
                            SessionManager.getCurrentUser().profileImage == ""
                                ? Image.asset("assets/images/place_holder.png")
                                    .image
                                : Image.network(SessionManager.getCurrentUser()
                                        .profileImage)
                                    .image),
                  ),
                  Positioned.fill(
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          child: Icon(
                            Icons.add,
                            size: 16,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                        )),
                  )
                ],
              ),
            ),
            Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My status",
                        style: Style.kTextStyleBol,
                      ),
                      Text("Tap to add status update",
                          style: Style.kTextStyleNormal),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  getUserStatus(String image, MyUser myUser) {
    return Container(
      padding:
          const EdgeInsets.only(left: 5.0, right: 3.0, top: 8.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: CircleAvatar(
              child: Icon(
                Icons.person,
                size: 26,
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      myUser.name,
                      style: Style.kTextStyleBol,
                    ),
                    Text("30 minutes ago", style: Style.kTextStyleNormal),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  getCustomFab() {
    List<UnicornButton> childButtons = [];
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Camera",
        currentButton: FloatingActionButton(
          heroTag: "Camera",
          mini: true,
          child: Icon(Icons.camera),
          onPressed: () {},
        )));

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Text",
        currentButton: FloatingActionButton(
          heroTag: "Text",
          mini: true,
          child: Icon(Icons.text_fields),
          onPressed: () {},
        )));
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Galllery",
        currentButton: FloatingActionButton(
          heroTag: "Galllery",
          mini: true,
          child: Icon(Icons.photo_album),
          onPressed: () {},
        )));

    return UnicornDialer(
        backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
        orientation: UnicornOrientation.VERTICAL,
        parentButton: Icon(Icons.add),
        childButtons: childButtons);
  }

  void _settingModalBottomSheet(context) {
    showMaterialModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Wrap(
                direction: Axis.horizontal,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Chose options",
                        style: Style.kTextStyleBol,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.camera),
                                Text("Camera"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => getImage(),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Icon(Icons.photo_album),
                                  Text("Gallery"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(Icons.text_fields),
                                Text("Text"),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future getImage() async {
    showLoading.value = true;
    Get.back();
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print(pickedFile.path);

      FirebaseStorage.instance
          .ref()
          .child("Users")
          .child(SessionManager.getCurrentUser().id)
          .child("StatusImages")
          .child(File(pickedFile.path).uri.pathSegments.last)
          .putFile(File(pickedFile.path))
          .then((snapShot) {
        if (snapShot.state == TaskState.success) {
          snapShot.ref.getDownloadURL().then((downloadUrl) {
            var modelStatus = ModelStatus(
                image: downloadUrl.toString(),
                type: "Image",
                dateTime: DateTime.now().toLocal().toString(),
                isWatched: false,
                myUser: SessionManager.getCurrentUser());

            FirebaseFirestore.instance
                .collection("Status")
                .add(modelStatus.toMap())
                .then((value) {
              showLoading.value = false;
              Get.snackbar("Status Uploaded", "",
                  backgroundColor: Style.kPrimaryColor,
                  colorText: Style.kSecondaryColor);
            });
          }).catchError((error) => print("Failed to add user: $error"));
        } else {
          showLoading.value = false;
          Get.snackbar("uploading failed", "",
              backgroundColor: Style.kPrimaryColor,
              colorText: Style.kSecondaryColor);
        }
      });
    } else {
      print('No image selected.');
    }
  }
}
