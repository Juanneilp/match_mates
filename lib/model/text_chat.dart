//just for testing it will be deleted when the real data is ready
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

TextChat textChatFromJson(String str) => TextChat.fromJson(json.decode(str));

String textChatToJson(TextChat data) => json.encode(data.toJson());

class TextChat {
  TextChat({
    required this.reciver,
    required this.sender,
    required this.chat,
  });

  String reciver;
  String sender;
  List<Chat> chat;

  factory TextChat.fromJson(Map<String, dynamic> json) => TextChat(
        reciver: json["reciver"],
        sender: json["sender"],
        chat: List<Chat>.from(json["chat"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "reciver": reciver,
        "sender": sender,
        "chat": List<dynamic>.from(chat.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    required this.content,
    required this.createdAt,
    required this.owner,
    required this.type,
  });

  String content;
  Timestamp createdAt;
  String owner;
  String? type;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        content: json["content"],
        createdAt: json["createdAt"],
        owner: json["owner"],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        "content": content,
        "createdAt": createdAt,
        "owner": owner,
        "type": type,
      };
}
