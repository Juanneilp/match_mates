import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:match_mates/model/data_dummy.dart';

class ChatStreamProvider {
  final String streamTunel;
  ChatStreamProvider({required this.streamTunel});
  final _firestore = FirebaseFirestore.instance;
  Stream<TextChat> getlistChat() {
    return _firestore
        .collection('massage')
        .doc(streamTunel)
        .snapshots()
        .map((event) => TextChat.fromJson(event.data()!));
  }

  void adduser(Chat chat) async {
    await _firestore.collection('massage').doc(streamTunel).update({
      'chat': FieldValue.arrayUnion([chat.toJson()])
    });
  }
}
