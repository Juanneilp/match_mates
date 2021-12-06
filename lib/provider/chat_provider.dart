import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_mates/model/data_dummy.dart';

class ChatStreamProvider {
  final _firestore = FirebaseFirestore.instance;
  Stream<List<TextChat>> getlistChat() {
    return _firestore
        .collection('massage')
        .orderBy('time', descending: false)
        .snapshots()
        .map((event) => event.docs
            .map((e) => TextChat(
                chatString: e.get('text'),
                user: e.get('user'),
                date: e.get('time')))
            .toList());
  }

  void adduser(String text, String user, Timestamp time) {
    _firestore.collection('massage').add({
      'text': text,
      'user': user,
      'time': time,
    });
  }
}
