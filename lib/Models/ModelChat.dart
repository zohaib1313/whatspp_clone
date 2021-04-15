import 'dart:convert';

class ModelChat {
  String id, text, time;
  bool isSent, isRead, isMe;
  Type type;

  ModelChat(
      {this.id,
      this.text,
      this.time,
      this.isSent,
      this.isRead,
      this.isMe,
      this.type});

  factory ModelChat.fromMap(Map<String, dynamic> map) {
    return new ModelChat(
      id: map['id'] as String,
      text: map['text'] as String,
      time: map['time'] as String,
      isSent: map['isSent'] as bool,
      isRead: map['isRead'] as bool,
      isMe: map['isMe'] as bool,
      type: map['type'] as Type,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'text': this.text,
      'time': this.time,
      'isSent': this.isSent,
      'isRead': this.isRead,
      'isMe': this.isMe,
      'type': this.type,
    } as Map<String, dynamic>;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "text": this.text,
      "time": this.time,
      "isSent": this.isSent,
      "isRead": this.isRead,
      "isMe": this.isMe,
      "type": json.encode(this.type),
    };
  }

  factory ModelChat.fromJson(Map<String, dynamic> myJson) {
    return ModelChat(
      id: myJson["id"],
      text: myJson["text"],
      time: myJson["time"],
      isSent: myJson["isSent"].toLowerCase() == 'true',
      isRead: myJson["isRead"],
      isMe: myJson["isMe"],
      type: json.decode(myJson["type"]),
    );
  }

  @override
  String toString() {
    return 'ModelChat{id: $id, text: $text, time: $time, isSent: $isSent, isRead: $isRead, isMe: $isMe, type: $type}';
  }
}

enum Type { image, text, video, audio }
