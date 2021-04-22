import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String id;
  String name;
  String profileImage;
  String phoneNumber;
  MyUser({this.id, this.name, this.profileImage, this.phoneNumber});

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profileImage': profileImage,
      'phoneNumber': phoneNumber,
    };
  }

  factory MyUser.fromMap(Map<String, dynamic> map) {
    return MyUser(
      id: map['id'],
      name: map['name'],
      profileImage: map['profileImage'],
      phoneNumber: map['phoneNumber'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MyUser.fromJson(String source) => MyUser.fromMap(json.decode(source));

  factory MyUser.fromDoucument(DocumentSnapshot documentSnapshot) {
    return MyUser(
      id: documentSnapshot.id,
      name: documentSnapshot['name'],
      profileImage: documentSnapshot['profileImage'],
      phoneNumber: documentSnapshot['phoneNumber'],
    );
  }


  

  @override
  String toString() {
    return 'User(id: $id, name: $name, profileImage: $profileImage, phoneNumber: $phoneNumber)';
  }



}
