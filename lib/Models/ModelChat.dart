import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ModelChat {
  String id, text, time;
  String deliveryType;
  bool isSent, isRead;
  String type;

  ModelChat(
      {this.id,
      this.text,
      this.time,
      this.deliveryType,

      this.isSent,
      this.isRead,

      this.type});

  factory ModelChat.fromDoucument(DocumentSnapshot documentSnapshot) {
    return ModelChat(
      id: documentSnapshot.id,
      text: documentSnapshot['text'] as String,
      time: documentSnapshot['time'] as String,
      deliveryType: documentSnapshot['fromKey'] as String,

      isSent: documentSnapshot['isSent'] as bool,
      isRead: documentSnapshot['isRead'] as bool,

      type: documentSnapshot['type'],
    );
  }

  factory ModelChat.fromMap(Map<String, dynamic> map) {
    return new ModelChat(
      id: map['id'] as String,
      deliveryType: map['fromKey'] as String,
      isRead: map['isRead'] as bool,
      type: map['type'] ,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'text': this.text,
      'time': this.time,
      'fromKey': this.deliveryType,
      'isSent': this.isSent,
      'isRead': this.isRead,
      'type': this.type,
    } as Map<String, dynamic>;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "text": this.text,
      'fromKey': this.deliveryType,

      "time": this.time,
      "isSent": this.isSent,
      "isRead": this.isRead,

      "type": json.encode(this.type),
    };
  }

  factory ModelChat.fromJson(Map<String, dynamic> myJson) {
    return ModelChat(
      id: myJson["id"],
      text: myJson["text"],
      time: myJson["time"],
      deliveryType: myJson['fromKey'],
      isSent: myJson["isSent"].toLowerCase() == 'true',
      isRead: myJson["isRead"],
      type: json.decode(myJson["type"]),
    );
  }

  @override
  String toString() {
    return 'ModelChat{id: $id, text: $text, time: $time, fromKey: $deliveryType isSent: $isSent, isRead: $isRead, type: $type}';
  }
}

