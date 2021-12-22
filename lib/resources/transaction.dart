import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionBase {
  final _firestore = FirebaseFirestore.instance;
  Future<dynamic> createTransaction(
      String recive, String sender, int value) async {
    var sellers = _firestore.collection('users').doc(recive);
    var user = _firestore.collection('users').doc(sender);
    await _firestore.collection('transaction').add({
      'sellersuid': recive,
      'senderuid': sender,
    });
    await sellers.update({
      'token': FieldValue.increment(value),
    });
    await user.update(
      {'token': FieldValue.increment(-value)},
    );
  }
}
