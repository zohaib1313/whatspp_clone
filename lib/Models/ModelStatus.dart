import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/Models/Users.dart';

class ModelStatus {
  String image, dateTime;
  bool isWatched;
  MyUser myUser;
  String type;

  ModelStatus(
      {this.image, this.dateTime, this.isWatched, this.myUser, this.type});

  Map<String, dynamic> toJson() {
    return {
      "image": this.image,
      "dateTime": this.dateTime,
      "isWatched": this.isWatched,
      "myUser": this.myUser,
      "type": this.type,
    };
  }

  factory ModelStatus.fromJson(Map<String, dynamic> json) {
    return ModelStatus(
      image: json["image"],
      dateTime: json["dateTime"],
      type: json["type"],
      isWatched: json["isWatched"].toLowerCase() == 'true',
      myUser: MyUser.fromJson(json["myUser"]),
    );
  }

  factory ModelStatus.fromMap(Map<String, dynamic> map) {
    return new ModelStatus(
      image: map['image'] as String,
      dateTime: map['dateTime'] as String,
      isWatched: map['isWatched'] as bool,
      type: map['type'] as String,
      myUser: MyUser.fromMap(map['myUser']),
    );
  }

//
  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'image': this.image,
      'type': this.type,
      'dateTime': this.dateTime,
      'isWatched': this.isWatched,
      'myUser': this.myUser.toMap(),
    } as Map<String, dynamic>;
  }

  factory ModelStatus.fromDocumentSnapShot(DocumentSnapshot documentSnapshot) {
    return new ModelStatus(
      image: documentSnapshot['image'] as String,
      dateTime: documentSnapshot['dateTime'] as String,
      type: documentSnapshot['type'] as String,
      isWatched: documentSnapshot['isWatched'] as bool,
      myUser: MyUser.fromMap(documentSnapshot['myUser']),
    );
  }

  @override
  String toString() {
    return 'ModelStatus{image: $image, dateTime: $dateTime, isWatched: $isWatched, myUser: $myUser, type: $type}';
  }
}
