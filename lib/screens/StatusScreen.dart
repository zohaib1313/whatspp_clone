import 'package:flash_chat/utils/Styles.dart';
import 'package:flutter/material.dart';
import 'package:unicorndial/unicorndial.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Status"),
      ),
      floatingActionButton: getCustomFab(),
      body: ListView(
        children: [
          myStatus(),
          getDivider("Recent updats"),
          getUserStatus(),
          getUserStatus(),
          getUserStatus(),
          getDivider("Viewed updats"),
          getUserStatus(),
          getUserStatus(),
          getUserStatus(),
          getUserStatus(),
          getUserStatus(),
          getUserStatus(),
        ],
      ),
    );
  }

  myStatus() {
    return Container(
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
                    child: Icon(
                      Icons.person,
                      size: 26,
                    ),
                  ),
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
    );
  }

  getDivider(String title) {
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

  getUserStatus() {
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
                      "User name",
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
}
